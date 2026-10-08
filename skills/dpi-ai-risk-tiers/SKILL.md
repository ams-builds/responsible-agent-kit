---
name: dpi-ai-risk-tiers
description: Help a vibe coder or a non-specialist find the risk tier of their AI app or agent, and list the controls and evidence that the tier must have. The method comes from DPI–AI Governance Artifacts by [Sankarshan Mukhopadhyay](https://github.com/sankarshanmukhopadhyay) (CC BY-SA 4.0). Use this skill when the user asks "how risky is my AI app", "what is the risk tier of my agent", "which controls does my app need", "score the risks of this feature", "what governance does my AI need", or asks about safeguards, appeals, audit, or oversight for an AI system that makes or helps make decisions about people.
---

# DPI–AI Risk Tiers

This skill applies the risk tier method of DPI–AI Governance Artifacts to the app or agent of the user. The method has two parts. First, you score each risk and find the tier. Then, you list the controls and the evidence that the tier must have.

The source repository is <https://github.com/sankarshanmukhopadhyay/dpi-ai-governance-artifacts>. Each step below gives the source file. If a source file and this skill do not agree, the source file is correct.

Do the steps in sequence. Do not go to Step 5 before the user confirms the tier in Step 4.

## Rules for the full procedure

1. Read and draft only. Do not change code, files, or settings of the user.
2. Propose each score with one short reason. The user confirms each score or changes it.
3. Do not tell the user that the app is legal, compliant, certified, or approved. The source tells that its artifacts "do not create legal authority, jurisdictional admissibility, certification, or deployment approval" (`README.md`).
4. Use the words of the user for their app. Use the words in `JARGON.md` for the method.

## Step 1: Get a description of the system

Source: `docs/implementation-recipes.md` (section "Choose by build intent"), `controls/dpi-ai-governance-controls.json` (control `DPI-AI-CTRL-001`).

Ask the user these questions, one at a time:

1. What does the app or the agent decide, or help to decide?
2. Which persons do the decisions affect?
3. Does the agent do actions for a person or an organization? For example, does it send, buy, approve, or delete?
4. Does a model output (a score, a rank, or an LLM answer) have an effect on the decision?
5. Who is the accountable owner of the system?
6. Which uses must the system never have?

Find the build type in the table "Choose by build intent". For an agent, use "Recipe 2". For a model-assisted decision, use "Recipe 4".

## Step 2: Make a list of the risks

Source: `controlled/risk/risk-scoring-matrix.md` (section "DPI–AI risk register").

1. Read the 12 risks in the source register.
2. For each source risk, ask if a similar risk applies to the app.
3. Write each applicable risk in the words of the app.
4. Add risks that are specific to the app.
5. For each risk, write one sentence that tells how the failure occurs.

Example: the source risk "Mandate ambiguity" is "Agent executes action without legally valid authority chain". For a travel agent app, the same risk is "the agent buys a trip that the user did not approve".

## Step 3: Score each risk

Source: `controlled/risk/risk-scoring-matrix.md` (section "DPI–AI risk register").

1. Give each risk a likelihood (L) from 1 to 5.
2. Give each risk an impact (I) from 1 to 5.
3. Calculate the priority: Priority = L × I.
4. Show the scores in a table with the columns: risk, failure mode, L, I, priority.
5. Ask the user to confirm or change each score.

## Step 4: Find the tier

Source: `controlled/risk/risk-scoring-matrix.md` (section "Step 1: Risk priority thresholds").

1. Find the tier of each risk:
   - Priority 0 to 11: Tier 0 (non-consequential, log-only baseline).
   - Priority 12 to 15: Tier 1 (advisory with human oversight).
   - Priority 16 to 19: Tier 2 (conditional automation).
   - Priority 20 or more: Tier 3 (high-impact determination).
2. If the priority is 12, use Tier 1 by default.
3. If the priority is 12 and an input is disputed, unstable, or incomplete, use Tier 2.
4. Keep Tier 2 until the user resolves the input.
5. Propose the highest tier of all the risks as the tier of the system.
6. Tell the user that this rule comes from this explainer.
7. Tell the user that the source does not give a rule for a full system.
8. Ask the user to confirm the tier.

## Step 5: List the controls for the tier

Source: `controlled/risk/risk-scoring-matrix.md` (section "Step 2: Tier-driven governance requirements"), `controlled/assurance/tier-profiles/mdk-tier-profile.md`.

1. List the mandatory controls and the governance escalation for the tier:

   | Tier | Risk level | Mandatory controls | Governance escalation |
   |------|------------|--------------------|-----------------------|
   | Tier 0 | Minimal | Logging, traceability | Internal review only |
   | Tier 1 | Moderate | Explanation artifacts, override logging | Agency-level oversight |
   | Tier 2 | High | Binding safeguards, delegation tokens, audit bundle | Cross-agency reporting |
   | Tier 3 | Critical | Human-in-loop confirmation, formal appeals, independent audit | Ecosystem governor review |

2. Add the "Required" items for the tier from `mdk-tier-profile.md`. For example, Tier 1 requires decision receipts for denials, revocations, and material eligibility determinations.
3. If the system is an agent, add the "Must-fail tests" from Recipe 2 in `docs/implementation-recipes.md`.
4. If a model output has an effect on the decision, add the "Must-fail tests" from Recipe 4.
5. For each control, write one sentence that tells how the app can do it.
6. Do not add a control that the system does not need. The source tells: "Do not add components mechanically."

For a team outside the public sector, change the escalation to the nearest role in the team. For example, "agency-level oversight" can become a review by the product owner. Tell the user that this change is not in the source.

## Step 6: List the evidence and the review triggers

Source: `controls/dpi-ai-governance-controls.json` (field `evidence_examples`), `profiles/dpi-ai-system-profile.yaml` (field `review_triggers`), `docs/implementation-recipes.md` (section "Pre-production checklist").

1. For each control, list the evidence that shows that the control works.
2. List the events that start a new review. The source gives: major model update, policy scope change, appeal reversal spike, and drift threshold exceeded.
3. Do the "Pre-production checklist" with the user. Mark each item as done, not done, or not applicable.

## Step 7: Give the result

Give the user one document with these parts:

1. A description of the system in two sentences.
2. The risk table from Step 3.
3. The tier, with the risk that sets it.
4. The controls from Step 5, with one sentence for each.
5. The evidence and the review triggers from Step 6.
6. A list of open items.
7. This statement: "This is a structure for your work. It is not legal advice, and it does not certify or approve the system."

## Frequent errors

1. **All the controls for all the tiers.** Use only the capabilities that the system needs (`docs/implementation-recipes.md`).
2. **A delegation record and no check at runtime.** The source tells: "A static delegation record is not sufficient." Make sure that the system checks the permission before each action (Recipe 2).
3. **The model output becomes the rule.** "The model may provide evidence or a recommendation. It does not silently become the authority or the rule" (Recipe 4).
4. **Documents that no person uses.** The source FAQ calls this "paperwork theater". Connect the evidence to real events: launches, incidents, quarterly reviews, and procurement gates (`docs/faq.md`).
5. **A valid file is not a lawful decision.** "A schema-valid object is not proof that the underlying decision is lawful, legitimate or approved" (`docs/start-here.md`).

## Limits

1. This skill uses only the risk tier method. The source has more packs, for example procurement, redress, and meta-governance (`packs/README.md`).
2. The source is for AI in public digital systems. Tell the user when a source term, for example "agency", does not apply to their app.
3. The source is version 1.2.0. If the source changes, the source is correct.
