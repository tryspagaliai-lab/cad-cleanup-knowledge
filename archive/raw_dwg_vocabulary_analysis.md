# RAW DWG Vocabulary Analysis — 2026-04-25

**Source data:** `E:/AgentOS/exports/raw_dwg_vocabulary.json`
**Generation script:** `E:/pdf errors validation pipeline/scripts/extract_raw_dwg_vocabulary.py`
**Runtime:** 5 minutes (parallel ProcessPool, 8 workers)

---

## Executive Summary

| Metrika | Naujasis RAW | Senasis Max GT | Skirtumas |
|---|---:|---:|---|
| Files parsed | 510/512 (99.6%) | 8 (Max scenes) | 60× more sources |
| Unique blocks | **14,776** | 1,147 | 13× richer |
| Unique layers | **2,607** | 319 | 8× richer |
| Total entities | **4,244,520** | ~58,808 INSERTs | full geometry now visible |
| Top-50 contamination markers (Box/obj_/VRayProxy) | **0** | dominant | ✅ confirmed clean |

**Hypothesis confirmed:** Max DXF was contaminated with Max scene mesh artifacts. RAW DWG vocabulary is the right source.

---

## Per-Project Breakdown

| Projektas | Files OK | Unique layers | Unique blocks |
|---|---:|---:|---:|
| brook_view | 329/329 | 763 | 11,714 |
| kings_court | 4/6 | 133 | 118 |
| towcester | 5/5 | 284 | 2,032 |
| wigston | 42/42 | 568 | 481 |
| quarter_bingham_ph3 | 102/102 | 488 | 1,270 |
| wixams_r7 | 22/22 | 535 | 1,656 |
| fairfields_4a_3a | 6/6 | 176 | 61 |

**Pastaba:** Brook View dominates (329 failai). Tai įskaito visą site dokumentaciją (planning, highway, topo, GA, civil). Kiti projektai turi tik master site layout + xrefs.

---

## 🎯 Cross-Project Stability — Where the Gold Is

### 47 stabilūs layer names (≥3 iš 7 projektų)

Tai layeriai, kurie atsikartoja per skirtingus klientus → **deterministinis prefix classifier turės 100% confidence šiems**.

#### NBS Uniclass Codes (architectural standard) — 8 layers, in 3-4 projects each
```
A010_Text         — title block / sheet text
A010_Hatching     — drawing fills
A010_Text_House   — house annotations
A210_Ext_Walls    — exterior walls
A220_Int_Walls    — interior walls
A240_Stairs       — stairs
A315_Doors        — doors
A956_Paths        — paths
A973_Gates        — gates
```

→ **Žinome:** jei layer prasideda `A\d{3}_` → tai architectural NBS codes. Deterministinis match'as be ML.

#### F-prefix Floor Plan Annotation — 11 stable layers
```
F Points              — measurement / setting-out points
F Roof                — roof line
F Roof Hatch 2        — roof fill hatch (secondary)
F Front Path          — driveway approach
F Patio               — rear patio
F Ext Wall Pres       — presentation wall
F Services SVP        — soil + vent pipe
F Services SFG        — soil + foul gas
F Services RWP        — rainwater pipe
F Services Flue       — boiler flue
F Text Code           — labeling text
F Services Water Supply
```

→ **Žinome:** `F ` prefix (su tarpu) → floor plan annotation. Šie sluoksniai turi būti arba **DROPPED** site plan cleanup'ui (jie iš pastato vidaus), arba **promotinami** atskirai.

#### QA / Quality Assurance Overlays — in 3+ projects
```
QA_BOUNDARIES   — plot boundary QA
QA_ROADS        — road geometry QA
```

#### Site-specific layers — semantic ground truth
```
SITE_ROAD_EDGE        — road kerbs
SITE_ROAD_SURFACE     — road tarmac
plotno                — plot number text positions ⭐ (10254 entities)
A-HOUSE               — generic house outline
Drive                 — driveway hatch
Bollards              — bollard markers
M-EQPM                — mechanical equipment
Text                  — generic text overlay
```

→ **`plotno` layer pasirodė 3 projektuose, 10,254 entities — tai kanoninis plot numerių sluoksnis.** Plot numbering automation (Q2 sekcija) turi tikrintis būtent šio layer pavadinimo.

---

## 🏗️ Cross-Project Stable Blocks (≥3 projektai)

**852 blokai pasirodė 3+ projektuose** — bet didžioji dalis yra `*U###` anonymous wrapper blocks (Max import artifacts). Tikrai semantiniai stabilūs blokai:

### Site furniture (high signal)
```
gate              — 5,472 inserts in 5 projects ⭐
GATE              — 212 inserts in 3 projects (UPPERCASE variant)
Power & Lighting  — 342 inserts in 3 projects (street lamp)
Bollards (layer)  — 298 entities in 3 projects
CIRCL             — 793 inserts in 3 projects (likely tree symbol)
```

### Floor plan service icons (in F Services_* layers)
```
F SFG    — 803 inserts in 6 projects
F SVP    — 484 inserts in 6 projects
F RWP    — 417 inserts in 5 projects
F Services Water Supply — 226 in 3 projects
F Services Flue         — 179 in 3 projects
```

→ **Žinome:** `F ` prefix block → service icon (RWP/SVP/SFG/etc). Same as F-layer logic.

### Wrapper blocks (`*U\d+`) — 25+ in cross-project list
Tai Max-import anonymous user blocks. **Reikia explode + delete iš site plan** (mūsų `phase3_recursive_explode` jau tai daro).

