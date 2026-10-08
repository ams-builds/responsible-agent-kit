---
name: oaaf-authority
description: Help a user check the delegated authority of their own AI agent with the Open Agent Authority Framework (OAAF). Make a list of the agent's tools and consequential actions, compare the access the agent holds with the authority each task needs, find where an enforcement point must sit, write a draft least-authority grant for one task, and plan the evidence. Use this skill when the user asks to "check the delegated authority of my agent", "limit what my agent can do", "my agent has too much access", "where do I put an OAAF enforcement point", "least privilege for my agent", or asks how to stop a prompt-injected agent from misusing its API keys or tokens. Also use it when an agent delegates work to sub-agents over MCP or A2A.
---

# OAAF authority check

The Open Agent Authority Framework (OAAF) is an open framework by [Eddie Spradley](https://github.com/espradley), maintained by Edwin Digital LLC. Source: https://github.com/espradley/oaaf (commit a77116f, OAAF Core 1.0 contract). All file paths in this skill refer to that repository.

The main idea of OAAF: the model decides what it wants to do, but an authority layer decides what it has permission to do. A credential (API key, token, service account) tells you what a process can access. Delegated authority tells you what the agent has permission to do for this task. An enforcement point checks the delegated authority before each consequential action, and it fails closed.

This skill helps a user who is not a security specialist. Use plain words. Explain each term when you use it for the first time.

## Safety rules

Obey these rules for all the steps:

1. Read and write drafts only. Do not change files, access, keys, or grants before the user approves.
2. Do not ask for private keys, tokens, or passwords. If the user pastes a secret, tell the user to remove it and to replace that secret.
3. Do not issue or sign a grant. The user or the operator of the agent does that.
4. Report the gaps that the evidence shows. Do not say that the agent is safe when the evidence is missing.
5. If a step needs a rule that this skill does not give, read the source file. Do not guess.

## Step 1: Learn about the agent

Ask the user these questions. Ask one question at a time.

1. What does the agent do, and for whom?
2. Which tools, APIs, or other agents can it call?
3. Which credentials does it use, and what can each credential access?
4. Does it give work to sub-agents? Over which protocol (MCP, A2A, or other)?
5. Who can see a record of what it did?

Write the answers in a short list. Use this list for all the other steps.

## Step 2: Find the consequential actions

Make a table of each tool action. Mark an action as consequential if its effect is difficult to undo, for example: merge, deploy, send, pay, delete, or change access. Show the table to the user and ask the user to correct it.

## Step 3: Compare access with need

For each task that the agent does, list the capabilities that the task really needs. Compare this list with what the credentials can access (from step 1). Each difference is a gap: authority that the agent holds but the task does not need. Refer to the "Why this exists" section of `README.md` for the example of a key that can merge when the task cannot.

## Step 4: Find the enforcement point

For each consequential action, find the component that sits immediately before it: MCP middleware, a tool gateway, an API gateway, or the agent runtime. Read `spec/0.1/architecture.md`, section "Enforcement point".

Check one rule: the action must not be possible without a pass through this component. If the agent can call the tool directly, the check is advice, not enforcement. Tell the user about each action that has no real enforcement point.

For MCP tools, show the user `examples/mcp-tool-guard/README.md`. For agent-to-agent work, read `rfcs/0003-a2a-binding.md`.

## Step 5: Draft a least-authority grant

For one task, write a draft grant in plain words with these parts (from `spec/0.1/architecture.md`, section "Authority grant"):

1. The subject: which agent receives the authority
2. The capabilities: only the ones from step 3
3. The resources: which repository, folder, or account
4. The constraints: limits on arguments, amounts, or targets
5. The validity time: a short end time
6. The delegation limit: can the agent delegate it, and how far

If the agent delegates to sub-agents, check that each sub-agent gets the same or a smaller set. Authority can never get larger at a handoff. Label this draft as a plan, not a working grant. The real grant uses the OAAF SDK (`npm install @oaaf/sdk` or `pip install oaaf`) and is for the operator to issue.

## Step 6: Plan the evidence and the failure rules

Make a plan with the user:

1. Record evidence for each allow and each deny: subject, authority, request, decision, and reason.
2. Use the reason codes in `spec/0.1/conformance/reason-codes.json` so that a person can understand each deny.
3. Fail closed: deny when the authority is expired, revoked, unverifiable, or malformed.
4. Decide how to revoke a grant quickly. Read `rfcs/0004-authority-status-revocation.md`.

## Step 7: Report

Give the user a short report:

1. The consequential actions and which ones have a real enforcement point
2. The gaps between access and need
3. The draft grant for one task
4. The evidence plan
5. The next three actions, in order

Tell the user that OAAF does not replace their policy engine. A valid authority can still get DENY from their own policy (`rfcs/0006-pdp-interoperability.md`). Also tell the user that the source states it has not yet had an independent professional security audit.

## Common failure modes

1. **The key is the only control.** An API key with wide access, and no check of what the task needs.
2. **A check that the agent can go around.** A rule in the prompt is not an enforcement point. Code in the agent itself is also not an enforcement point.
3. **Authority gets larger at a handoff.** A sub-agent receives capabilities that the giver did not have.
4. **No end time and no revocation.** A grant that stays valid for ever.
5. **Evidence only for success.** A log that records only allows cannot show that a control worked.
6. **OAAF used as the policy engine.** OAAF verifies authority. Your policy engine still decides policy.
