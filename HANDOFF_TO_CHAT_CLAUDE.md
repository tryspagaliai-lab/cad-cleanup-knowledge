# Handoff į naują chat-Claude session

## Repo URL

🔗 **https://github.com/tryspagaliai-lab/cad-cleanup-knowledge** (private)

## Setup chat-Claude pusėje (vienkartinis)

1. Claude.ai → Settings → **Customize** → **Connectors** → **GitHub Integration** (matai jau Connected)
2. Pirmoje žinutėje paspausk 🔗 (attach) → pasirink **`tryspagaliai-lab/cad-cleanup-knowledge`** repo
3. Atrink TIK **2 failus**:
   - `START_HERE.md`
   - `MASTER_STATE.md`

(Kitus palik nepažymėtus — chat-Claude prašys konkrečiai kai prireiks.)

---

## Pirmasis prompt'as naujoje sesijoje (paste'ink šitą)

```
Turime GitHub repo cad-cleanup-knowledge prijungtą per GitHub Connector.

Perskaityk:
1. START_HERE.md (current state)
2. MASTER_STATE.md (architecture)

Neskaityk archive/ ar data/ kol nepasakysiu.

ROLĖS:
- Aš (user) sprendžiu kryptį, atsakau į klausimus
- Tu (chat-Claude) planuoji ir rašai JSON užduotis Claude Code'ui
- Claude Code (local) vykdo užduotis ir push'ina į repo

TAISYKLĖS:
1. Niekada nerašyk Python kodo pats — tik JSON specs Claude Code'ui
2. Visi JSON specs turi įdėti "scope_enforcement: STRICT"
3. Jei matai, kad scope plečiasi, sustabdyk ir pasakyk man
4. Bet kokius rezultatus iš Claude Code skaitysi per repo, ne per copy-paste

Mano prioritetas šiandien: [ČIA UŽRAŠYK SAVO PRIORITETĄ]

Klausimas tau: pažvelgęs į START_HERE.md, kas pirmiausia reikia spręsti?
```

---

## Auto-sync statusas

- **Scheduled task:** `CAD-Cleanup-AutoSync`
- **Interval:** every 2 min
- **Script:** `E:/AgentOS/cad-cleanup-knowledge/scripts/auto_sync.ps1`
- **Log:** `E:/AgentOS/logs/auto_sync_cad.log`

### Patikrinti task'ą:
```powershell
Get-ScheduledTask -TaskName "CAD-Cleanup-AutoSync" | Format-List
```

### Manual sync (jei reikia force'inti):
```powershell
powershell.exe -ExecutionPolicy Bypass -File E:/AgentOS/cad-cleanup-knowledge/scripts/auto_sync.ps1
```

---

## Repo struktūra

```
cad-cleanup-knowledge/
├── README.md                  ← repo overview
├── START_HERE.md              ← current state + decisions
├── MASTER_STATE.md            ← architecture + classifier rules
├── .gitignore
├── verdicts/
│   └── brook_view_topo.md
├── data/                      ← visi JSON + reference docs
│   ├── raw_dwg_vocabulary.json (8.5 MB)
│   ├── deterministic_classifier_benchmark.json
│   ├── coverage_gap_analysis.md
│   ├── vocabulary_validation.md
│   └── raw_dwg_vocabulary_analysis.md
├── archive/
│   ├── dwg_cleanup_knowledge_dump.md
│   ├── siteplan_3dsp_FINAL_ANSWERS.md
│   └── siteplan_3dsp_agent_requirements.md
└── scripts/
    └── auto_sync.ps1
```

---

## Workflow

| Veiksmas | Kas daro |
|---|---|
| Sprendimas dėl krypties | User → chat-Claude |
| JSON spec'as su STRICT scope | chat-Claude → Claude Code |
| Vykdymas (Python, file, MCP) | Claude Code (local) |
| Output → `E:/AgentOS/exports/` | Claude Code |
| Auto-sync to repo | Scheduled task (2 min) |
| Skaitymas naujiausio state | chat-Claude per GitHub |
