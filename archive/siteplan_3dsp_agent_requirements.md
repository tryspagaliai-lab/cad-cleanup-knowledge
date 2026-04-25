# 3DSP Site Plan Cleanup Agent — Requirements Extraction

> Extracted 2026-04-25. All facts cited file:line. Speculation forbidden — `⚠️ Nerasta` where data missing.

---

## 0. Scope Boundary Statement (kas IN, kas OUT)

### IN scope (this document covers)
- 3DSP site plan DWG/DXF cleanup
- Output 1: 3DS Max-ready DXF (modelling structure + INSERTs preserved)
- Output 2: Illustrator-ready DXF (structural layers only — roof 4-layer + overlay layers, no color/font work)
- House Type (HT) block patterns (BH / DWH / Redrow)
- Plot + parking numbering AutoCAD/DXF automation
- Site plan-specific layer naming patterns per client
- Block vocabulary classification (vegetation, fencing, refuse, drainage etc.)
- Max scene `#00_*` semantic groups + post-import rules
- DXF→Max import gotchas (LinkComposite, xref, "Do Not Resolve")

### OUT of scope (explicitly excluded — handed to other agents)
- 2DFP floor plans (PDFIMPORT, LISP entmod, kitchen/sanitary/doors/windows on FP)
- Illustrator-side work: color fills, font rendering, branding template population, key/legend generation
- Photoshop post-production
- 3DS Max material assignment, V-Ray shader work, render tuning
- Forest Pack scatter density tuning (mentioned only at handoff boundary)

---

## Q1. House Type Blocks (BH / DWH / Redrow)

### Sources read
- `C:/Users/zilva/ClaudeAIOS/04_Knowledge/knowledge-bh-house-types.md`
- `C:/Users/zilva/ClaudeAIOS/04_Knowledge/knowledge-bh-ht-complete-archive.md`
- `C:/Users/zilva/ClaudeAIOS/04_Knowledge/knowledge-redrow-ht-complete-archive.md`
- `C:/Users/zilva/ClaudeAIOS/04_Knowledge/knowledge-bh-roof-pitch-standards.md`
- `E:/pdf errors validation pipeline/training/cleanup_gt/max_block_vocabulary.json`
- `E:/pdf errors validation pipeline/training/cleanup_gt/block_footprints.json`
- `E:/pdf errors validation pipeline/training/cleanup_gt/max_ground_truth.json`

### BH (Barratt Homes) House Types

Source: `knowledge-bh-house-types.md:20-65`, `knowledge-bh-ht-complete-archive.md:32-71`