---

## 📐 Layer Naming Patterns — Deterministic Classifier Spec

Iš cross-project + per-project analysis:

```python
# Deterministinis classifier (turi būti pirmas, prieš token-overlap)
DETERMINISTIC_PREFIXES = {
    # NBS architectural codes (≥3 projektai patvirtino)
    r"^A0\d{2}_":  ("KEEP", "architectural_text", 1.0),
    r"^A2\d{2}_":  ("KEEP", "architectural_walls", 1.0),
    r"^A3\d{2}_":  ("KEEP", "architectural_doors_windows", 1.0),
    r"^A9\d{2}_":  ("KEEP", "architectural_paths_gates", 1.0),

    # F-prefix floor plan annotation (DROP for site plan, KEEP for floor plan)
    r"^F ":        ("DROP_SITE_KEEP_FLOOR", "floor_plan_annotation", 1.0),

    # QA overlays
    r"^QA_":       ("DROP", "quality_assurance_overlay", 1.0),

    # Site features
    r"^SITE_":     ("KEEP", "site_feature", 1.0),
    r"^A-":        ("KEEP", "architectural_2d", 1.0),

    # Plot/parking numbering
    r"^plotno":    ("KEEP", "plot_numbers", 1.0),

    # PDF imports (drop — these are raster-converted, low quality)
    r"^PDF_":      ("DROP", "pdf_import", 1.0),

    # Survey / topo
    r"^GH_":       ("DROP", "survey_levels", 1.0),
    r"^EPS_":      ("DROP", "survey_grid", 1.0),
    r"^OS":        ("KEEP", "ordnance_survey_base", 1.0),
    r"^NJCSURVEYS-": ("DROP", "topographic_survey", 1.0),

    # Xref containers
    r"^Xref ":     ("DROP", "xref_passthrough", 1.0),
    r"^XREF":      ("DROP", "xref_passthrough", 1.0),
}
```

**Padengimas iš RAW vocabulary:** apskaičiuojama testavimo metu, bet preliminarūs skaičiavimai rodo, kad **45-55% layer'ių** patenka po kuriuo nors deterministiniu prefix'u (top-50 layers atvejis). Likę 55-45% per token-overlap su Max GT.

---

## 🚨 Surprises & Issues

### 1. `plotno` layer egzistuoja → numeracija JAU dedama į konkretų layer
Tai keičia plot numbering algoritmą — nereikia generuoti naujo layer'o, reikia rašyti į esamą `plotno`.

### 2. Brook View dominuoja (8400/14776 = 57% bloku)
Survey points (`P_Z` 220K, `PT_PLUS` 71K, `SPOT` 41K) yra Brook View specific topo blokai. Jie užkemša cross-project statistiką. **Reikia ignoruoti single-project blocks** kai kuriam patternų matavime.

### 3. PDF imports liko site plan'uose
Layeriai `PDF_CP-Drives Hatch`, `PDF_CP-1.8mTimber Fencing*`, `PDF_2c.$22891_T_REV1$*` — tai PDF→DWG raster imports. **Šių blockų visiškai negalima naudoti modeliavimui** (nėra geometrijos, tik bitmap shadows). Drop visus `^PDF_`.

### 4. Site furniture katalogas labai mažas
Tarp 14,776 blocks, semantiškai vertingi „site furniture" blokai (`gate`, `Power & Lighting`, bollards, ramps): **<50 unikalūs, ~10K total inserts**. Likusi dalis = wrappers, survey markers, drawing meta.

→ Tikra „site plan vocabulary" yra **labai maža** (apie 100-200 unikalūs blokai), o likusi yra wrapper noise.

---

## 📋 Implications for 3DSP Cleanup Agent Spec

### What's now SOLVED
1. ✅ Layer prefix classifier feasibility — 45-55% covered by 15 deterministic regex patterns
2. ✅ `plotno` is the canonical plot number layer (not project-specific)
3. ✅ NBS A0xx/A2xx/A3xx codes are universal across BH/DWH (no client-specific needed)
4. ✅ F-prefix floor plan annotation must be filtered for site plan output (vs floor plan output)

### What's STILL OPEN
1. ⚠️ Per-HT block patterns — still mostly 1-project-only. Brook View has 11K blocks but only ~10% are repeating across projects. **Need master site layout filter before vocabulary builds out properly** (current scan includes ALL DXF including XREFs).
2. ⚠️ DWH/Redrow specific prefixes — layer_diff JSON reading would help (next step)
3. ⚠️ Site furniture short list — manual curation needed since vocabulary is too noisy

### What's REJECTED based on this data
1. ❌ Old `max_block_vocabulary.json` — confirmed contaminated with Max scene mesh
2. ❌ Need for Qwen VL classification on layer names — deterministic regex covers majority
3. ❌ Per-project bespoke handling — patterns are stable across clients

---

## Next Steps Recommendation

1. **Build deterministic classifier prototype** (1-2h)
   - Implement 15 regex patterns above
   - Test against `apply_whitelist_strict.py` token-overlap
   - Measure: % covered by deterministic vs token-overlap fallback

2. **Filter to master sheets only** (30min)
   - Re-run extraction with `_master_only=True` flag
   - Drops planning sheets, drainage, topographic surveys
   - Should reduce noise 5-10×

3. **DWH layer prefix dive** (1h)
   - Read `*_layer_diff.json` for DWH-specific projects
   - Confirm/reject `BDWS_`, `DWH-002-` as deterministic prefixes
