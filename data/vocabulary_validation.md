# Vocabulary Validation -- Stable Layers Coverage Audit

Generated: 2026-04-25  
Source: `E:/AgentOS/exports/raw_dwg_vocabulary.json`

---

## Coverage Metrics -- KRITISKI SKAICIAI

| Matavimas | Verte |
|---|---:|
| Stable layers tikslus skaicius | **47** |
| Total unique layers | 2,607 |
| **Layer coverage** (47/2607) | **1.80%** |
| Stable layers entities | 467,521 |
| Total entities | 4,244,520 |
| **Entity coverage** | **11.01%** |
| Ambiguous stable layers (no clear category) | 1/47 |

**ATSAKYMAS:** anksciau pasakytas '100% coverage' reiske **stable layers <-> classifier rules match'a** (47/47 layers).
Tikras VOCABULARY coverage:
- **Layer level:** 1.80% (47 is 2,607 layer'iu yra stabilus)
- **Entity level:** 11.01% (467,521 is 4,244,520 entities yra stable layer'iuose)

Vadinasi 47 stable layers padengia tik **11%** visu entities -- likusieji **89% entities** yra single/dual project layer'iuose.

---

## Snippet 1 -- Top Summary

| Metrika | Verte |
|---|---:|
| Total projects scanned | 7 |
| Total unique layers | 2,607 |
| Total unique blocks (inserted) | 14,776 |
| Total entities | 4,244,520 |
| Total INSERT entities | 682,005 |

### Per-project breakdown

| Project | Files OK | Layers | Blocks | Entities |
|---|---:|---:|---:|---:|
| brook_view | 329 | 763 | 11,714 | 2,084,635 |
| quarter_bingham_ph3 | 102 | 488 | 1,270 | 1,061,993 |
| wigston | 42 | 568 | 481 | 517,068 |
| wixams_r7 | 22 | 535 | 1,656 | 424,196 |
| towcester | 5 | 284 | 2,032 | 69,252 |
| fairfields_4a_3a | 6 | 176 | 61 | 59,860 |
| kings_court | 4 | 133 | 118 | 27,516 |

---

## Snippet 2 -- Stable Layers (>=3 projects) -- 47 layers

| # | Layer | Proj | Entities | Dominant type | Top-3 types | Category |
|---:|---|---:|---:|---|---|---|
| 1 | `0` | 7 | 113,104 | LINE | LINE:73707, INSERT:17313, ARC:10503 | SYSTEM |
| 2 | `A010_Text` | 4 | 74,288 | MTEXT | MTEXT:51594, LINE:13373, TEXT:6906 | DRAWING_TEXT_HATCH |
| 3 | `A010_Hatching` | 3 | 72,261 | LINE | LINE:49657, HATCH:15290, ARC:2112 | DRAWING_TEXT_HATCH |
| 4 | `F Points` | 4 | 44,184 | POINT | POINT:44184 | FLOOR_PLAN_ANNOTATION |
| 5 | `A210_Ext_Walls` | 4 | 36,609 | LINE | LINE:30092, LWPOLYLINE:5884, ARC:312 | WALLS |
| 6 | `A315_Doors` | 3 | 25,059 | LINE | LINE:15312, LWPOLYLINE:5371, ARC:1482 | DOORS |
| 7 | `A220_Int_Walls` | 3 | 24,769 | LINE | LINE:22069, LWPOLYLINE:2298, ARC:177 | WALLS |
| 8 | `A240_Stairs` | 3 | 19,391 | LINE | LINE:17358, LWPOLYLINE:849, ARC:825 | STAIRS |
| 9 | `A956_Paths` | 3 | 17,827 | LWPOLYLINE | LWPOLYLINE:15879, LINE:1362, INSERT:559 | PATHS |
| 10 | `plotno` | 3 | 10,254 | TEXT | TEXT:9832, MTEXT:350, LINE:64 | PLOT_NUMBERS |
| 11 | `F Ext Wall Pres` | 5 | 3,332 | LWPOLYLINE | LWPOLYLINE:3300, LINE:32 | FLOOR_PLAN_ANNOTATION |
| 12 | `QA_BOUNDARIES` | 3 | 2,898 | LWPOLYLINE | LWPOLYLINE:2898 | QA_OVERLAY |
| 13 | `F Front Path` | 5 | 2,811 | LWPOLYLINE | LWPOLYLINE:2655, LINE:147, ARC:6 | FLOOR_PLAN_ANNOTATION |
| 14 | `QA_ROADS` | 3 | 2,735 | LWPOLYLINE | LWPOLYLINE:2735 | QA_OVERLAY |
| 15 | `A-HOUSE` | 3 | 2,619 | INSERT | INSERT:2612, LWPOLYLINE:7 | HOUSES |
| 16 | `A010_Text_House` | 3 | 2,220 | TEXT | TEXT:2220 | DRAWING_TEXT_HATCH |
| 17 | `SITE_ROAD_EDGE` | 3 | 1,876 | LWPOLYLINE | LWPOLYLINE:1876 | ROADS |
| 18 | `A973_Gates` | 3 | 1,773 | INSERT | INSERT:1521, LWPOLYLINE:252 | GATES |
| 19 | `Drive` | 3 | 1,056 | LWPOLYLINE | LWPOLYLINE:1020, LINE:36 | DRIVEWAYS |
| 20 | `M-EQPM` | 3 | 846 | INSERT | INSERT:545, LINE:225, SPLINE:26 | MECH_EQUIPMENT |
| 21 | `Text` | 4 | 647 | MTEXT | MTEXT:585, TEXT:57, MULTILEADER:5 | TEXT_GENERIC |
| 22 | `F Services SFG` | 4 | 573 | INSERT | INSERT:573 | FLOOR_PLAN_ANNOTATION |
| 23 | `F Services SVP` | 4 | 572 | INSERT | INSERT:412, LINE:80, CIRCLE:80 | FLOOR_PLAN_ANNOTATION |
| 24 | `SITE_ROAD_SURFACE` | 3 | 552 | LWPOLYLINE | LWPOLYLINE:552 | ROADS |
| 25 | `F Roof` | 5 | 540 | LINE | LINE:332, LWPOLYLINE:208 | FLOOR_PLAN_ANNOTATION |
| 26 | `F Roof Hatch 2` | 5 | 526 | HATCH | HATCH:526 | FLOOR_PLAN_ANNOTATION |
| 27 | `F Services RWP` | 3 | 516 | INSERT | INSERT:276, LINE:160, LWPOLYLINE:80 | FLOOR_PLAN_ANNOTATION |
| 28 | `F Text Code` | 4 | 346 | TEXT | TEXT:342, LINE:3, CIRCLE:1 | FLOOR_PLAN_ANNOTATION |
| 29 | `F Patio` | 3 | 327 | LINE | LINE:309, LWPOLYLINE:18 | FLOOR_PLAN_ANNOTATION |
| 30 | `Bollards` | 3 | 298 | HATCH | HATCH:244, LINE:30, LWPOLYLINE:18 | BOLLARDS |
| 31 | `F Services Water Supply` | 4 | 275 | INSERT | INSERT:275 | FLOOR_PLAN_ANNOTATION |
| 32 | `F Roof Hatch 1` | 5 | 271 | HATCH | HATCH:223, LWPOLYLINE:48 | FLOOR_PLAN_ANNOTATION |
| 33 | `F Crossing` | 5 | 266 | INSERT | INSERT:170, LWPOLYLINE:96 | FLOOR_PLAN_ANNOTATION |
| 34 | `F Storey 2` | 4 | 255 | HATCH | HATCH:255 | FLOOR_PLAN_ANNOTATION |
| 35 | `F Services Flue` | 3 | 242 | INSERT | INSERT:178, HATCH:32, LWPOLYLINE:32 | FLOOR_PLAN_ANNOTATION |
| 36 | `A211_Ext_Walls_Pres` | 3 | 223 | LWPOLYLINE | LWPOLYLINE:183, LINE:40 | AMBIGUOUS |
| 37 | `F Door` | 4 | 178 | INSERT | INSERT:126, LWPOLYLINE:42, HATCH:10 | FLOOR_PLAN_ANNOTATION |
| 38 | `F Text AsOpp` | 3 | 165 | TEXT | TEXT:87, INSERT:58, MTEXT:20 | FLOOR_PLAN_ANNOTATION |
| 39 | `Defpoints` | 5 | 160 | MTEXT | MTEXT:98, LINE:32, INSERT:17 | SYSTEM |
| 40 | `F Ext Wall` | 4 | 158 | LWPOLYLINE | LWPOLYLINE:150, LINE:4, INSERT:4 | FLOOR_PLAN_ANNOTATION |
| 41 | `F Bed 2` | 5 | 128 | INSERT | INSERT:64, HATCH:64 | FLOOR_PLAN_ANNOTATION |
| 42 | `F Bed 3` | 5 | 117 | HATCH | HATCH:62, INSERT:55 | FLOOR_PLAN_ANNOTATION |
| 43 | `F Bed 4` | 3 | 84 | HATCH | HATCH:44, INSERT:40 | FLOOR_PLAN_ANNOTATION |
| 44 | `F Window` | 3 | 73 | MTEXT | MTEXT:48, TEXT:24, INSERT:1 | FLOOR_PLAN_ANNOTATION |
| 45 | `F Party Wall` | 3 | 55 | LWPOLYLINE | LWPOLYLINE:52, LINE:3 | FLOOR_PLAN_ANNOTATION |
| 46 | `F Bed 1` | 3 | 34 | INSERT | INSERT:29, HATCH:5 | FLOOR_PLAN_ANNOTATION |
| 47 | `F Storey 1` | 3 | 28 | HATCH | HATCH:28 | FLOOR_PLAN_ANNOTATION |

### Category distribution (stable layers)

| Category | Count | % of stable |
|---|---:|---:|
| FLOOR_PLAN_ANNOTATION | 25 | 53.2% |
| DRAWING_TEXT_HATCH | 3 | 6.4% |
| SYSTEM | 2 | 4.3% |
| WALLS | 2 | 4.3% |
| QA_OVERLAY | 2 | 4.3% |
| ROADS | 2 | 4.3% |
| DOORS | 1 | 2.1% |
| STAIRS | 1 | 2.1% |
| PATHS | 1 | 2.1% |
| PLOT_NUMBERS | 1 | 2.1% |
| HOUSES | 1 | 2.1% |
| GATES | 1 | 2.1% |
| DRIVEWAYS | 1 | 2.1% |
| MECH_EQUIPMENT | 1 | 2.1% |
| TEXT_GENERIC | 1 | 2.1% |
| BOLLARDS | 1 | 2.1% |
| AMBIGUOUS | 1 | 2.1% |

---

## Snippet 3 -- Noise Samples (1-2 projects) -- Top 50 by entities

Kritine patikra: ar tarp single/dual-project layer'iu yra paslepta svarbiu site plan layer'iu.

| # | Layer | Proj | Entities | Dominant | Critical? |
|---:|---|---:|---:|---|:-:|
| 1 | `GH_LEVELS` | 1 | 398,042 | INSERT | no |
| 2 | `EPS_Survey Points` | 1 | 146,888 | TEXT | no |
| 3 | `A040_Elevations` | 1 | 110,370 | LINE | no |
| 4 | `PDF_CP-Drives Hatch` | 1 | 96,272 | LWPOLYLINE | no |
| 5 | `PDF_2c.$22891_T_REV1$GH_HEDGE` | 1 | 91,799 | LWPOLYLINE | no |
| 6 | `OS` | 2 | 88,567 | LWPOLYLINE | no |
| 7 | `EPS_Grid` | 1 | 82,068 | POLYLINE | no |
| 8 | `PDF_2c.$22891_T_REV1$OSTREES` | 1 | 80,652 | ARC | no |
| 9 | `PDF_2c.$22891_T_REV1$GH_BOTTOMS` | 1 | 78,800 | LWPOLYLINE | no |
| 10 | `Xref park` | 1 | 77,909 | ATTDEF | no |
| 11 | `NJCSURVEYS-GROUND-LEVEL` | 2 | 77,155 | TEXT | no |
| 12 | `PDF_CP-1.8mTimber Fencing with conc posts` | 1 | 53,892 | HATCH | no |
| 13 | `MP-WD-INSULATION` | 1 | 53,724 | ARC | no |
| 14 | `TRIANGLE` | 1 | 51,307 | 3DFACE | no |
| 15 | `GH_HEDGE` | 1 | 49,667 | INSERT | maybe |
| 16 | `A314_Windows` | 1 | 45,534 | LINE | no |
| 17 | `A010_Dimensions` | 1 | 39,885 | DIMENSION | no |
| 18 | `OSBUILDING` | 1 | 37,808 | LWPOLYLINE | no |
| 19 | `NJCSURVEYS-HEDGE-LINE` | 2 | 36,086 | POLYLINE | maybe |
| 20 | `GH_FENCES` | 1 | 32,939 | INSERT | maybe |
| 21 | `sdc-non adoptable sewers` | 1 | 30,777 | LINE | no |
| 22 | `FILL-INDICATOR` | 2 | 29,330 | LWPOLYLINE | no |
| 23 | `A050_Sections` | 1 | 29,214 | LINE | no |
| 24 | `A600_Electrical` | 1 | 28,566 | LINE | no |
| 25 | `EPS_Contours` | 1 | 26,380 | LWPOLYLINE | no |
| 26 | `TopoSurvey - With Removed Trees$0$NJCSURVEYS-HEDGE-LINE` | 1 | 25,737 | LINE | no |
| 27 | `idp house path` | 1 | 24,303 | LINE | maybe |
| 28 | `GH_VEGETATION` | 1 | 24,007 | INSERT | no |
| 29 | `PDF_CP-crib_velux` | 1 | 23,250 | LWPOLYLINE | no |
| 30 | `GH_CONTOURS` | 1 | 23,154 | LWPOLYLINE | no |
| 31 | `GH_TREE_INFORMATION` | 1 | 22,855 | TEXT | maybe |
| 32 | `Setting Out` | 2 | 22,824 | TEXT | no |
| 33 | `PDF_CP-Cyclepath` | 1 | 22,131 | LWPOLYLINE | no |
| 34 | `Details` | 1 | 21,210 | LINE | no |
| 35 | `GH_CONTLEVS` | 1 | 21,170 | TEXT | no |
| 36 | `OSTEXT` | 1 | 20,758 | POINT | no |
| 37 | `A_Drive` | 2 | 19,566 | LWPOLYLINE | maybe |
| 38 | `A-WALL` | 1 | 19,368 | LINE | no |
| 39 | `CUT-INDICATOR` | 2 | 19,304 | LWPOLYLINE | no |
| 40 | `A_Conveyance` | 2 | 18,489 | LWPOLYLINE | no |
| 41 | `G971_Fencing` | 2 | 18,343 | LINE | no |
| 42 | `EPS_Fences` | 1 | 18,208 | POLYLINE | maybe |
| 43 | `Area 11 Survey$0$LEVELS` | 1 | 18,189 | INSERT | no |
| 44 | `PDF_Text` | 2 | 17,989 | MTEXT | no |
| 45 | `LEVELS` | 1 | 17,424 | TEXT | no |
| 46 | `D-Zz_80_45-M_Featurelines _Daylight` | 1 | 17,352 | LWPOLYLINE | no |
| 47 | `A270_Roofs` | 2 | 16,827 | LINE | no |
| 48 | `PDF_C3d feature line ponds` | 1 | 16,602 | LWPOLYLINE | no |
| 49 | `GH_TEXT` | 1 | 14,848 | TEXT | no |
| 50 | `A210_External_Walls` | 1 | 13,749 | LINE | no |

### Critical guess distribution (top 50 noise)

- **yes** (likely site plan critical): 0
- **maybe** (worth review): 7
- **no** (true noise): 43

---

## Conclusion

**Layer coverage hipoteze:** stable cross-project layers (47/2,607 = 1.8%) padengia svarbiausius pattern'us.
**Tikras kritinis matavimas:** stable layers entity coverage = **11.0%**.
**Praktiska reiksme:** likusieji 89.0% entities yra arba single-project noise, arba trukstami stable patterns kuriuos reikia aptikti per token-overlap fallback.