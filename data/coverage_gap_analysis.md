# Coverage Gap Analysis -- DELETE vs KEEP vs AMBIGUOUS

Generated: 2026-04-25
Source: `E:/AgentOS/exports/raw_dwg_vocabulary.json`

**Klausimas:** ar 89% nepadengtu entities yra DELETE (siuksles) ar KEEP (svarbus)?

---

## Verdiktas

### **MIXED**

Misriaa situacija — ne A, ne B, ne human_review konkrecius patenkina

---

## Statistika

| Metrika | Skaicius | % uncovered |
|---|---:|---:|
| Total entities (visa vocabulary) | 4,244,520 | 100% |
| Stable layers entities (covered) | 467,525 | 11.0% |
| **Uncovered entities** | **3,776,995** | 100% (kaip baseline) |
| -- DELETE | 2,492,482 | **66.0%** |
| -- KEEP | 345,438 | **9.1%** |
| -- AMBIGUOUS | 939,075 | **24.9%** |

### Layer-level distribution

| Kategorija | Layers | % uncovered layers |
|---|---:|---:|
| Total uncovered layers | 2,560 | 100% |
| DELETE | 884 | 34.5% |
| KEEP | 606 | 23.7% |
| AMBIGUOUS | 1070 | 41.8% |

---

## Top 10 DELETE (didziausi entities)

| Layer | Entities | Proj | Dominant |
|---|---:|---:|---|
| `GH_LEVELS` | 398,042 | 1 | INSERT |
| `EPS_Survey Points` | 146,888 | 1 | TEXT |
| `A040_Elevations` | 110,370 | 1 | LINE |
| `PDF_CP-Drives Hatch` | 96,272 | 1 | LWPOLYLINE |
| `PDF_2c.$22891_T_REV1$GH_HEDGE` | 91,799 | 1 | LWPOLYLINE |
| `EPS_Grid` | 82,068 | 1 | POLYLINE |
| `PDF_2c.$22891_T_REV1$OSTREES` | 80,652 | 1 | ARC |
| `PDF_2c.$22891_T_REV1$GH_BOTTOMS` | 78,800 | 1 | LWPOLYLINE |
| `Xref park` | 77,909 | 1 | ATTDEF |
| `NJCSURVEYS-GROUND-LEVEL` | 77,155 | 2 | TEXT |

## Top 10 KEEP (didziausi entities)

| Layer | Entities | Proj | Dominant |
|---|---:|---:|---|
| `idp house path` | 24,303 | 1 | LINE |
| `A-WALL` | 19,368 | 1 | LINE |
| `A210_External_Walls` | 13,749 | 1 | LINE |
| `idp parkings` | 10,360 | 1 | TEXT |
| `000 Garden fences` | 9,513 | 1 | LINE |
| `KERB_CHANNEL` | 7,825 | 1 | POINT |
| `a_tmarks` | 7,248 | 2 | INSERT |
| `000 GARDEN AREAS COMPLIANT` | 6,888 | 1 | LWPOLYLINE |
| `VEGETATION` | 6,800 | 1 | INSERT |
| `A-WALL-1` | 6,637 | 1 | LINE |

---

## TOP 30 AMBIGUOUS (zmogaus sprendimas reikalingas)

Sitie layeriai pateko i pilkaja zona — joms reikia tavo verdikto: KEEP ar DROP?

| # | Layer | Entities | Proj | Dominant | User decision |
|---:|---|---:|---:|---|:-:|
| 1 | `OS` | 88,567 | 2 | LWPOLYLINE | ? |
| 2 | `MP-WD-INSULATION` | 53,724 | 1 | ARC | ? |
| 3 | `A314_Windows` | 45,534 | 1 | LINE | ? |
| 4 | `OSBUILDING` | 37,808 | 1 | LWPOLYLINE | ? |
| 5 | `sdc-non adoptable sewers` | 30,777 | 1 | LINE | ? |
| 6 | `A600_Electrical` | 28,566 | 1 | LINE | ? |
| 7 | `Details` | 21,210 | 1 | LINE | ? |
| 8 | `OSTEXT` | 20,758 | 1 | POINT | ? |
| 9 | `A_Drive` | 19,566 | 2 | LWPOLYLINE | ? |
| 10 | `A_Conveyance` | 18,489 | 2 | LWPOLYLINE | ? |
| 11 | `G971_Fencing` | 18,343 | 2 | LINE | ? |
| 12 | `A270_Roofs` | 16,827 | 2 | LINE | ? |
| 13 | `A700_Furniture` | 13,194 | 1 | LINE | ? |
| 14 | `HA-ANN-FEAT-TEXT` | 12,549 | 1 | TEXT | ? |
| 15 | `A520_Waste_Disposal` | 11,583 | 1 | LINE | ? |
| 16 | `A213_Walls_Plasterboard` | 11,313 | 1 | LINE | ? |
| 17 | `G8010030` | 11,186 | 1 | LWPOLYLINE | ? |
| 18 | `A530_Liquid_Supply` | 11,103 | 1 | LINE | ? |
| 19 | `A730_Kitchen_Fit` | 10,695 | 1 | LINE | ? |
| 20 | `A325_Doors` | 10,359 | 1 | LINE | ? |
| 21 | `A740_Sanitary_Fit` | 10,134 | 1 | LINE | ? |
| 22 | `510` | 10,092 | 1 | LWPOLYLINE | ? |
| 23 | `sdc-sewer-storm` | 9,963 | 2 | LINE | ? |
| 24 | `Tracking` | 9,268 | 2 | LWPOLYLINE | ? |
| 25 | `OSROAD` | 8,694 | 1 | LWPOLYLINE | ? |
| 26 | `Insulation` | 8,415 | 1 | LINE | ? |
| 27 | `A310_Ext_Wall_Cavity` | 8,376 | 1 | LINE | ? |
| 28 | `TOP_OF_KERB` | 7,870 | 1 | POINT | ? |
| 29 | `A213_Walls_Plaster board` | 7,695 | 1 | LINE | ? |
| 30 | `A_Ground Conveyance` | 7,509 | 2 | TEXT | ? |

---

## Conclusion

- **DELETE**: 66.0% uncovered entities (884 layers) -- siuksles, drop
- **KEEP**: 9.1% uncovered entities (606 layers) -- pridek classifier rules
- **AMBIGUOUS**: 24.9% uncovered entities (1070 layers) -- review top 30
