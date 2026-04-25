# CAD Cleanup Knowledge Base

Auto-synced from local AgentOS exports (`E:/AgentOS/exports/`).

This repo is a knowledge base for the DWG/DXF site plan cleanup agent — vocabulary
extraction, layer classifier rules, and per-project user verdicts.

## Files

| File | Purpose |
|---|---|
| `raw_dwg_vocabulary.json` | Full vocabulary from 510 DXF (7 projects) — 14,776 blocks, 2,607 layers, 4.2M entities |
| `raw_dwg_vocabulary_analysis.md` | Human-readable analysis of vocabulary |
| `raw_dwg_master_only.json` | Master site layouts only (34 DXF, filtered) |
| `vocabulary_validation.md` | Stable layer coverage audit (47 stable layers, 11% entity coverage) |
| `coverage_gap_analysis.md` | DELETE/KEEP/AMBIGUOUS breakdown of uncovered 89% entities |
| `deterministic_classifier_benchmark.json` | 100-rule classifier + benchmark |
| `client_layer_patterns.json` | Per-client layer prefix patterns |
| `siteplan_3dsp_FINAL_ANSWERS.md` | Answers to 3 consultant questions |
| `siteplan_3dsp_agent_requirements.md` | Full agent spec extraction |
| `dwg_cleanup_knowledge_dump.md` | Cross-project cleanup history |
| `user_verdicts_brook_view_topo.md` | User-confirmed layer verdicts (Brook View topo) |

## Status (2026-04-25)

✅ Done:
- Vocabulary extraction from 7 RAW projects
- 100-rule deterministic classifier (100% stable layer coverage)
- Brook View topo xref classification (43K entities DROP, 37K KEEP)

⏳ Pending:
- Brook View main site `X.dwg` classification (houses, plots, parking, fences)
- Other 6 Brook View xrefs (civil, road layout, highway, tree survey, Promap)
- Other 6 projects deep-dive (Quarter Bingham, Wigston, Wixams R7, etc.)
- 3DS Max input contract (DXF version, units, Z handling)

## Usage

Connect this repo to Claude.ai via GitHub connector for chat sessions to read
the latest knowledge state.
