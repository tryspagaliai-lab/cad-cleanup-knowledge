# START HERE — CAD Site Plan Cleanup Agent

**Auto-syncs every 2 min from `E:/AgentOS/exports/` (Claude Code workspace).**
**Last update:** 2026-04-25

---

## 🎯 1-minute orientation

**Project:** Build a CAD site plan cleanup agent (DWG/DXF → 3DS Max-ready DXF + Illustrator-ready DXF).

**Source data:** UK housing site plans for Barratt Homes (BH), David Wilson Homes (DWH), Redrow.

**Where:** Local Python pipeline at `E:/pdf errors validation pipeline/scripts/`, MCP server at `E:/mcp-servers/cad-agent-tools/`, reference plot/parking numbering already implemented at `E:/cad-site-agent/src/cad_site_agent/`.

---

## 📊 Current state (2026-04-25)

### ✅ DONE
1. **Vocabulary extraction** — 510/512 RAW DXF parsed across 7 projects → 14,776 blocks, 2,607 layers, **4.24M entities**
2. **Old vocabulary rejected** — Max GT was contaminated with VRayProxy/Box/obj_/Chainlink mesh artifacts
3. **Deterministic classifier prototype** — 100 regex rules, **100% stable layer coverage** (47/47 layers across ≥3 projects), 64% master DXF coverage, 11% entity coverage
4. **Coverage gap analysis** — uncovered 89% entities split as: DELETE 66%, KEEP 9.1%, AMBIGUOUS 24.9%
5. **Brook View topo xref classified** — 1 of 7 xref files. User-confirmed verdicts: drop levels/contours, keep geometry/roads/buildings/vegetation
6. **Pipeline security hardening** — atomic saveas, input==output check, output validation, dead code removal (after v5/v6 corruption disaster on 2026-04-21)

### ⏳ PENDING (priority order)
1. **Brook View main `X.dwg` classification** — houses, plot numbers, parking, fences (NOT YET TOUCHED)
2. **Other 6 Brook View xrefs** — civil/road/highway/tree survey/Promap
3. **Other 6 projects deep-dive** — Quarter Bingham, Wigston, Wixams R7, Towcester, Kings Court, Fairfields
4. **3DS Max input contract** — DXF version, units, Z handling (user input needed)
5. **Plot/parking numbering integration** — already implemented in `cad-site-agent`, needs to plug into new pipeline
6. **Material assignment** — separate agent (not this scope)

---

## 🚀 Next decision points (need your verdict)

### A. Continue Brook View deep-dive interactively?
- Open `E:/cad-site-agent/_tests/brook_view_BOUND_2026-04-19/X.dwg` in AutoCAD
- Toggle each layer category and confirm KEEP/DROP
- Time: 30-45 min interactive
- Output: complete Brook View verdict file

### B. Skip to other projects breadth-first?
- Spot-check Quarter Bingham, Wigston, Wixams R7 master site layouts
- Confirm same patterns hold (BHN_*, DWH_*, plotno, A2xx_)
- Time: 60-90 min

### C. 3DS Max contract (3 questions need answer)?
- DXF version Max 2022 wants? (R2018 / R2010 / R2007)
- Units? (mm / m)
- Z handling? (force 0 / preserve)
- Time: 5 min user answer → I write `max_input_contract.json`

---

## 📁 File guide (what to read in this repo)

**Read first (small, narrative):**
- `START_HERE.md` (this file) — current state + decisions
- `MASTER_STATE.md` — full pipeline architecture + history
- `user_verdicts_brook_view_topo.md` — confirmed user decisions (5 KB)
- `siteplan_3dsp_FINAL_ANSWERS.md` — answers to 3 consultant questions (9 KB)

**Reference only (data, large):**
- `raw_dwg_vocabulary.json` — 8 MB, full vocabulary (don't load whole file)
- `deterministic_classifier_benchmark.json` — 17 KB, classifier rules + benchmark
- `coverage_gap_analysis.md` — DELETE/KEEP/AMBIGUOUS breakdown
- `vocabulary_validation.md` — 47 stable layers list
- `siteplan_3dsp_agent_requirements.md` — 52 KB, Q1-Q7 detailed extraction
- `dwg_cleanup_knowledge_dump.md` — 37 KB, full project history

---

## 🔄 Workflow with Claude Code

| Actor | Action |
|---|---|
| User (you) | Decides direction in chat |
| Claude Code (local) | Executes (Python, file ops, AutoCAD MCP) |
| Auto-sync | Pushes outputs to this repo every 2 min |
| Chat-Claude (you read) | Sees latest state via GitHub Connector |
