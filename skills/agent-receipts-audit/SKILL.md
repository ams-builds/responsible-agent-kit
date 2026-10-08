---
name: agent-receipts-audit
description: Help a user check the audit trail of their own AI agent with the Agent Receipts protocol. List the actions of the agent, give each action a type and a risk level, find actions with no record, select where the signing key lives, and write a draft receipt plan with a verification and checkpoint plan. Use this skill when the user asks "check the audit trail of my agent", "can I prove what my agent did", "which actions need a signed receipt", "how do I log what my agent does", "make my agent logs tamper-evident", or asks about agent receipts, audit logs, or proof of agent actions for a team or a regulator.
---

# Agent Receipts audit

This skill helps the user plan a tamper-evident audit trail for one AI agent. The source is the Agent Receipts protocol with the Obsigna tools, by [Otto Jongerius](https://github.com/ojongerius) and the [Agent Receipts](https://github.com/agent-receipts) project: https://github.com/agent-receipts/obsigna (commit `77f36a2`, specification document Draft v0.5.0). Tools are Apache 2.0, and the specification is MIT.

The result is a draft plan in a file in the project of the user. It is not an installation.

## Rules

1. Read and draft only. Do not install the Obsigna daemon, hooks, or SDKs. Do not change the settings of any agent (for example `~/.claude/settings.json`). Do not start a signing service. The user does these steps after the user reads the plan.
2. Never ask for, show, or write a private key, a token, or a password. If the user pastes one, tell them to rotate it.
3. Use only evidence from the files of the user and from the source. If you do not know if an action has a record, mark it "unknown". Do not mark it "recorded".
4. Use the source words for the fields of a receipt: action, principal, issuer, outcome, chain, privacy.
5. Never make the risk level of an action lower than the taxonomy default. You can make it higher (specification §6).

## Steps

### Step 1: Make a list of the actions

Ask the user where the agent is, then read its code, its tool list, or its configuration. Make a table of each tool or action that the agent can do. Add one column for the system that the action touches (files, shell, email, payments, other).

### Step 2: Give each action a type and a risk level

For each action, find the nearest action type in the taxonomy (`spec/spec/taxonomy/action-types.json`, and specification §5 in `spec/v0.5.0/spec.md`). Use the default risk level: low, medium, high, or critical (§6). If an action has more effect than usual, make the level higher, for example a delete of a backup. If no type agrees, propose a custom type (§5.8). Do not use `unknown` when a better type exists.

### Step 3: Find actions with no record

For each action, write what record exists today: none, a normal log file, or a signed record. A normal log file is not tamper-evident, because anybody with access can change it. List the high and critical actions with no signed record first.

### Step 4: Select where the signing key lives

Explain the three options from the source trust model (README section "Choose your trust model", and `docs/threat-model.md`):

1. **In the agent process.** Simple. But if the agent is compromised, it can forge receipts.
2. **In a separate daemon.** The daemon holds the key and signs events that the agent sends. The source makes the daemon the trust anchor.
3. **In a hardware security module or a cloud key service.** Stronger again.

For a team agent, recommend option 2 as the start. Write down the choice and the reason. The user makes the decision.

### Step 5: Write a draft receipt plan

For each high and critical action, write what its receipt must record:

- **Action:** the type, the risk level, and the target.
- **Principal:** the person or organization who authorized the action (§3.4). Not the company that built the agent.
- **Issuer:** the agent that does the action (§3.5).
- **Outcome:** success or failure, and if the action can be undone (§4.3). If it can be undone, plan a reversal receipt (§7.4).
- **Chain:** one chain for each agent. A sub-agent starts a new chain with a link to the parent chain (§7.5, §7.6).
- **Privacy:** keep a hash of the parameters, not the parameters (§2, principle 1).

### Step 6: Plan verification and checkpoints

Write how the user will verify the chain: the signature of each receipt, the hash links, and the sequence numbers (§7.3, §7.8). Then explain tail truncation: a chain check cannot find receipts that somebody removed from the end (`docs/threat-model.md`, section "Tail truncation"). Plan anchor checkpoints to a place that the signer cannot change. Write the plan to a file, for example `audit-trail-plan.md`, and show the user the path.

## Common failure modes

1. **The key is inside the agent.** A compromised agent can forge clean receipts. Move the key to a daemon or a key service.
2. **Plain-text parameters.** Private data goes into the record. Keep hashes only.
3. **A chain check with no anchor.** A removed tail stays hidden. Add anchor checkpoints.
4. **Mixed issuers in one chain.** The specification requires one issuer for each chain (§7.5). Give each agent and each sub-agent its own chain.
5. **Lower risk levels.** A lower level breaks filters and alerts that trust the level. Only make levels higher.
6. **Parallel actions in one chain.** In this version, a chain is linear (§3.2, §9.8). Tell the user if the agent runs tools in parallel, because the chain cannot show that directly.

## Limits to tell the user

- The specification is a draft. Fields and rules can change.
- Resolution of the public key from a DID is not fully specified in this version (§9.6).
- With the signing key and no anchor, an attacker can forge a clean chain end (`docs/threat-model.md`).
