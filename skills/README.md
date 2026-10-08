# Skills

This folder has a copy of the agent skill from each kit. With these copies, one command installs all nine skills:

```
npx skills add ams-builds/responsible-agent-kit
```

The kit repository is the source of truth for each skill. Each folder here has the `SKILL.md` file, the license, and the notice of its kit. The license of each folder is the license of its kit. The MIT License of this repository does not apply to these folders.

| Folder | Kit | License |
|---|---|---|
| `agent-name-assurance` | [agent-name-assurance-explained](https://github.com/ams-builds/agent-name-assurance-explained) | Apache 2.0 |
| `rahp-harm-check` | [rahp-toolkit-explained](https://github.com/ams-builds/rahp-toolkit-explained) | CC BY 4.0 |
| `dpi-ai-risk-tiers` | [dpi-ai-governance-explained](https://github.com/ams-builds/dpi-ai-governance-explained) | CC BY-SA 4.0 |
| `oaaf-authority` | [oaaf-explained](https://github.com/ams-builds/oaaf-explained) | Apache 2.0 |
| `agent-receipts-audit` | [agent-receipts-explained](https://github.com/ams-builds/agent-receipts-explained) | Apache 2.0 (spec parts MIT) |
| `agent-behavior-rules` | [agent-governance-spec-explained](https://github.com/ams-builds/agent-governance-spec-explained) | Apache 2.0 |
| `sovereignty-check` | [aegis-sovereign-ai-explained](https://github.com/ams-builds/aegis-sovereign-ai-explained) | Apache 2.0 |
| `ai-incident-response` | [ai-incident-response-explained](https://github.com/ams-builds/ai-incident-response-explained) | Apache 2.0 (with the OASIS notice) |
| `green-agent-footprint` | [green-agents-explained](https://github.com/ams-builds/green-agents-explained) | MIT (pattern ideas CC BY 4.0) |

To update the copies, check out the kit repositories next to this repository, then run `scripts/sync-skills.sh`.
