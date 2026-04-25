# CAD Cleanup Knowledge Base

Working memory between user, chat-Claude, and Claude Code for the CAD site plan cleanup agent project.

## Read order for chat-Claude

1. `START_HERE.md` — current state + open decisions (max 200 lines)
2. `MASTER_STATE.md` — architecture + classifier rules (single source of truth)
3. `verdicts/` — user-confirmed decisions (read on demand)
4. `data/` — JSON outputs + reference docs (don't load whole files)
5. `archive/` — old reports (don't read unless asked)

## Roles

| Actor | Role |
|---|---|
| User | Decides direction, answers questions |
| chat-Claude | Plans, writes JSON specs for Claude Code |
| Claude Code (local) | Executes Python, file ops, AutoCAD MCP |
| Auto-sync | Pushes outputs from `E:/AgentOS/exports/` → this repo every 2 min |

## Auto-sync

PowerShell scheduled task `CAD-Cleanup-AutoSync` runs every 2 min, copies `E:/AgentOS/exports/*.md` and `*.json` into this repo (root for `.md`, `data/` for `.json`), commits with message `auto-sync: <timestamp>`, and pushes to `origin/main`.

Manual commits (when Claude Code does intentional work) use prefix `task: <task_id>` for traceability.

## Repository structure

```
/
├── README.md                  ← this file
├── START_HERE.md              ← current state + open decisions
├── MASTER_STATE.md            ← architecture + classifier rules
├── .gitignore
├── verdicts/                  ← user-confirmed decisions
│   └── brook_view_topo.md
├── data/                      ← JSON outputs + reference docs
│   ├── raw_dwg_vocabulary.json (8.5 MB)
│   ├── deterministic_classifier_benchmark.json
│   ├── coverage_gap_analysis.md
│   ├── vocabulary_validation.md
│   └── ...
├── archive/                   ← long historical reports
└── scripts/                   ← auto-sync helpers
    └── auto_sync.ps1
```
