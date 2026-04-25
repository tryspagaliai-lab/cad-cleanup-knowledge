# User Verdicts — Brook View Topo Layer Classification

**Source file:** `C:/Users/zilva/Desktop/BROOK VIEW at PICKFORD GATE/_dxf_output/Ph1/xref/x_25-001 topo 2025.04.16.dxf`
**Date confirmed:** 2026-04-25
**Method:** Visual layer-by-layer review in AutoCAD

## Principal rule (from user)

> "levels man nereikia bet visi keliai kur yra tai reikalingi"
> "dabar atsirado viskas bet ir levels linijos su skaiciais taip pat, bet man ju nereikia"

**Translation:** Drop ALL elevation/level/contour data. Keep ALL geometric content (roads, buildings, vegetation, services).

## Generalizable pattern

```python
# DROP if layer name contains:
DROP_TOPO_PATTERNS = [
    r"_LEVELS?$",      # GH_LEVELS, _ELV suffix
    r"_LVLS$",         # GH_KERB_TOP_LVLS, GH_DRAINAGE_LVLS
    r"^GH_CONT",       # GH_CONTOURS, GH_CONTLEVS, GH_CONTPROM
    r"_TEXT$",         # GH_TEXT (survey markups)
    r"_HEIGHTS$",      # GH_BUILDING_HEIGHTS
    r"_TADPOLE$",      # GH_TADPOLE (contour direction arrows)
    r"^GH_(TOPS|BOTTOMS|GRID|CROSS)",  # bank / grid / cross section
    r"level checks",   # "March 2024 level checks"
]

# KEEP if layer name matches:
KEEP_TOPO_PATTERNS = [
    r"^OS",                       # OS, OSROAD, OSBUILDING, OSTEXT, OSTREES, OSWATER
    r"^GH_ROAD",                  # site design roads
    r"^GH_(D)?KERB$",             # kerbs (not level annotations)
    r"^GH_VERGE",                 # verge tarmac
    r"^GH_LINE_MARKING",          # road markings
    r"^GH_HEDGE",                 # hedges
    r"^GH_FENCES",                # fences
    r"^GH_WALLS",                 # walls
    r"^GH_TREE_(INFORMATION|CANOPY|TRUNK)",  # tree objects
    r"^GH_VEGETATION",            # vegetation
    r"^VEGETATION",               # vegetation alt
    r"^GH_DRAINAGE$",             # drainage layout (no _LVLS)
    r"^GH_UTILITIES$",            # utilities layout
    r"^GH_SIGNS",                 # signage
]
```

## Confirmed verdicts

### ✅ KEEP (geometry, infrastructure)

| Layer | Entities | Type |
|---|---:|---|
| `OS` | 11,006 | OS base map |
| `OSBUILDING` | 4,726 | OS buildings |
| `OSTEXT` | 1,591 | OS labels |
| `OSROAD` | 998 | OS roads |
| `OSTREES` | 829 | OS trees |
| `OSWATER` | 397 | OS water |
| `GH_HEDGE` | 5,828 | Site hedges |
| `GH_FENCES` | 3,894 | Site fences |
| `GH_VEGETATION` | 2,986 | Site vegetation |
| `GH_TREE_INFORMATION` | 1,376 | Tree objects |
| `GH_TREE_CANOPY` | 929 | Tree canopies |
| `GH_TREE_TRUNK` | 917 | Tree trunks |
| `VEGETATION` | 850 | Vegetation alt |
| `GH_DRAINAGE` | 705 | Drainage layout |
| `GH_UTILITIES` | 499 | Utilities |
| `GH_ROAD` | 374 | Site design roads |
| `GH_WALLS` | 202 | Walls |
| `GH_VERGE_TARMAC` | 138 | Verge edges |
| `GH_LINE_MARKING` | 108 | Road markings |
| `GH_SIGNS` | 113 | Signage |
| `GH_DKERB` | 46 | Dropped kerbs |

**Total KEEP entities: ~37,000**

### ❌ DROP (elevation/level annotations)

| Layer | Entities | Reason |
|---|---:|---|
| `GH_LEVELS` | **35,069** | Spot height numbers (BIGGEST CHUNK) |
| `GH_CONTOURS` | 1,370 | Contour lines |
| `GH_TEXT` | 1,229 | Survey markups |
| `March 2024 level checks` | 1,200 | Level revision notes |
| `GH_CONTLEVS` | 1,167 | Contour level labels |
| `GH_BUILDING_HEIGHTS` | 784 | Building height numbers |
| `GH_KERB_TOP_LVLS` | 505 | Kerb level numbers |
| `GH_DRAINAGE_LVLS` | 454 | Drainage level numbers |
| `GH_CONTPROM` | 305 | Prominent contours |
| `GH_TADPOLE` | 261 | Contour direction arrows |
| `GH_CROSS SECTION` | 198 | Cross sections |
| `GH_TOPS` | 179 | Top of bank |
| `GH_BOTTOMS` | 171 | Bottom of bank |
| `GH_GRID` | 120 | Survey grid |

**Total DROP entities: ~43,000 (52% of file size!)**

## Implication for classifier

This single rule (DROP elevation annotations) removes ~43K entities from one xref file alone. Across 8 projects, this translates to ~300-500K entities of pure drop signal — the classifier's most impactful single rule.

### Add to classifier:

```python
# === Topographic survey level annotations — DROP for site plan ===
(r"_LEVELS?$",         "search", "DROP", "topo_levels",         1.0),
(r"_LVLS$",            "search", "DROP", "topo_levels_short",   1.0),
(r"^GH_CONT",          "match",  "DROP", "topo_contours",       1.0),
(r"_HEIGHTS$",         "search", "DROP", "topo_heights",        1.0),
(r"_TADPOLE$",         "search", "DROP", "topo_direction",      1.0),
(r"^GH_(TOPS|BOTTOMS|GRID|CROSS)", "match", "DROP", "topo_misc", 1.0),
(r"level checks?",     "search", "DROP", "level_checks",        1.0),
(r"^GH_TEXT$",         "match",  "DROP", "gh_survey_text",      1.0),

# === Topographic survey geometric content — KEEP ===
(r"^GH_(ROAD|HEDGE|FENCES|WALLS|VEGETATION|DRAINAGE|UTILITIES|SIGNS)$", "match", "KEEP", "site_geometry", 1.0),
(r"^GH_TREE_",         "match",  "KEEP", "trees",               1.0),
(r"^GH_VERGE",         "match",  "KEEP", "verge",               1.0),
(r"^GH_LINE_MARKING",  "match",  "KEEP", "line_marking",        1.0),
(r"^GH_(D)?KERB$",     "match",  "KEEP", "kerbs",               1.0),
(r"^OS[A-Z]+$",        "match",  "KEEP", "ordnance_survey",     1.0),
```
