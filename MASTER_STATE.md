# MASTER STATE — CAD Cleanup Pipeline

**Single source of truth.** Read after `START_HERE.md`.

---

## 🏗️ Pipeline architecture (current)

```
RAW DWG/DXF  (client deliverable)
    ↓
ODA File Converter → DXF (R2010 by default)
    ↓
ezdxf.recover.readfile + doc.audit()
    ↓
Phase 1: xref bind (ezdxf.xref.load_modelspace) — DEPRECATED in pure-DXF flow
Phase 2: recursive explode A$C* / *U* / *X* wrapper blocks
Phase 3: deterministic classifier (100 rules — see below)  ⭐ NEW
Phase 4: token-overlap fallback (apply_whitelist_strict.py — Max GT 319 layers reservoir)
Phase 5: INSERT rescue (any layer holding INSERT auto-promoted to KEEP)
Phase 6: dedupe LINE entities + purge unused blocks
Phase 7: ATOMIC saveas (tmp → recover.readfile verify → os.replace)
    ↓
Output A: 3DS Max DXF
Output B: Illustrator-ready DXF (different layer subset)
```

---

## 📐 Deterministic classifier — current 100 rules

### Universal architectural codes (NBS Uniclass)
```
^A0\d{2}_  → KEEP  nbs_text_meta
^A1\d{2}_  → KEEP  nbs_substructure
^A2\d{2}_  → KEEP  nbs_walls
^A3\d{2}_  → KEEP  nbs_doors_windows
^A5\d{2}_  → KEEP  nbs_roofs
^A9\d{2}_  → KEEP  nbs_external_works
^G\d{3}_   → KEEP  nbs_external_g_codes
```

### Floor plan vs site plan context
```
^F\s       → DROP_SITE_KEEP_FLOOR  floor_plan_anno (F SVP, F RWP, F Roof, etc.)
```

### Site geometry (KEEP)
```
^SITE_     ^plotno     ^Plot      ^Bollards
^Manhole   ^Lamp       ^Tree      ^Hedge
^Path      ^Road       ^Parking   ^Boundary
^M-EQPM$   ^Drive$     ^WALL
```

### Topographic (DROP — confirmed by user)
```
_LEVELS$       _LVLS$         ^GH_CONT     _HEIGHTS$
_TADPOLE$      ^GH_(TOPS|BOTTOMS|GRID|CROSS)
^GH_TEXT$      "level checks"
^EPS_          ^GH_           ^NJCSURVEYS
^Setting Out   ^TopoSurvey   ^TRIANGLE
```

### Highway / road geometry (KEEP)
```
^TOP_OF_KERB   ^KERB_     ^EDGE_OF_       ^CENTRE_LINE
^ROAD_GULLY    ^EDGING_KERB   ^SW_COVER   ^STREET_LIGHT
^TACTILE_PAVING
```

### Earthworks (DROP)
```
^TOP_OF_BANK     ^BOTTOM_OF_BANK
^FILL-INDICATOR  ^CUT-INDICATOR
^SPOT_LEVEL      ^FRENCH_DRAIN
```

### Ordnance Survey (KEEP)
```
^OS\b   ^OS$    ^OSTREES   ^OSTEXT
^OSBUILDING     ^OSROAD    ^OSWATER
```

### Xref containers (DROP)
```
^Xref\s    ^XREF      \$0\$      \|
^Area\s\d+\sSurvey    ^TopoSurvey
```

### Client-specific naming (KEEP)
```
^BHN[_\-\s]    BH (Norfolk)
^BDW           Barratt Developments
^BDWS          Barratt-DWH
^DWH           David Wilson Homes
^Redrow / ^REDROW / ^RW_   Redrow
^H7\d{3}       H7xxx project codes
^H8\d{3}       H8xxx
^H9\d{3}       H9xxx
^E8\d{2}       E8xx
^JPP_          JPP civil engineer
^idp\s         IDP designer naming (BH)
```

### PDF imports (DROP — bitmap shadows useless)
```
^PDF_   _PDF$
```

---

## ✅ User-confirmed verdicts (Brook View topo)

**Source file:** `x_25-001 topo 2025.04.16.dxf` (82,332 entities)

### KEEP
- All `OS*` layers (OS map context)
- `GH_ROAD`, `GH_DKERB`, `GH_VERGE_TARMAC`, `GH_LINE_MARKING`
- `GH_HEDGE`, `GH_FENCES`, `GH_WALLS` (boundaries)
- `GH_TREE_*`, `GH_VEGETATION`, `VEGETATION` (planting)
- `GH_DRAINAGE`, `GH_UTILITIES`, `GH_SIGNS`

