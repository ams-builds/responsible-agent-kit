# agent-governance-kit

## What is it?

This repository is the front door to a set of plain-language kits for the governance of AI agents at work. Each kit explains one governance question in simple words. Each kit also gives an agent skill that your AI agent can use with you. This repository links the eight kits together, and it gives you a place to start.

![A map of eight governance questions for an AI agent at work: identity, harm, risk tier, delegated authority, audit trail, behavioral rules, sovereignty, and incident response. Each question has a kit, and one install gives you all eight.](assets/governance-map.svg)

**One step to install, and you get all of this:**

```
npx skills add ams-builds/agent-governance-kit
```

This command installs all eight agent skills for Claude Code, Codex, GitHub Copilot, and other agents.

*Do you want the technical words in plain English? Refer to the [Jargon Buster](JARGON.md).*

## What problem does it solve?

When you put an AI agent to work, it can act for you, use your data, and affect other people. Most guidance on agent governance is long and written for specialists. This kit tells you which questions to answer first, and it points you to a short guide for each question.

## Who is it for?

This kit is for small teams, teams that grow quickly, and solo builders who put AI agents into real work. You do not need to be a specialist in risk, cybersecurity, governance, or safety. A checklist for personal agents is planned if people ask for it.

## Start here

Answer the eight questions in [START-HERE.md](START-HERE.md). Each answer points you to the correct kit. Then use the one-page [CHECKLIST.md](CHECKLIST.md).

## What is in the kit?

| Question | Kit | Agent skill | Status |
|---|---|---|---|
| Identity: is the agent really yours? | [agent-name-assurance-explained](https://github.com/ams-builds/agent-name-assurance-explained) | `agent-name-assurance` | Live |
| Harm: who can the agent hurt? | [rahp-toolkit-explained](https://github.com/ams-builds/rahp-toolkit-explained) | `rahp-harm-check` | Live |
| Risk tier: how much control does it need? | [dpi-ai-governance-explained](https://github.com/ams-builds/dpi-ai-governance-explained) | `dpi-ai-risk-tiers` | Live |
| Delegated authority: who gave it permission? | [oaaf-explained](https://github.com/ams-builds/oaaf-explained) | `oaaf-authority` | Live |
| Audit trail: can you prove what it did? | [agent-receipts-explained](https://github.com/ams-builds/agent-receipts-explained) | `agent-receipts-audit` | Live |
| Behavioral rules: what must it never do? | [agent-governance-spec-explained](https://github.com/ams-builds/agent-governance-spec-explained) | `agent-behavior-rules` | Live |
| Sovereignty: where does the data go? | [aegis-sovereign-ai-explained](https://github.com/ams-builds/aegis-sovereign-ai-explained) | `sovereignty-check` | Live |
| Incident response: what if it goes wrong? | [ai-incident-response-explained](https://github.com/ams-builds/ai-incident-response-explained) | `ai-incident-response` | Live |

## How to install

The skills use the open [Agent Skills](https://agentskills.io) format, so they work with many AI agents. A copy of each skill is in the [skills](skills/README.md) folder of this repository.

### One command for all agents

If you have Node.js, run this command in a terminal. The command installs all eight skills for Claude Code, Codex, GitHub Copilot, and other agents.

```
npx skills add ams-builds/agent-governance-kit
```

To install only one skill, add `--skill <name>`, for example `--skill rahp-harm-check`. To get the latest versions later, run `npx skills update`. The command uses [skills](https://github.com/vercel-labs/skills) by [Vercel](https://github.com/vercel-labs).

### Claude

1. Claude.ai or the Claude desktop app: put one folder from [skills](skills/README.md) into a zip file. Upload the zip file in Settings > Capabilities > Skills.
2. Claude Code: copy the folders from [skills](skills/README.md) into `~/.claude/skills/`.

### Codex

1. Copy the folders from [skills](skills/README.md) into `~/.agents/skills/` (all projects) or `.agents/skills/` (one project).
2. If a skill does not appear, start Codex again.

### GitHub Copilot

1. Copy the folders from [skills](skills/README.md) into `~/.copilot/skills/` (all projects) or `.github/skills/` (one repository).
2. Use Copilot in agent mode.

These three agents are the most used AI coding agents in the JetBrains 2026 survey. Other agents that support Agent Skills work the same way.

## How to use it

1. Answer the questions in [START-HERE.md](START-HERE.md).
2. Open the kits that your answers point to.
3. Tell your AI agent to run the skill of each kit on your agent. For example: "Do a harm check on my agent."
4. Use [CHECKLIST.md](CHECKLIST.md) to record what you did and what is still open.

## Bigger organizations

This kit is for small teams. When you outgrow this kit, refer to the [Agent Governance Toolkit](https://github.com/microsoft/agent-governance-toolkit) by [Microsoft](https://github.com/microsoft). It is an open-source toolkit that applies policy to each action of an agent while the agent runs.

## Credit and license

The kits are based on open work by these persons and groups:

1. Identity, harm, and risk tier: [Sankarshan Mukhopadhyay](https://github.com/sankarshanmukhopadhyay). The harm kit also uses the work of the Risk Assessment and Harms Prevention Task Force in [Trust Over IP](https://github.com/trustoverip/dtgwg-rahp-tf).
2. Delegated authority: [Eddie Spradley](https://github.com/espradley) (Edwin Digital LLC).
3. Audit trail: [Otto Jongerius](https://github.com/ojongerius) (Agent Receipts).
4. Behavioral rules: [OpenA2A](https://github.com/opena2a-standards).
5. Sovereignty: [InfiniEdge AI at LF Edge](https://github.com/lfedgeai).
6. Incident response: the [Coalition for Secure AI (CoSAI)](https://github.com/cosai-oasis), an OASIS Open project.

This repository is an independent project. It is not an official part of these source projects.

The [MIT License](LICENSE) applies to the files of this repository, but not to the [skills](skills/README.md) folder. Each folder in [skills](skills/README.md) keeps the license of its kit, and has a copy of that license and notice. Each kit repository also keeps its own license.

**Language.** I wrote the text in Simplified Technical English (ASD-STE100). The idea to ask an AI model to write in ASD-STE100 comes from [Andrej Karpathy](https://github.com/karpathy) ([his post on X](https://x.com/karpathy/status/2105819303471976479)). I used the [simplified-technical-english](https://github.com/0xpili/simplified-technical-english) agent skill by [pili](https://github.com/0xpili) to write and check the text. ASD-STE100 is a specification of ASD (AeroSpace and Defence Industries Association of Europe). This repository is not related to ASD.

---

*New words? The [Jargon Buster](JARGON.md) gives plain-English explanations of governance, risk tier, delegated authority, audit trail, sovereignty, and more.*
