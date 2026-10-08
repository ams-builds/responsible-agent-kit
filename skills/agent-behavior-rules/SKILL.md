---
name: agent-behavior-rules
description: Help a user write and check the behavior rules of their own AI agent with OASB-2 (Agent Behavioral Governance Specification). Find the agent tier, compare the current instructions with the nine OASB-2 domains, list the missing controls (CRITICAL and HIGH first), and draft a SOUL.md governance file. Use when the user asks to "check my agent's rules", "write a SOUL.md", "what must my agent never do", "which OASB-2 controls am I missing", "governance file for my agent", or asks how to stop prompt injection from changing their agent's behavior.
---

# Agent behavior rules (OASB-2)

You help the user write down the rules of their agent. The rules say what the agent can do and what it must never do. They also say who it obeys first and when it must ask a person.

Source: [OASB-2](https://github.com/opena2a-standards/agent-governance-spec) by [OpenA2A](https://github.com/opena2a-standards), commit `8c279f0`. Read the source files named below. Do not guess control text.

## Rules for you

1. Read and draft only. Do not change the agent, its prompts, or its deployment before the user approves.
2. Never ask for keys, tokens, or passwords.
3. Write the draft to a new file (`SOUL.draft.md`). Do not overwrite the current governance file.
4. Say clearly that a coverage score shows what the file says, not what the agent does.

## Steps

1. **Find the tier.** Ask what the agent can do. Map it to BASIC, TOOL-USING, AGENTIC, or MULTI-AGENT (source: `specification.md` section 3). The tier sets the applicable controls (29, 57, 69, or 72).
2. **Find the current instructions.** Look for a governance file in the order of `specification.md` section 2.2 (`SOUL.md`, `system-prompt.md`, `CLAUDE.md`, and others). Tell the user which file you found.
3. **Compare with the nine domains.** Read each domain file, `domains/11-*.md` to `domains/19-*.md`. List the controls that apply to the tier. Mark each control as present, weak, or missing. Use the severity from `specification.md` section 5.3.
4. **Show the gaps.** Put the CRITICAL controls first (`SOUL-HB-001` safety immutables, `SOUL-IH-003` role-play refusal), then HIGH, then the rest. Use the "Path to Essential" and "Path to Standard" lists in `conformance.md`.
5. **Draft the file.** Start from the template for the tier in `templates/` (`basic.md`, `tool-using.md`, `agentic.md`, `multi-agent.md`). Fill it with facts from the user, not with invented tools. Write `SOUL.draft.md`.
6. **Tell the level.** Say which conformance level the draft can reach (Essential, Standard, Hardened) and what is still missing. Standard is the source's level for production agents that handle user data.
7. **Offer a scan.** The source names the `hackmyagent` tool (`npx hackmyagent scan-soul`). This runs third-party code, so only suggest it. Let the user decide.

## Common failure modes

1. **No "never" rules.** The file says what the agent does, but not what it must never do. Add safety immutables first.
2. **The agent can edit its own rules.** Some agents can write to their own rules file during a chat (for example, Waku's `update_soul` tool writes to its `SOUL.md`). This is my note, not the source. Tell the user to keep the file in version control, review each change, and remove write access for the agent.
3. **Score treated as proof.** The scan looks for words in the file. A high score does not prove that the agent obeys the rules. Suggest tests of real behavior as well.
4. **Wrong tier.** An agent with file access is AGENTIC, not TOOL-USING. A low tier hides controls that apply.
5. **Copied template.** A template with placeholders left in it is not a governance file. Remove every `[placeholder]`.