| name | bedrooms | block_name_patterns | occurrence_count | typical_footprint_m2 | roof_color (RGB) |
|---|---|---|---|---|---|
| Denford | 2 | `BDNF_X0HE`, `Layer:BDW-A-HOUSETYPE` Denford-EH/-I (`knowledge-bh-house-types.md:21,180`) | ⚠️ Nerasta per-project count | 4.445 × 7.865 (terrace unit) (`knowledge-bh-ht-complete-archive.md:111`) | 212,201,149 (`knowledge-bh-house-types.md:21`) |
| Richmond | 2 | ⚠️ Nerasta block code | ⚠️ Nerasta | ⚠️ Nerasta | 243,135,113 (`:22`) |
| Maidstone | 3 | `BMAI_X0HE`, `BMAI_X0-I`, `BMAI` × 2/× 3 (`knowledge-bh-house-types.md:81-82`, `knowledge-bh-ht-complete-archive.md:96,114`) | ⚠️ Nerasta | 5.1 × 8.9 per unit (`knowledge-bh-ht-complete-archive.md:96`) | 130,139,194 (`:23`) |
| Plumstead | 3 | ⚠️ Nerasta block code | ⚠️ Nerasta | ⚠️ Nerasta | 191,166,206 (`:24`) |
| Ellerton | 3 | `BLLE_X0HE`, pair pyramidal hip (`knowledge-bh-ht-complete-archive.md:38-39`) | ⚠️ Nerasta | 10.2 × 8.9 pair / 5.1 × 8.9 single (`:38-39`) | 162,209,196 (`:25`) |
| Buchanan | 3 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | 77,166,106 (`:26`) |
| Moresby | 3 | `BMMS_X0GE`, `BMMS_X0GD` (`knowledge-bh-ht-complete-archive.md:53,93`) | ⚠️ Nerasta | 5.39 × 8.9 (GD det); 5.24 × 8.9 (GE end) (`:53,93`) | 152,127,169 (`:27`) |
| Oakley | 3/4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | 208,165,122 (`:28`) |
| Hesketh | 4 | `BHSK_X0GD` (`knowledge-bh-ht-complete-archive.md:52`) | ⚠️ Nerasta | 5.615 × 9.103 (`:52`) | 138,175,133 (`:29`) |
| Alderney | 4 | ⚠️ Nerasta block code (only "Alderney" name; standard 8.99×8.65 L-shape) (`knowledge-bh-ht-complete-archive.md:40`) | ⚠️ Nerasta | 8.99 × 8.65 L-shape (`knowledge-bh-house-types.md:200`) | 245,207,200 (`:30`) |
| Radleigh | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | 245,168,170 (`:31`) |
| Affordable Housing | n/a | special — not a HT (`:152`) | ⚠️ Nerasta | ⚠️ Nerasta | 149,150,152 (`:32`) |
| Kingsville | 3 | `Kingsville_COMPLETE` (`knowledge-bh-ht-complete-archive.md:43`) | ⚠️ Nerasta | 8.876 × 10.026 (`:43`) | ⚠️ Nerasta |
| Bewdley | 3 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Kingsley | 4 | KINGSLEY-H L-shape (`knowledge-bh-ht-complete-archive.md:202`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Chester (BH) | 4 | (also DWH brand has same — `knowledge-redrow-ht-complete-archive.md:42` notes name conflict; in DWH it is `BCSR_X0FD`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Alfreton | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Kew | 2 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Shakespeare | 3 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Allerthorpe | 3 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Charnwood | 3 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Wilbye | 3 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Compton | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Ashfield | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Booth | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Brentford | n/a | `BBNF_X0GE`, pair + 3-unit terrace (`knowledge-bh-ht-complete-archive.md:44,118,122`) | ⚠️ Nerasta | 4.36 × 9.675 (`:44`) | ⚠️ Nerasta |
| Haversham | n/a | Haversham-EG, hipped end pair (`knowledge-bh-ht-complete-archive.md:81`) | ⚠️ Nerasta | 4.438 × 9.666 (`:81`) | ⚠️ Nerasta |
| Stambourne | n/a | `BSME_X0HE` (`knowledge-bh-ht-complete-archive.md:82,116`) | ⚠️ Nerasta | 4.558 × 9.328 (`:82`) | ⚠️ Nerasta |
| Oakington | n/a | linked-detached + carport (`knowledge-bh-ht-complete-archive.md:84,121`) | ⚠️ Nerasta | 4.711 × 9.328 (`:84`) | ⚠️ Nerasta |
| Avondale | n/a | `H456` L cross-gable (`knowledge-bh-ht-complete-archive.md:41`) | ⚠️ Nerasta | 9.665 × 10.218 (`:41`) | ⚠️ Nerasta |
| Holden | n/a | `H469` (`knowledge-bh-ht-complete-archive.md:42`) | ⚠️ Nerasta | 8.55 × 9.67 (`:42`) | ⚠️ Nerasta |
| Bradgate | n/a | `H417 X-H7` (`knowledge-bh-ht-complete-archive.md:67`) | ⚠️ Nerasta | 9.327 × 7.977 (`:67`) | ⚠️ Nerasta |
| Texel | n/a | `CTEX_X0GD` (`knowledge-bh-ht-complete-archive.md:55`) | ⚠️ Nerasta | 5.615 × 9.327 (`:55`) | ⚠️ Nerasta |
| Alverton | n/a | `BAVT_XVGD` 2-storey pair block, gable (`knowledge-bh-ht-complete-archive.md:45`) | ⚠️ Nerasta | 11.326 × 6.080 landscape (`:45`) | ⚠️ Nerasta |

(Plus 50+ additional BH names listed without block-code mapping at `knowledge-bh-house-types.md:60-65` — Alton, Aston, Barwick, Beckett, Birchwood, Braxton, Caldwell, Carlton, Clyde, Coton, Dalton, Darwen, Derwent, Downham, Draycott, Everton, Fenton, Fletcher, Fulton, Gosford, Hadleigh, Harlow, Heyford, Holden, Ilkeston, Ingleton, Jervaulx, Kempton, Kilburn, Larkin, Lynwood, Marford, Merton, Midford, Norton, Overton, Preston, Quinton, Roxwell, Rufford, Skipton, Stanford, Tilton, Upton, Welwyn, Wentworth, Windsor, Yarnton.)

### DWH (David Wilson Homes) House Types

Source: `knowledge-bh-house-types.md:74-143`, `knowledge-bh-ht-complete-archive.md:48-103`

| name | bedrooms | block_name_patterns | occurrence_count | typical_footprint_m2 | roof_color |
|---|---|---|---|---|---|
| Kenley | n/a | `BKNL_X0-I(0723)`, `BKNL_X0HE(0723)` (`knowledge-bh-house-types.md:76`) | ⚠️ Nerasta | 4.445 per unit (`:76`) | ⚠️ Nerasta |
| Chester (DWH) | n/a | `BCSR_X0FD(0623)` (`:77`) | ⚠️ Nerasta | 6.175 × 9.215 (`:77`) | ⚠️ Nerasta |
| Hesketh (DWH) | n/a | `BHSK_X0GD(0623)` (`:78`) | ⚠️ Nerasta | 5.615 × 9.103 (`:78`) | ⚠️ Nerasta |
| Moresby (DWH) | n/a | `BMMS_X0GE(0623)`, `BMMS_X0GD(0623)` (`:79`) | ⚠️ Nerasta | 5.24 × 8.9 / 5.39 × 8.9 (`:79`) | ⚠️ Nerasta |
| Norbury | n/a | `BNOR_X0GE(0123)` (`:80`) | ⚠️ Nerasta | 9.116 × 9.328 (per pair) (`:80`) | ⚠️ Nerasta |
| Maidstone (DWH) | n/a | `BMAI_X0HE(0123)`, `BMAI_X0-I(0123)` (`:81`) | ⚠️ Nerasta | 5.1 per unit (`:81`) | ⚠️ Nerasta |
| Hadley | n/a | `P341 XEG7` (gable det), `P341 WDH7` (hipped det) (`knowledge-bh-ht-complete-archive.md:56-57`) | ⚠️ Nerasta | 5.957 × 9.055 / 9.050 × 6.105 (`:56-57`) | ⚠️ Nerasta |
| Wincham 2 | n/a | `P231 XVH7(0623)` (`knowledge-bh-house-types.md:121`, `knowledge-bh-ht-complete-archive.md:58`) | ⚠️ Nerasta | 11.353 × 6.065 (`:58`) | ⚠️ Nerasta |
| Archford | n/a | `P382 XEH7/XI-7(0623)` (pair) (`knowledge-bh-house-types.md:121`, `knowledge-bh-ht-complete-archive.md:97`) | ⚠️ Nerasta | 10.504 × 8.658 (pair) / 5.252 per unit (`:97`) | ⚠️ Nerasta |
| Wilford | n/a | `P204 XEH7/XI-7(0623)` (`knowledge-bh-house-types.md:121`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Ingleby | n/a | `H403 X-F7` (`knowledge-bh-ht-complete-archive.md:59`) | ⚠️ Nerasta | 6.29 × 9.44 (`:59`) | ⚠️ Nerasta |
| Exeter | n/a | `H418 X-H7` (`knowledge-bh-ht-complete-archive.md:62`) | ⚠️ Nerasta | 9.809 × 10.131 (`:62`) | ⚠️ Nerasta |
| Meriden | n/a | `H429 X-H7` (`knowledge-bh-ht-complete-archive.md:60`) | ⚠️ Nerasta | 9.102 × 9.215 (`:60`) | ⚠️ Nerasta |
| Cornell | n/a | `H433 X-G7` (`knowledge-bh-ht-complete-archive.md:61`) | ⚠️ Nerasta | 7.077 × 10.115 (`:61`) | ⚠️ Nerasta |
| Chelworth | n/a | `H497 X-H7` (`knowledge-bh-ht-complete-archive.md:63`) | ⚠️ Nerasta | 10.030 × 8.99 (`:63`) | ⚠️ Nerasta |
| Lichfield | n/a | `H533---7` (`knowledge-bh-ht-complete-archive.md:64`) | ⚠️ Nerasta | 11.465 × 8.878 (`:64`) | ⚠️ Nerasta |
| Winstone | n/a | `H421--H7` (`knowledge-bh-ht-complete-archive.md:65`) | ⚠️ Nerasta | 11.015 × 8.09 (`:65`) | ⚠️ Nerasta |
| Kirkdale | n/a | `H442--H7` (`knowledge-bh-ht-complete-archive.md:66`) | ⚠️ Nerasta | 7.977 × 9.102 (`:66`) | ⚠️ Nerasta |
| Skylark | n/a | `C469 X-H7` (`knowledge-bh-ht-complete-archive.md:68`) | ⚠️ Nerasta | 8.54 × 9.665 L-shape (`:68`) | ⚠️ Nerasta |
| Hertford | n/a | `H470 X-G7` (`knowledge-bh-ht-complete-archive.md:69`) | ⚠️ Nerasta | 6.11 × 9.055 (`:69`) | ⚠️ Nerasta |
| Manning | n/a | `H577 X-H7` (`knowledge-bh-ht-complete-archive.md:70`) | ⚠️ Nerasta | 11.24 × 8.428 (`:70`) | ⚠️ Nerasta |
| Hazelborough | n/a | `N403` (`knowledge-bh-ht-complete-archive.md:201`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Greenwood | n/a | `T322 XEG7` (`knowledge-bh-ht-complete-archive.md:200`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Cannington | n/a | `T321 XEH7/XI-7` (`knowledge-bh-ht-complete-archive.md:200`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Kennett | n/a | `T310 XEG7/T310-I-7` (`knowledge-bh-ht-complete-archive.md:99`) | ⚠️ Nerasta | 10.466 × 8.54 pair (`:99`) | ⚠️ Nerasta |
| SH50/SH52/SH54/SH55 | n/a | `SH50-I-7/SH50 XEH7`, `SH52 XEH7`, `SH54 XEH7`, `SH55-E-7` (`knowledge-bh-house-types.md:124`) | ⚠️ Nerasta | various 4.7–5.82 × 8.8–10.15 (`knowledge-bh-ht-complete-archive.md:100-103`) | ⚠️ Nerasta |
| SF58/SF59 | n/a | `SF58-E-7_SF59-EH7(0521)` (`knowledge-bh-house-types.md:123`) | ⚠️ Nerasta | 6.065 × 8.765 (`knowledge-bh-ht-complete-archive.md:120`) | ⚠️ Nerasta |
| SB88 (Cherwell+Chichester) | n/a | `SB88---7(0521)` (`knowledge-bh-house-types.md:123`, `knowledge-bh-ht-complete-archive.md:87`) | ⚠️ Nerasta | 19.243 × 10.816 L-shape (`:87`) | ⚠️ Nerasta |
| Garages | n/a | `SSG1H8(0623)`, `SDG1H8(0623)`, `SDG2H8`, `STG2H8` (`knowledge-bh-ht-complete-archive.md:132-136`) | ⚠️ Nerasta | 2.946 × 5.615 / 5.564 × 5.615 / 8.182 × 5.615 (`:132-136`) | ⚠️ Nerasta |

(Plus 70+ additional DWH names without block-code mapping at `knowledge-bh-house-types.md:132-143`.)

### Redrow House Types

Source: `knowledge-redrow-ht-complete-archive.md:19-58, 100-141`

| name | bedrooms | block_name_patterns | occurrence_count | typical_footprint_m2 | roof_color |
|---|---|---|---|---|---|
| Amberley | 3 | (Heritage 3BR, kitchen/dining 5.70×3.37) (`:21`) | ⚠️ Nerasta block | ⚠️ Nerasta full footprint | ⚠️ Nerasta |
| Durham | 3 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Lincoln 3 | 3 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Stamford | 3 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Bakewell | 3 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Letchworth | 3 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Shrewsbury 3 | 3 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Warwick | 3 | (kitchen/dining 5.76×3.72) (`:29`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Balmoral | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Canterbury | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Harrogate | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Kensington | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Lincoln | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Oxford | 4 | (Arts & Crafts; bay windows + roofed porch) (`:38`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Shaftesbury | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Stratford | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Welwyn | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Cambridge | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Chester (Redrow) | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Henley | 4 | (2 en suites; 36ft family/kitchen) (`:43`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Ledsham | 4 | (1841 sqft) (`:43`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Marlow | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Richmond (Redrow) | 4 | (2030 sqft) (`:46`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Shrewsbury | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Sunningdale | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Windsor | 4 | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Kennett (Redrow Inspired) | 3 | (3-storey) (`:52`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| Hesketh (Redrow Inspired) | 4 | name conflict with BH (`:53`) | ⚠️ Nerasta | ⚠️ Nerasta | ⚠️ Nerasta |
| RW01_GAB_53x87 | n/a | proposed code, simple gable (`:135,193`) | 11 unique locations (`:135`) | 8.734 × 5.332 (`:135,193`) | ⚠️ Nerasta |
| RW02_GAB_MONOEXT_93x60 | n/a | main gable + side mono-pitch + 3 velux (`:200`) | 9 unique locations (`:204`) | main 7.2×6.04 + ext 2.14×6.04 (`:201-202`) | ⚠️ Nerasta |
| RW03_GAB_98x63 | n/a | simple gable (`:215`) | 6 unique (`:216`) | 9.778 × 6.283 (`:215`) | ⚠️ Nerasta |
| RW04_GAB_88x59 | n/a | main gable + east mono-pitch ext (3 velux) + west canopy (`:218`) | 5 unique (`:222`) | 8.842 × 5.864 (`:219`) | ⚠️ Nerasta |
| RW_GAR_DBL_64x61 | n/a | double gable garage (`:108`) | 6 (`:108`) | 5.952 × 5.611 (`:108`) | ⚠️ Nerasta |
| RW_GAR_SGL_59x35 | n/a | single gable garage, ridge SHORT direction (Redrow unique) (`:109,191`) | 6 (`:109`) | 5.611 × 2.978 (`:109`) | ⚠️ Nerasta |

Redrow site overview totals (`knowledge-redrow-ht-complete-archive.md:80-87`): 102 detached / 22 pair / 14 terrace / 42 garages. Total dwelling units ≈ 188. Roof topology counts: 70 simple gable, 54 hipped+wing/bay, 13 complex hipped, 8 very complex (≥10), 5 simple hipped.

### Block naming conventions (regex proposals)

From observed patterns in `knowledge-bh-house-types.md` and `knowledge-bh-ht-complete-archive.md`:

```
DWH coded HT:    ^(P|S[BDFHGS]|T|H|N|C)\d{2,4}[\s_\-X]+[A-Z\-]+\d?\(?\d{0,4}\)?$
                 e.g. P204 XEH7, P341 XEG7, P382 XEH7, T310 XEG7, H403 X-F7, H429 X-H7, H497 X-H7, N403, C469 X-H7

DWH named HT:    ^B[A-Z]{2,3}_X0(HE|GE|GD|FD|-I)\(\d{4}\)$
                 e.g. BKNL_X0HE(0723), BCSR_X0FD(0623), BHSK_X0GD(0623), BMMS_X0GE(0623), BNOR_X0GE(0123), BMAI_X0-I(0123), BBNF_X0GE, BENN_X0GE, BSME_X0HE, BAVT_XVGD, BLLE_X0HE

Suffix semantics (knowledge-bh-house-types.md:177-179):
  -EH = End House (hip clip at outer end)
  -I  = Interior/Intermediate (full gable, party walls both sides)
  -GE = Gable End
  -GD = Gable Detached
  -FD = (DWH) detached
  -HE = (variant)

Garages (knowledge-bh-ht-complete-archive.md:130-136):
  ^(SSG|SDG|STG)\d?H8\(\d{4}\)$  (BH/DWH)
  ^RW_GAR_(SGL|DBL)_\d{2}x\d{2}$  (Redrow, knowledge-redrow-ht-complete-archive.md:108)

Redrow proposed:
  ^RW\d{2}_(GAB|XGB)_(MONOEXT_)?\d{2,3}x\d{2,3}$  (knowledge-redrow-ht-complete-archive.md:135-143)
```

⚠️ Nerasta: explicit "BH_<HOUSE_NAME>_*" pattern in any file. The BH brand uses `BBNF_*`, `BLLE_*`, `BHSK_*` etc. (initials of house name), NOT a literal `BH_` prefix.

### Roof pitch standard

`knowledge-bh-roof-pitch-standards.md:14-18`: **40° main pitch** for all BH/DWH; eave 7.500m (2-storey). Garage 22.5° pitch, 2.4m eave. Cross-gable wing pitches auto-matched to T-junction (e.g. Alderney wing 31.8° to match main 40° at T-junction).

---

## Q2. Plot & Parking Numbering — Automation Status

### Modules

#### `plot_numbers.py`
- Path: `E:/cad-site-agent/src/cad_site_agent/numbering/plot_numbers.py`
- last_modified: 2026-03-12 18:29 UTC
- is_implemented: **YES**
- Public API (line 23-39): `NumberingReport`, `write_plot_numbers(source_dxf, candidates, output_dxf, *, text_height=4.0, layer="NUMBERING_PLOT", class_filter=("rear_garden",), developer="UNKNOWN", start_number=1) -> NumberingReport`
- Input: source DXF path, list of candidate dicts (each has `class_guess` and `region.bbox`), output path
- Output: writes `output_dxf` copy + adds TEXT entities on layer `NUMBERING_PLOT` (color 7), centred at bbox centroid
- uses_LISP: **NO** (pure ezdxf Python)
- tested: **YES** — `E:/cad-site-agent/tests/test_plot_numbers.py`, plus `test_plot_house_mapper.py`, `test_plot_consistency_qa_skill.py`, `test_plot_number_skill.py`, `test_normalise_plots.py`, `test_pipeline_numbering.py`
- Known limitations: TEXT (not MTEXT); rotation hardcoded 0.0; only writes plots whose `class_guess == "rear_garden"`; FileExistsError if output path exists; default text_height=4.0
- Function body (lines 29-93, 65 lines — abridged to numbering loop only):

```python
def write_plot_numbers(source_dxf, candidates, output_dxf, *,
                      text_height=4.0, layer="NUMBERING_PLOT",
                      class_filter=("rear_garden",),
                      developer="UNKNOWN", start_number=1) -> NumberingReport:
    src_path = Path(source_dxf); out_path = Path(output_dxf)
    if out_path.exists(): raise FileExistsError(...)
    shutil.copy2(str(src_path), str(out_path))
    doc = ezdxf.readfile(str(out_path)); msp = doc.modelspace()
    if layer not in doc.layers: doc.layers.add(layer, dxfattribs={"color": 7})
    style_name = style_for_developer(developer)
    if style_name not in doc.styles: doc.styles.add(style_name, font="")
    written = 0; skipped = 0; plot_num = start_number
    for cand in candidates:
        if cand.get("class_guess") not in class_filter:
            skipped += 1; continue
        bbox = cand["region"]["bbox"]
        cx = (bbox[0]+bbox[2])/2.0; cy = (bbox[1]+bbox[3])/2.0
        text_ent = msp.add_text(str(plot_num), dxfattribs={
            "layer": layer, "height": text_height, "style": style_name,
            "rotation": 0.0})
        text_ent.set_placement((cx, cy, 0),
            align=ezdxf.enums.TextEntityAlignment.MIDDLE_CENTER)
        written += 1; plot_num += 1
    doc.saveas(str(out_path))
    return NumberingReport(total_written=written, total_skipped=skipped)
```

#### `parking_numbers.py`
- Path: `E:/cad-site-agent/src/cad_site_agent/numbering/parking_numbers.py`
- last_modified: 2026-03-12 18:29 UTC
- is_implemented: **YES**
- Public API (line 32-71): `ParkingNumberingReport`, `longest_edge_angle(vertices) -> float`, `write_parking_numbers(source_dxf, candidates, output_dxf, *, text_height=2.0, layer="NUMBERING_PARKING", class_filter=("parking",), developer="UNKNOWN", start_number=1) -> ParkingNumberingReport`
- Input/Output: same shape as plot_numbers; layer color=3; rotation aligned with longest polygon edge mod 180°
- uses_LISP: **NO**
- tested: **YES** — `tests/test_parking_numbers.py`, `test_parking_bay_skill.py`, `test_parking_consistency_qa_skill.py`
- Known limitations: TEXT (not MTEXT); falls back to bbox corners if `region["vertices"]` missing
- Algorithm (lines 32-52):

```python
def longest_edge_angle(vertices: list[tuple[float, float]]) -> float:
    if len(vertices) < 2: return 0.0
    best_len = -1.0; best_ang = 0.0
    n = len(vertices)
    for i in range(n):
        x1, y1 = vertices[i]; x2, y2 = vertices[(i + 1) % n]
        dx, dy = x2 - x1, y2 - y1
        edge_len = math.hypot(dx, dy)
        if edge_len > best_len:
            best_len = edge_len
            best_ang = math.degrees(math.atan2(dy, dx)) % 180.0
    return best_ang
```

Numbering loop (lines 100-130):

```python
for cand in candidates:
    if cand.get("class_guess") not in class_filter:
        skipped += 1; continue
    region = cand["region"]; bbox = region["bbox"]
    cx = (bbox[0]+bbox[2])/2.0; cy = (bbox[1]+bbox[3])/2.0
    verts = region.get("vertices") or []
    if not verts: verts = _bbox_vertices(bbox)
    angle = longest_edge_angle([(float(v[0]), float(v[1])) for v in verts])
    text_ent = msp.add_text(str(bay_num), dxfattribs={
        "layer": layer, "height": text_height,
        "style": style_name, "rotation": angle})
    text_ent.set_placement((cx, cy, 0),
        align=ezdxf.enums.TextEntityAlignment.MIDDLE_CENTER)
    written += 1; bay_num += 1
```

#### `font_rules.py`
- Path: `E:/cad-site-agent/src/cad_site_agent/numbering/font_rules.py`
- is_implemented: **YES** (partial — only 2 developers mapped)
- API (lines 7-16):

```python
_STYLE_MAP: dict[str, str] = {
    "BARRATT HOMES": "DINPro-Bold",
    "DAVID WILSON HOMES": "CenturyGothic-Bold",
}
_DEFAULT_STYLE = "Standard"

def style_for_developer(developer: str) -> str:
    return _STYLE_MAP.get(developer.strip().upper(), _DEFAULT_STYLE)
```
- Known limitations: no Redrow mapping (`⚠️ Nerasta` for Redrow); style names assume DXF reader has those font files registered

#### `plot_house_mapper.py`
- Path: `E:/cad-site-agent/src/cad_site_agent/housing/plot_house_mapper.py`
- is_implemented: **YES**
- API (line 69-76): `map_plots_to_houses(plots, legend, text_entities, *, developer="UNKNOWN", max_text_distance=3000.0) -> list[HouseRecord]`
- Logic (lines 9-12, 80-167): 4-priority ladder
  1. legend_color_match (hatch ACI matches legend) → conf 0.95
  2. nearby_house_type_match (text within 3000 units) → conf 0.75 if bedrooms validated, 0.55 if not
  3. ambiguous (bedrooms only, no HT) → conf 0.30
  4. no_match → conf 0.0
- Tested: `tests/test_plot_house_mapper.py`

#### `house_type_detector.py`
- Path: `E:/cad-site-agent/src/cad_site_agent/housing/house_type_detector.py`
- is_implemented: **YES**
- API: `detect_house_type(text: str) -> str | None` (line 75)
- Regex (line 25-32): captures 1-4 word tokens after "The"; handles Unicode dashes, parentheticals, NBSP normalisation
- False-positive filter (line 41-48): rejects road suffixes (road, street, avenue, lane, close, drive, way, place, court, crescent, grove, gardens, green, mews, walk) + road codes `^[A-Z]\d+$`

### rear_garden_detection logic

Grep `rear_garden|garden_centroid|back_garden|plot_rear` across `E:/cad-site-agent/src` returned:
- `E:/cad-site-agent/src/cad_site_agent/numbering/plot_numbers.py:38` — `class_filter: tuple[str, ...] = ("rear_garden",)` (default filter — only candidates labelled `rear_garden` get a number written)
- `E:/cad-site-agent/src/cad_site_agent/validation/plan_validator.py` — also references the term

⚠️ Nerasta: explicit "centroid of garden" computation function. The code consumes pre-computed `region.bbox` and uses `(minx+maxx)/2, (miny+maxy)/2` as the placement point — the upstream classifier (not in numbering/) is responsible for producing `class_guess="rear_garden"` candidates.

### Manual workflow evidence

`knowledge-illustrator-number-placement.md:30-77` describes the manual placement spec the automation must reproduce: anchor at plot centroid, rotation aligned to plot long axis, font CenturyGothic-Bold or MyriadPro-Regular at 8pt (A3) / 6-7pt (A4), color CMYK(100,81,42,41), sequential integers starting from 1 following road clockwise. Multi-brand split: separate `BH PLOTNUMBERS`, `DWH PLOT NUMBERS` layers. Parking smaller (4-5pt CenturyGothic-Bold), per-plot increment pattern (e.g. `1a`, `1b`).

---

## Q3. Time per 3DSP Project

Search across `C:/Users/zilva/ClaudeAIOS/`, `E:/AgentOS/`, all `MEMORY.md` files for `hours|minutes|time spent|duration|workflow time|manual` returned the following relevant hits:

| source_file:line | context | time | stage |
|---|---|---|---|
| `knowledge-3dsmax-cad-amends-workflow.md:25` | "Manual darbas: rankiniu būdu sutapdinti kerb'us… Valandinis kas savaitę darbas per 60+ layer'ių." | "Valandinis" (≈ 1 hour, weekly) | Manual DWG amends merge into Max scene |
| `knowledge-3dsmax-cad-amends-workflow.md:27` | "Automated darbas: 30 sekundžių per vieną batch swap su MAXScript" | 30 s per batch | Spline swap automation |
| `knowledge-3dsmax-cad-amends-workflow.md:238` | "8 swap'ai + 2 create'ai + highlight'as per ~2 sekundes" | ~2 s | Spline swap batch run |
| `knowledge-3dsmax-cad-amends-workflow.md:329` | "Method validated on Barratt/DWH site plan (15,482 objects, 16.9M polys). 2 sec execution time." | 2 s | Spline swap (validated) |
| `knowledge-3dsmax-full-workflow-lessons-learned.md:135` | "Phase 0 — Pre-flight check (5 min)" | 5 min | DWG audit/purge before import |
| `knowledge-3dsmax-full-workflow-lessons-learned.md:146` | "Phase 1 — Import į 3ds Max (5 min)" | 5 min | DWG → Max import |
| `knowledge-3dsmax-full-workflow-lessons-learned.md:161` | "Phase 2 — Scene foundation (10 min)" | 10 min | Ground plane + V-Ray + cameras |
| `knowledge-3dsmax-full-workflow-lessons-learned.md:169` | "Phase 3 — Housetypes (15-30 min, priklausomai nuo count)" | 15-30 min | HT block placement |
| `knowledge-3dsmax-full-workflow-lessons-learned.md:178` | "Phase 4 — Hardscape (5-10 min)" | 5-10 min | Roads, plot, parking, steps, retaining |
| `knowledge-3dsmax-full-workflow-lessons-learned.md:187` | "Phase 5 — Vegetation (10-20 min)" | 10-20 min | Forest Pack scatter |
| `knowledge-3dsmax-full-workflow-lessons-learned.md:213` | "Phase 6 — Render test + iterate (10 min)" | 10 min | Test render |
| `knowledge-3dsmax-full-workflow-lessons-learned.md:298` | "60-120 min laiko pilnam end-to-end test'ui" | 60-120 min | Full end-to-end test budget |

**Coverage by stage:**

- DWG cleanup: ⚠️ Nerasta dedicated time (only Phase 0 5-min "audit + purge" — Pre-flight only, not full cleanup workflow)
- Illustrator color fill: ⚠️ Laiko duomenų faile nėra (out of scope per Q3 instruction; not extracted)
- 3DS Max import: 5 min
- Modeling hardscape: 5-10 min
- Modeling softscape: 10-20 min
- Render: 10 min
- Photoshop: ⚠️ Laiko duomenų faile nėra
- Final Illustrator template: ⚠️ Laiko duomenų faile nėra

End-to-end Max stage budget per project (sum of 3DS Max stages alone): **45-90 minutes** (Phase 0 + 1 + 2 + 3 + 4 + 5 + 6) per `knowledge-3dsmax-full-workflow-lessons-learned.md:131-220`.

---

## Q4. Block Vocabulary Breakdown (1147 blocks → categories)

Source: `E:/pdf errors validation pipeline/training/cleanup_gt/max_block_vocabulary.json` (field `blocks` is a dict of `name → {count, semantic}`; `total_blocks: 1147`, `total_instances: 58808`).

The dataset already carries a `semantic` field per block. Counts per semantic value:

| category | block_count | top_5_examples_with_counts |
|---|---|---|
| OTHER (mixed) | 943 | `Block_Chainlink_6mm_DIN766-Solid`(424), `Layer_5215`(424), `Box10197`(236), `obj_238`(236), `obj_239`(236) |
| VEGETATION (trees + low-veg proxies) | 129 | `VRayProxy_OnyxTREE7551`(2788), `VRayProxy_iTrees-01-GenericTree_`(2176), `VRayProxy_OnyxTREE9773`(974), `VRayProxy_OnyxTREE8889`(965), `VRayProxy_iTrees-01-GenericTre03`(896) |
| REFUSE | 26 | `Layer_Robinia21`(40), `Layer_Robinia117`(20), `Layer_Robinia043`(16), `Layer_Robinia04`(15), `Layer_Robinia37`(10) |
| HT_HOUSE | 15 | `Block_H7754_-_H469_AS_-_PLOTS_5_`(8), `Block_H7754_-_411_OPP_-_PLOT_9_2`(6), `Block_H7754_-_411_OPP_-_PLOTS_7_`(6), `Block_H7754_-_SH50I_OPP_-_PLOTS_`(6), `Block_T52_END_AS_-_PLOTS_87_89_1`(6) |
| FENCING | 14 | `CB_post_0001`(5334), `CB_post_00`(3417), `CB_post_002`(3301), `CB_post_608`(3174), `CB_post_001`(2212) |
| DRAINAGE_FIXTURE | 7 | `Block_F_RWP`(1106), `Layer_F_RWP`(1106), `Block_F_SFG`(829), `Layer_F_SFG`(829), `Block_F_SVP`(766) |
| OUTBUILDING | 5 | `Block_garden_gate`(167), `Block_new_shed_3_bed`(39), `Block_new_shed_2_bed`(22), `Block_SHED_4_BED`(6), `Layer_BHN_-_Sheds`(3) |
| RAILING | 5 | `Kneerailpost007`(66), `Kneerailpost001`(27), `Kneerailpost00101`(18), `Kneerailpost006`(15), `Knee_Rail_00`(1) |
| SURVEY | 1 | `Block_SURVEY_XREF__07_12_16_$0$S`(868) |
| LIGHTING (STREET_LAMP) | 1 | `Block_Surface_Mounted_Light`(4) |
| FURNITURE (SITE_FURNITURE) | 1 | `00_benches`(1) |
| **TOTAL** | **1147** | |

Mapping to the requested fixed taxonomy:
- `HT_HOUSE` = 15
- `VEGETATION_TREE` ⊂ `VEGETATION` (129) — bulk are `VRayProxy_OnyxTREE*` / `iTrees*` (trees); ⚠️ Nerasta sub-split into TREE vs HEDGE vs SHRUB vs FLOWER inside the JSON
- `VEGETATION_HEDGE`, `VEGETATION_SHRUB`, `VEGETATION_FLOWER` = ⚠️ Nerasta (semantic field bundles all into `vegetation`)
- `SITE_FURNITURE` = 1 (only `00_benches`)
- `PARKING_MARKER` = ⚠️ Nerasta (no dedicated parking semantic in JSON)
- `PLAY_EQUIPMENT` = ⚠️ Nerasta
- `STREET_LAMP` = 1 (`Block_Surface_Mounted_Light`)
- `SIGN_POST` = ⚠️ Nerasta
- `BOLLARD` = ⚠️ Nerasta
- `FENCE_POST` = 14 (semantic `fencing` — all `CB_post_*` close-board posts)
- `VEHICLE_SWING` = ⚠️ Nerasta
- `PERSON_FIGURE` = ⚠️ Nerasta
- `TITLE_BLOCK` = ⚠️ Nerasta
- `NORTH_ARROW` = ⚠️ Nerasta
- `SCALE_BAR` = ⚠️ Nerasta
- `OTHER_DELETE` / `OTHER_KEEP` distinction = ⚠️ Nerasta in this JSON (943 in undifferentiated "other")
- `UNKNOWN` = 0 (every block has a `semantic` field — but 943 = "other", which is effectively unclassified)

**Classified vs UNKNOWN:** Strict classification (HT_HOUSE + vegetation + refuse + fencing + drainage_fixture + outbuilding + railing + survey + lighting + furniture) = **204** blocks. "Other" pool = **943** blocks. Of 1147 total, **17.8% are sharply classified, 82.2% sit in the catch-all `other` semantic.**

### rare_blocks_long_tail
Blocks with `count <= 2` across all 8 projects: **179** (15.6 % of vocabulary). These are mostly per-project unique items (project-specific asset names) and should be candidates for further triage via `user_blacklist.json` rules.

### block_footprints.json (separate dataset)
Only **6** blocks with footprint dimensions (`block_footprints.json:total_blocks=6`); sampled from `ramblers_gate_modelling_ready` and `brook_view_modelling_ready` only. All 6 categorised as `other`. ⚠️ Nerasta: footprint coverage for the bulk 1141 blocks.

---

## Q5. Layer Naming Conventions per Client

Source: 8 `*_layer_diff.json` files in `E:/pdf errors validation pipeline/training/cleanup_gt/` + `max_ground_truth.json` + `layer_category_reference.json` + `semantic_bridge.json`.

### Per-project breakdown

| project | client (inferred) | raw_layer_count | max_layer_count | naming_prefix_patterns | top 10 prefixes (raw_only) | underscores (per layer) | spaces (per layer) | numerics |
|---|---|---|---|---|---|---|---|---|
| bingham_ph3 | DWH (BDW + DWH prefixes dominate) | 1205 | 134 | `BASE`, `BDW`, `DWH`, `ARCHITECTS`, `MAIN`, `SURVEY` | BASE(306), BDW(291), DWH(179), ARCHITECTS(116), MAIN(99), SURVEY(92), A(20), OS(13), SOFT(11), F(10) | 897/1205 (74%) | 1160/1205 (96%) | 1142/1205 (95%) |
| brook_view | unknown (Redrow indicators in MEMORY) | 442 | 63 | `X` (xref-prefixed dominant) | X(389), CONTOURS(2), PLOT(2), ROAD(2), DEFPOINTS(1), DROPS(1) | 433/442 (98%) | 427/442 (97%) | 391/442 (88%) |
| fairfields | BH (BHN + 57357 numeric job code) | 207 | 112 | `57357` (job code), `AREA`, `M`, `BHN` | 57357(110), AREA(72), M(9), A(4), BHN(1), DEFPOINTS(1), VPORTS(1) | 91/207 (44%) | 190/207 (92%) | 182/207 (88%) |
| kings_court | DWH (BDWS prefix) | 467 | 77 | `SITE`, `TOPO`, `BDWS` | SITE(196), TOPO(106), BDWS(85), 07(19), ARB(19), A(9), KRT(6), ASHP(5), 0(4), BHN(3) | 157/467 (34%) | 421/467 (90%) | 277/467 (59%) |
| ramblers_gate | unknown (Architect/Survey prefixes) | 258 | 10 | `ARCHITECTS`, `SURVEY`, `LANDSCAPE` | ARCHITECTS(96), SURVEY(94), LANDSCAPE(29), EXTERNALS(9), ROAD(8), A010(3), G971(2), A012(1), A953(1), APPLICATION(1) | 251/258 (97%) | 52/258 (20%) | 119/258 (46%) |
| towcester | BH (BHN + H9387 + RED + BDW mixed-brand) | 798 | 112 | `XREF`, `H9387` (job code), `BHN`, `RED`, `F`, `BDW` | XREF(200), H9387(160), BHN(125), RED(109), F(46), BDW(43), A(17), H(16), 04(8), 01(4) | 446/798 (56%) | 689/798 (86%) | 494/798 (62%) |
| wigston | mixed BH + DWH + Redrow + Barratt | 2192 | 208 | `DWH`, `LIGHTING`, `E833`, `BARRATT`, `NEW`, `BUILDING`, `EMPLOYMENT`, `ARCHITECT`, `REDROW`, `TOPOSURVEY` | DWH(299), LIGHTING(272), E833(248), BARRATT(132), NEW(132), BUILDING(130), EMPLOYMENT(128), ARCHITECT(110), REDROW(98), TOPOSURVEY(90) | 1278/2192 (58%) | 1971/2192 (90%) | 1690/2192 (77%) |
| wixam_r1_r5_r6 | BH (BHN + H75xx job codes) | 2276 | 157 | `H7519`, `H7516`, `H7513`, `H7520`, `H7517`, `ROADS`, `XREF`, `BHN`, `F` | H7519(577), H7516(276), H7513(266), H7520(261), H7517(194), ROADS(191), XREF(148), BHN(84), F(44), DE(40) | 791/2276 (35%) | 2159/2276 (95%) | 1917/2276 (84%) |

### Summary by client

**BH (Barratt Homes) typical prefixes** (from `bingham_ph3`, `fairfields`, `towcester`, `wigston`, `wixam_r1_r5_r6`):
- `BHN` (Barratt Homes Northampton or generic BH-namespace)
- `BHN_` (under_score-separated, e.g. `BHN_Plot_Number`, `BHN_-_Sheds`)
- `BDW-A-` (Barratt David Wilson architectural prefix, e.g. `BDW-A-HOUSETYPE`, `BDW-A-ROAD CHANNEL`, `BDW-A-SITE BOUNDARY`) — `knowledge-3dsmax-cad-amends-workflow.md:218,247`
- `BARRATT_*` (in wigston multi-brand)
- Job codes: `H75xx`, `H9387`, `E833` (project-specific numeric codes)
- `F ` (with space — F-prefix = Footprint, e.g. `F Roof`, `F Ext Wall`, `F Patio`, `F Canopy`, `F Party Wall`, `F Door Surround`, `F Roof Hatch 1/2`, `F Text Sales - DWH`) — `knowledge-3dsmax-cad-amends-workflow.md:262`, `knowledge-bh-ht-complete-archive.md:268`

**DWH (David Wilson Homes) typical prefixes** (from `bingham_ph3`, `kings_court`):
- `DWH-002-` (e.g. `DWH-002-Road Kerbline`, `DWH-002-Road Footpath`, `DWH-002-Drives`, `DWH-002-Plot Division`, `DWH-002-Screen Wall`, `DWH-002-Close Board fence`) — `knowledge-3dsmax-cad-amends-workflow.md:218-225, 244-253`
- `BDWS_` (BDW S-namespace, e.g. `BDWS_Plot_HT Code`) — `knowledge-illustrator-number-placement.md:34`
- `DWH PARKING NUMBERS`, `DWH PLOT NUMBERS`, `DWH ANNOTATIONS MP 2DSP` — `knowledge-illustrator-overlay-layers.md:23-44`

**Redrow typical prefixes** (from `wigston`, MEMORY notes about Redrow):
- `REDROW`
- `PDF_CP-crib_*` (e.g. `PDF_CP-crib_velux`, `PDF_CP-crib outline`, `PDF_CP-crib_rooflines`, `PDF_CP_WD_WALL External`) — `knowledge-redrow-ht-complete-archive.md:65-72`
- `RW_GAR_*`, `RW01..RWnn` proposed for HT (`knowledge-redrow-ht-complete-archive.md:108,135`)
- "Redrow-prefix blocks = First time homes, Parking Spaces, Bins, Sheds, Trees, Gates" (MEMORY.md "CAD Agent Critical Rules")

**Common to all (cross-client)** — in Max-kept layers (Max GT prefixes from `max_ground_truth.json`):
- `#00_*` semantic group prefix (Max grouping convention) — every project keeps 4-8 of these
- `MOD` (modelling marker) — every project keeps ~4
- `06` (numeric pattern) — every project has 2
- `F ` (footprint family — used by both BH and DWH after Max cleanup)
- `XREF` (xref-bound layers — towcester 200, wixam 148)
- `ARCHITECTS`, `SURVEY`, `TOPOSURVEY`, `LANDSCAPE` — discipline prefixes (cross-client consultancy outputs)
- `JPP_` (civil/landscape consultant prefix) — `knowledge-3dsmax-cad-amends-workflow.md:265`

### Naming character usage
- Spaces in layer names: dominant in BH/DWH (86-96%), rarer in `ramblers_gate` (20%)
- Underscores: dominant in `brook_view` (98%), `ramblers_gate` (97%); minority in `fairfields` (44%) and `wixam` (35%)
- Numeric codes: 46-95% of layer names contain digits across all projects (job codes + house codes drive this)

---

## Q6. 3DS Max Output Validation Criteria

Source: `knowledge-3dsmax-cad-amends-workflow.md`, `knowledge-3dsmax-full-workflow-lessons-learned.md`, `knowledge-3dsmax-site-plan-modeling.md`.

### DXF version
⚠️ Nerasta — explicit DXF version (R2010, R2018 etc.) not stated.

### Units
⚠️ Nerasta dedicated unit declaration. Indirect: roof spec uses metres (`knowledge-bh-ht-complete-archive.md:14, 169-180`); `block_footprints.json` shows mixed units (some blocks in mm: `Ridge_Tile_mix_008` width 1964.49, others in m: `Block_garden_gate` 1.83 — `block_footprints.json:9-24`). Max import dialog specifies "Weld nearby vertices threshold 0.1" (`knowledge-3dsmax-full-workflow-lessons-learned.md:151`) without specifying unit interpretation.

### Z coord
- Eave: 7.500 m (2-storey BH/DWH standard) (`knowledge-bh-roof-pitch-standards.md:104`, `knowledge-bh-ht-complete-archive.md:171`)
- Canopy/porch top: 2.7 m (`knowledge-bh-ht-complete-archive.md:174`, `knowledge-bh-roof-pitch-standards.md:106`)
- Ridge Z: typically 9.5 - 11.5 m at 40° pitch (`knowledge-bh-roof-pitch-standards.md:107`)
- Rear bay / lead box: 2.7 m flat top (`knowledge-bh-ht-complete-archive.md:178`)
- Garage eave: 2.4 m, ridge ~3.0-3.6 m (22.5° pitch) (`knowledge-bh-ht-complete-archive.md:180`, `:132-136`)

### Block handling (INSERTs)
- INSERT entities = house blocks = NEVER drop (MEMORY rule + `knowledge-cad-site-agent-whitelist-training.md` referenced)
- `apply_whitelist.py` rescues INSERTs on dropped layers (MEMORY)
- Layer "0" often holds INSERTs — never drop by layer name alone (MEMORY)
- Total INSERTs across 8 GT projects: 58,808 (`max_block_vocabulary.json:total_instances`)

### Xref handling
- ezdxf.xref bind: `xref.load_modelspace(sdoc, tdoc)` (MEMORY rule); accoreconsole hangs on prompts → not used
- Brook View test: 6 xrefs, 2/6 merged via ezdxf, 4 failed on `ACAD_PROXY` (MEMORY "SESSION END 2026-04-19")
- Max import bug (open): "Do Not Resolve any Xrefs" option PERSISTS between imports → 32K → 1.9K object regression (MEMORY)
- Recommended: fully bind xrefs in DXF before import OR reset Max import options each run (MEMORY)

### Max entities/layers limits & quirks
- Tipinė Barratt/DWH scenoje: SplineShape ~3291, Editable_Poly ~3159, Editable_mesh ~3078, PolyMeshObject ~2842, Dummy ~2282, VRayProxy ~795, **LinkComposite ~3176** (bug source), Forest_Pro ~14 (`knowledge-3dsmax-site-plan-modeling.md:23-34`)
- 18,659 total objects, 16.9M polys validated (`knowledge-3dsmax-site-plan-modeling.md:127`, `knowledge-3dsmax-cad-amends-workflow.md:329`)
- MCP bridge timeout: 120 s (`knowledge-3dsmax-full-workflow-lessons-learned.md:88`)
- `snapshotAsMesh` on 15k+ objects: prohibitively slow (10-100 ms per object, freezes Max) — never iterate (`knowledge-3dsmax-cad-amends-workflow.md:165-178`, `knowledge-3dsmax-full-workflow-lessons-learned.md:96-99`)

### Known Max quirks
1. **Alt+Q + ESC crash loop** in scenes with LinkComposite — root cause `ADT_Object_Manager_Wrapper` callback chain — fix: delete all `LinkComposite` and `LinkCompositeshape` (`knowledge-3dsmax-site-plan-modeling.md:50-138`)
2. **`copy newObj` inherits `isHidden=true`** — always set `clone.isHidden = false` after copy (`knowledge-3dsmax-cad-amends-workflow.md:296-303`)
3. **`getNodeByName` returns first match only** — must filter by parent group when multiple nodes share a name (`knowledge-3dsmax-cad-amends-workflow.md:305-318`)
4. **`clone.layer = X` is read-only** — use `targetLayer.addNode clone` instead (`knowledge-3dsmax-cad-amends-workflow.md:151-161`)
5. **`Sweep` modifier `builtInShapeLength` does not exist** — use shape-prefix property names (`sw.shapes[2].angle_length`) (`knowledge-3dsmax-full-workflow-lessons-learned.md:101-106`)
6. **`mergeMAXFile` 3-4 presets > 120 s** — merge one preset per MCP call (`knowledge-3dsmax-full-workflow-lessons-learned.md:88-93`)
7. **Forest Pack on `4_HEDGE_PATTERN` / `4_PLANTINGAREA_PATTERN`** = jungle (these are hatch line layers, not zone polygons) (`knowledge-3dsmax-full-workflow-lessons-learned.md:64-74`)

### Required DWG import settings (mandatory pre-flight)
`knowledge-3dsmax-site-plan-modeling.md:144-153`, `knowledge-3dsmax-full-workflow-lessons-learned.md:148-156`:
- AutoCAD: run `AUDIT` + `PURGE All` before export
- Max import dialog:
  - Derive AutoCAD Primitives by: **Layer, Blocks as Node Hierarchy**
  - Use Extrude modifier to represent thickness: **ON**
  - **Create one scene object for each ADT object: OFF** (prevents LinkComposite crash source)
  - Weld nearby vertices: ON, threshold 0.1
  - Auto-smooth: ON
- Post-import auto-cleanup:

```maxscript
for o in objects where (classOf o) == LinkComposite do delete o
for o in objects where (classOf o) == LinkCompositeshape do delete o
```

### Post-import #00_* group rules
`max_ground_truth.json` shows every project keeps **4-8 layers prefixed `#00_*`**. From MEMORY ("Brook View test artifacts"): "Max with 15 #00_* semantic groups" — these are post-import semantic re-grouping markers. The layer remap step is performed via MAXScript `C:/temp/remap_layers.ms` (working) — NOT Python `remap_layers_to_max_groups.py` (broken: ezdxf saveas corrupts `ACAD_PROXY`).

⚠️ Nerasta: explicit list of all 15 `#00_*` group names + which raw layers map into each. The MEMORY note refers to "Max-style #00_* groups" but the canonical list/regex is in user-side files not in the read knowledge base.

### Layer remap candidates per Max GT
From `knowledge-3dsmax-cad-amends-workflow.md:240-272`, layers commonly remapped/preserved into Max scene:
- Road: `DWH-002-Road Kerbline`, `DWH-002-Road Footpath`, `BDW-A-ROAD CHANNEL`, `DWH-002-Drives`, `-p-kerb`, `-c-kerb`
- Plot/fencing: `DWH-002-Plot Division`, `DWH-002-Screen Wall`, `DWH-002-Close Board fence`, `BDW-A-SITE BOUNDARY`
- HT footprints: `F Roof`, `F Ext Wall`, `F Patio`, `F Canopy`, `F Party Wall`, `F Door Surround`, `F Roof Hatch 1`, `F Roof Hatch 2`, `F Text Sales - DWH`, `F Front Door`
- Landscape (zone polygons): `SOFT_TREES`, `SOFT_SHRUBS`, `SOFT_HEDGES`, `SOFT_FLOWERBEDS`, `SOFT_GRASS_TURF` (per `:194-195` recommended Max-side names)
- Patterns DELETE-or-skip-for-scatter: `4_HEDGE_PATTERN`, `4_PLANTINGAREA_PATTERN`, `4_TITLE BLOCK`, `Ownership`, `Phase X - Transfer Boundary`, `EN-Safetyzone`, `EN-Free_Space`
- Engineering (JPP): `JPP_Steps`, `JPP_Retaining_Geowall`, `JPP_Amend Path`

---

## Q7. Illustrator Handoff Requirements (DXF struktūra, ne Illustrator darbas)

Sources: `knowledge-cad-illustrator-bridge.md`, `knowledge-illustrator-overlay-layers.md`, `knowledge-illustrator-roof-spec.md`, `knowledge-illustrator-number-placement.md`. Only **structural DXF requirements** extracted; Illustrator color/font/branding work explicitly skipped.

### Required layers in output DXF (structural)

#### A. Roof — 4-layer structure (mandatory)
Source: `knowledge-illustrator-roof-spec.md:18-49, 73-84`

| layer | DXF stroke convention | content type | semantic |
|---|---|---|---|
| `ROOFFILLS` | HATCH (solid fill pattern), no stroke | one closed polygon per roof plane | colored fill of each roof plane (color applied later in Illustrator) |
| `ROOFBASELINES` | LWPOLYLINE / LINE, ACI 7 (ByLayer) | outer roof outline (one per house footprint) | "main outline" |
| `ROOFMIDLINES` | LWPOLYLINE / LINE, ACI 7 | ridge + main hip lines (small multiple per house) | "mid weight ridge" |
| `ROOFLINES` | LWPOLYLINE / LINE, ACI 7 | secondary detail / tile courses (many per house) | "fine detail" |

Stacking order in DXF must allow Illustrator to layer FILLS (bottom) → LINES → MIDLINES → BASELINES (top) — `:81`.

Layer-name normalisation regex (handles brand prefixes + duplicates) — `knowledge-illustrator-roof-spec.md:113-128`:

```python
def normalize_roof_layer(name: str) -> str | None:
    n = name.upper().replace("_", " ").replace("-", " ").strip()
    for p in ["BH ", "DWH ", "BH 1 ", "BH 2 ", "DWH 1 ", "DWH 2 "]:
        if n.startswith(p): n = n[len(p):]
    n = re.sub(r"\s+COPY(\s+\d+)?$", "", n)
    n = re.sub(r"\s+\d+$", "", n)
    n = re.sub(r"\s+", " ", n).strip()
    if "BASELINE" in n or "BASE LINE" in n: return "ROOFBASELINES"
    if "MIDLINE" in n or "MID LINE" in n or "MIDROOFLINE" in n or "ROOFMIDLIEN" in n: return "ROOFMIDLINES"
    if "FILL" in n: return "ROOFFILLS"
    if "ROOFLINE" in n or "ROOF LINE" in n: return "ROOFLINES"
    return None
```

Common typos to absorb: `ROOFMIDLIENS`, `MIDROOFLINES`, `ROOFFILLS#`, `ROOFILLS`, `ROOFMIDELINES` (`:60-62`).

#### B. Overlay layers (structural — content carriers, no styling)

From `knowledge-illustrator-overlay-layers.md:14-130`, per category, the DXF must carry layers that match these naming variants (the agent must produce these so Illustrator side can drive them):

1. **HT identification** — `house codes`, `house tops`, `BH ANNOTATIONS MP 2DSP`, `DWH ANNOTATIONS MP 2DSP`, `HT code`, `CODES`, `PLOT-CODES`
2. **Plot numbers** — `plot numbers`, `PLOT NUM`, `DWH PLOT NUMBERS`, `BH PLOTNUMBERS`, `BHN_Plot_Number` (DXF), `BDWS_Plot_HT Code` (DXF) — `knowledge-illustrator-number-placement.md:32-34`
3. **Parking numbers** — `DWH PARKING NUMBERS`, `parking num`, `BHN_Plot_Parking_Number`, `Countryside Layout|CP - PL-Parking numbers`, `Countryside Layout|DWH-002-Parking Numbers`, `Countryside Layout|PPG_Parking space` (`:50-53`)
4. **Street/road names** — `street names DWH`, `street names BH`, `ROADS`, `RAS - Road Names`
5. **KEY / Legend** — `KEY`, `DWH BH KEY`, `BCP`, `key`
6. **Title block / north** — `Title & north sign`, `North Sign`, `North Sign WEB`, `ARTBOARD ANNOTATIONS`, `Artboards`
7. **Minimap** — `minimaps`, `MP`
8. **CAD-imported text** — `cad txt`, `CAD TXT`, `cad ref` (typically hidden in final)
9. **Frame/border** — `frame`, `back for anotation`, `Print`
10. **Sales-area overlays** — `DWH SALES AREA`, `BH SALES AREA`, `A1-SALES`
11. **Brand-split convention** — multi-brand sites get TWO copies (`BH ROOFLINES`, `DWH ROOFLINES`) plus base unified version (`:159-164`)

#### C. Cross-format anchor layers (highest semantic confidence)
From `knowledge-cad-illustrator-bridge.md:27-32`: only 5 layers exist in all 3 universes (Max + DXF + AI): `Layer 1`, `Layer 2`, `Layer 3`, `Layer 4`, `Layer 10`.
Cross-format counts: Max+DXF 71 layers, Max+AI 5 layers, DXF+AI 40 layers.

### TEXT vs MTEXT requirements per layer

The Python implementation in `plot_numbers.py:76-87` and `parking_numbers.py:116-127` writes **TEXT** entities (`msp.add_text(...)`), not MTEXT.

⚠️ Nerasta: explicit user-confirmed rule "use TEXT, never MTEXT" or vice-versa. Current behaviour is TEXT-only by implementation.

For Illustrator-side overlay text (HT codes, plot numbers, street names) the placement spec is anchor + rotation + height (`knowledge-illustrator-number-placement.md:14-44`); type is not constrained at the DXF layer level.

### Ecology icons (block names / positions)
⚠️ Nerasta: dedicated ecology-icon block list in any read file. The "Ecology Key" is mentioned in MEMORY ("cad-site-agent:illustrator-key-creator skill") and in `knowledge-installed-external-skills.md` references, but block-name-level icon vocabulary (e.g. `BLOCK_BAT_BOX`, `BLOCK_HEDGEHOG_HIGHWAY`) is not enumerated in the knowledge base read. The skill `cad-site-agent:illustrator-key-creator` produces it from `key_preparation.json` (skill description list in system reminder), but the JSON schema is not in any of the cited knowledge files.

### Roof color spec (DXF side only)
- ALL 4 roof DXF layers use **ACI color 7** (default/black → ByLayer) (`knowledge-illustrator-roof-spec.md:53-55`)
- Strokes get CMYK(51,51,51,95) **only inside Illustrator** (out of scope per Q7)
- ROOFFILLS in DXF: solid HATCH entities (color applied per material in Illustrator)

---

## 8. Summary — kas paruošta agento spec'ui, kas dar trūksta

### READY for agent spec
- Roof 4-layer structural DXF spec is fully defined (layers, stroke-vs-hatch convention, name-normalisation regex including typo absorption).
- Plot + parking numbering Python implementation exists and is tested (5+ test files); algorithm signatures, `class_filter` defaults (`rear_garden` for plots, `parking` for bays), longest-edge rotation logic for parking bays — all documented with file:line citations.
- Developer → font style mapping wired (BARRATT HOMES → DINPro-Bold; DAVID WILSON HOMES → CenturyGothic-Bold).
- House-type detector regex + false-positive filter (road suffixes, road codes) implemented.
- Plot → house mapper 4-priority confidence ladder (legend color 0.95, nearby text + bedrooms 0.75, nearby text only 0.55, bedrooms-only 0.30, no_match 0.0).
- Block vocabulary inventoried: 1147 distinct blocks across 8 Max GT projects, 58,808 total INSERT instances, semantic-tagged (vegetation 129, fencing 14, refuse 26, drainage 7, outbuilding 5, railing 5, ht_house 15, lighting 1, furniture 1, survey 1, other 943).
- Per-client layer naming patterns characterised across 8 projects (BH: BHN/BDW-A/H7xxx/F-prefix; DWH: DWH-002/BDWS/F-prefix; Redrow: REDROW/PDF_CP-crib_*/RW_GAR_*; common: #00_/JPP_/XREF/SURVEY).
- 3DS Max import pre-flight checklist + LinkComposite cleanup script + spline-swap amends method (validated 2 s on 15,482 objects, 16.9M polys).
- 7 known Max quirks documented with workarounds.
- DXF naming variants including brand prefix (BH /DWH /BH-1 /DWH-1) + parcel split + `_copy`/`_0`/`_1` duplicate patterns.
- 40° main roof pitch + 7.5 m eave + 2.7 m canopy + 22.5°/2.4 m garage standards locked.
- Roof topology detection by hatch perimeter method (`F Roof Hatch 1/2`) + cross-gable T-junction matched-pitches formula.
- HT inventory: BH ~12 sales names with RGB + ~50 sales names without; DWH 7 named + 25+ coded HTs (P/S/T/H/N/C series); Redrow 26 Heritage + 2 Inspired sales names + 4 detected RW0x patterns + 15 garage code variants.
- Block-name regex proposals for DWH coded (`P/S/T/H/N/C\d{2,4}`), DWH named (`B[A-Z]{2,3}_X0(HE|GE|GD|FD|-I)`), garages (BH/DWH/Redrow distinct).

### MISSING / open questions for the user

1. **Per-HT instance counts** are absent — `max_block_vocabulary.json` semantic field bundles all houses into 15 entries (with `Block_H7754_*` style names that don't match the BH/DWH HT name list). Need a mapping `block_name → HT name` to drive footprint matching.
2. **Per-HT footprint corpus** — only 6 blocks have measured footprints (`block_footprints.json`); the 1141 remaining blocks have no width/height data. Need a batch footprint extraction across all 8 GT projects.
3. **Roof colour palette per HT** — only 11 BH HTs have RGB (Towcester only); DWH/Redrow have zero. Need a per-project legend RGB capture pipeline.
4. **The 15 `#00_*` Max semantic group names + their layer-mapping rules** — referenced in MEMORY but no enumerated list in read knowledge.
5. **DXF version + canonical units** for the output DXF — neither stated in knowledge base. Needs explicit user spec.
6. **Ecology icon block vocabulary** — not enumerated; spawned by `cad-site-agent:illustrator-key-creator` from `key_preparation.json` but schema not documented in knowledge.
7. **TEXT vs MTEXT preference** — current code writes TEXT only; needs user confirmation that this is correct for Illustrator import.
8. **Time data for DWG cleanup, Photoshop, final Illustrator template stages** — `⚠️ Laiko duomenų faile nėra` for these stages; only Max-side phase budgets are recorded (45-90 min total Max).
9. **Block_footprints coverage gap** (6/1147 blocks measured) — would unlock polygon→block lookup for from-scratch projects (the "MEMORY: From-Scratch Capability Requirement" rule).
10. **Redrow brand recognition signals** — Redrow uses RGB(153,27,30) line color (`knowledge-redrow-ht-complete-archive.md:14`) and `PDF_CP-crib_*` layer prefixes; needs an explicit "is_redrow_project" detector before the HT pattern lookup runs.
11. **Per-project layer remap rules** — MAXScript `C:/temp/remap_layers.ms` is "working" but its source content is not in the knowledge base read; the Python equivalent `remap_layers_to_max_groups.py` is documented as broken (ezdxf saveas corrupts ACAD_PROXY).
12. **"Do Not Resolve any Xrefs" Max import bug** — open ticket from MEMORY 2026-04-19 session end; persists between imports causing 32K → 1.9K object regression. Workflow needs either xref-bind-before-import (ezdxf path partially works: 2/6 success on Brook View) or per-run import-options reset.