### DROP (43K entities = 52% of file)
- `GH_LEVELS` (35K!) — spot height numbers
- `GH_CONTOURS`, `GH_CONTLEVS`, `GH_CONTPROM`, `GH_TADPOLE` — contour data
- `GH_KERB_TOP_LVLS`, `GH_DRAINAGE_LVLS` — level annotations
- `GH_TEXT`, `March 2024 level checks` — markups
- `GH_BUILDING_HEIGHTS`, `GH_TOPS`, `GH_BOTTOMS` — Z-aukščio numbers
- `GH_GRID`, `GH_CROSS SECTION` — survey infrastructure

**Generalization principle (user words):**
> "levels man nereikia bet visi keliai kur yra tai reikalingi"

DROP all elevation/level/contour annotations. KEEP all geometric content.

---

## 📊 Vocabulary stats (full corpus)

| Metric | Value |
|---|---:|
| Projects scanned | 7 (Brook View, Quarter Bingham, Wigston, Wixams R7, Towcester, Kings Court, Fairfields) |
| Files parsed | 510/512 DXF |
| Total unique blocks | **14,776** |
| Total unique layers | **2,607** |
| Total entities | **4,244,520** |
| Total INSERTs | ~96,000 |
| Brook View dominance | 11,714 blocks (79% of global) |

### Per-project file counts
| Project | Files OK | Layers | Blocks |
|---|---:|---:|---:|
| brook_view | 329/329 | 763 | 11,714 |
| quarter_bingham_ph3 | 102/102 | 488 | 1,270 |
| wigston | 42/42 | 568 | 481 |
| wixams_r7 | 22/22 | 535 | 1,656 |
| towcester | 5/5 | 284 | 2,032 |
| kings_court | 4/6 | 133 | 118 |
| fairfields_4a_3a | 6/6 | 176 | 61 |

### Stable layers (≥3 projects)
- 47 stable layers exist
- Padengia 11.01% visų entities (467K iš 4.24M)
- 100% klasifikuojami deterministiškai

### Single-project layers (89% noise)
- 1,961 layer'ių egzistuoja tik 1 projekte
- 53 layer'iai egzistuoja 2 projektuose
- Tarp top-50 noise — 0 critical, 7 maybe, 43 true noise

---

## 🚧 Known infrastructure issues

1. **3DS Max xref import persistence** — "Do Not Resolve any Xrefs" option persists between imports, collapsing 32K objects to 1.9K on second import. Fix: reset Max import settings before each run, OR fully bind xrefs in DXF first.

2. **ezdxf saveas + ACAD_PROXY corruption** — when DXF contains Civil 3D/AECC proxy classes, agressive class stripping corrupts the file (v5/v6 disaster 2026-04-21). Solution: do NOT manipulate `doc.classes` section; rely on registry-level dialog suppression.

3. **AutoCAD startup dialogs** — Missing SHX, Proxy Information, Annotation Scales, Unresolved Xref, AcadLsp dialogs all need registry suppression keys at:
   `HKCU\Software\Autodesk\AutoCAD\R26.0\ACAD-A101:409\Profiles\<<Unnamed Profile>>\Dialogs\*`

4. **MCP open() vs active document** — `mcp__AutoCAD_MCP__drawing(open)` returns success but doesn't switch active drawing tab when a different DWG is already open. Workaround: kill AutoCAD process, restart with file as argument.

---

## 🔧 Active scripts

```
E:/pdf errors validation pipeline/scripts/
  ├── extract_raw_dwg_vocabulary.py        — Vocabulary extraction (multiproc 8 workers)
  ├── build_deterministic_classifier.py    — 100-rule classifier + benchmark
  ├── apply_whitelist_strict.py            — Token-overlap Max GT filter (atomic save)
  ├── clean_dwg_pipeline.py                — Unified cleanup pipeline (atomic save)
  ├── deep_clean.py                        — Recursive explode + layer 0 purge
  └── explode_xref_blocks.py               — Wrapper block explode

E:/mcp-servers/cad-agent-tools/src/server.py  — 10-tool MCP server

E:/cad-site-agent/src/cad_site_agent/
  ├── numbering/plot_numbers.py            ✅ implemented + tested
  ├── numbering/parking_numbers.py         ✅ implemented + tested
  ├── numbering/font_rules.py              ✅ BH/DWH fonts (Redrow missing)
  ├── housing/plot_house_mapper.py         ✅ 4-priority confidence ladder
  └── housing/house_type_detector.py       ✅ implemented
```

---

## ❓ Open questions for next chat session

1. **3DS Max input contract:** DXF version (R2018/R2010/R2007), units (mm/m), Z (force 0/preserve)?
2. **Brook View `X.dwg` deep-dive:** continue interactive layer review, or skip?
3. **Project priority:** finish Brook View first, or breadth-first across all 7?
4. **Redrow font mapping:** which font does Redrow use? (BH=DINPro/DINOT, DWH=Century Gothic, Redrow=?)
5. **Plot/parking numbering integration timeline:** when to plug `cad_site_agent.numbering` into new pipeline?
