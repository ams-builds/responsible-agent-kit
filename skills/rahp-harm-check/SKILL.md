---
name: rahp-harm-check
description: Guide a user through a RAHP (Risk Assessment and Harms Prevention) harm check of their own AI app, agent, feature, or change. Use this skill when the user asks "can this harm real people", "do a harm check", "is my app safe for users", "who can my agent hurt", "what evidence do I have that this is safe", asks for a risk or harms review of something they built with AI tools, or asks where the correction for a problem belongs. The check is read-only and draft-first. Evidence must come from the user's files, and missing evidence never becomes PASS.
---

# RAHP Harm Check

RAHP is a method that tells you if a system deserves trust. The source is the RAHP Toolkit (https://github.com/sankarshanmukhopadhyay/rahp-toolkit, CC-BY 4.0) by [Sankarshan Mukhopadhyay](https://github.com/sankarshanmukhopadhyay). This skill applies a small part of that method to one app, agent, feature, or change that the user made.

The RAHP chain of reasoning is:

`persona/scenario → harm/risk → proposition → control/guardrail → evidence → inference → actionable recommendation`

Source: `docs/how-rahp-works.md`.

This skill uses plain words for the user. Persona is "who it affects". Proposition is "claim". Inference is "result". Recommendation is "correction".

## Rules for this skill

Obey these rules at all times.

Source: `docs/ai-assisted-process.md`, section "What the assistant must not do".

1. Read and draft only. Do not change, send, or delete user data. Do not open issues or pull requests.
2. Do not make up evidence. Evidence must come from a file, a page, or a record that the user can open. Your general knowledge is not evidence.
3. Missing evidence never becomes PASS. If there is no evidence, the result is NOT SURE (RAHP: `INDETERMINATE`).
4. Do not change a hypothesis into a finding only because it sounds correct.
5. Do not say that a valid credential or a valid signature gives permission. Authority is a different question.
6. Do not state a legal or regulatory meaning that the sources do not show.
7. The user makes the decisions. You prepare findings. The user decides which findings are correct and where each correction goes.

## Step 1: Set the target and the question

Ask the user for one item to examine. Examples are the full app, one feature, one agent, or one change.

- Write the target in one sentence.
- Write the question in one sentence. Example: "Can the booking agent buy a ticket without approval?"
- Record the version of the target, for example a commit, a date, or a file name.

Keep the target small. RAHP selects the smallest scope that fully includes the claims that the change has an effect on. More scope does not give more assurance.

Source: `README.md`, section "How RAHP works". Also: `docs/ai-assisted-process.md`, "Step 1".

## Step 2: Identify the personas

Find each person, organization, or system that the target can have an effect on. Use the six RAHP role personas as a start.

Source: `docs/personas.md`.

| ID | Role | Plain meaning |
|---|---|---|
| P1 | Principal / Rights-Bearing Party | The person whose rights, data, money, or consent the app touches |
| P2 | Producer / Originating Actor | The person or system that makes the content or the request |
| P3 | Relying Party / Verifier | The person or system that makes a decision from the evidence |
| P4 | Intermediary / Platform Operator | A platform, host, or service between the parties |
| P5 | Delegated Service / Agent Operator | The operator of an agent that acts for another person |
| P6 | Registry / Discovery / Trust-Service Operator | The operator of a list, directory, or status service |

If the target has an AI agent, also record the type of agent: autonomous agent, supervised agent, or automated pipeline.

Source: `method/non-human-actors.yaml`.

Ask the user: "Who uses this, who is the subject of it, and who cannot use it?"

## Step 3: Find the possible harms

For each persona, find the harms that the target can cause. Use the 24 RAHP harm patterns as a checklist.

Source: `method/catalogue/harm-patterns.yaml`.

1. **Autonomy:** manipulation, coercion, loss of meaningful choice, delegation beyond informed intent, inability to withdraw or revoke.
2. **Access and inclusion:** wrongful exclusion, discriminatory burden, accessibility failure, infrastructure dependency exclusion.
3. **Privacy:** unnecessary disclosure, linkability and correlation, inference beyond disclosed facts, persistent surveillance, secondary use and context collapse.
4. **Economic:** loss of economic opportunity, fraudulent or misallocated liability.
5. **Governance and due process:** arbitrary decision, unavailable appeal or remedy, unaccountable or captured authority.
6. **Security-mediated harm:** impersonation and false attribution, unauthorized consequential action, denial or disruption of participation.
7. **Information integrity:** false provenance or trust inference.
8. **Safety:** physical or safeguarding exposure.

For each harm, write one sentence: "[Persona] can [harm] when [scenario]."

Also examine unusual conditions. Examples are misuse, a failure, a policy change, and a user with a disability.

Source: `docs/pressure-testing-a-spec.md`, section "Scenario-driven review pass". Also: `method/scenario-patterns.yaml`.

## Step 4: Write the claims

For each harm, write the claim that must be correct for the harm to be prevented. Example: "The agent cannot buy a ticket unless the user approved that purchase."

Each claim must be specific. A test or a document must be able to show if the claim is correct.

## Step 5: Find the controls and guardrails

For each claim, find what prevents the harm.

Source: `method/catalogue/control-patterns.yaml`, `method/catalogue/guardrail-patterns.yaml`, and `method/glossary/terms/`.

- A **control** decreases, finds, contains, or repairs a risk. Example: a check of the status immediately before a payment.
- A **guardrail** blocks an unacceptable condition. Example: stop a consequential action when the app cannot find current authority. RAHP calls this "fail-closed".

If you cannot find a control, record that. Do not invent one.

## Step 6: Find the evidence

For each control, find the evidence in the user's files.

Source: `docs/evidence-classification.md`.

- Give the file path and the section or the line for each item of evidence.
- Record the type of evidence: specification or document, code, test, runtime record, or governance record. One type cannot replace a different type. Example: a sentence in a document does not show that the code obeys it.
- A build without errors is not evidence that the app is safe.

Source: `docs/interpreting-results.md`, section "Workflow state is not assurance state".

## Step 7: Give each claim a result

Use one result for each claim.

Source: `docs/interpreting-results.md`.

| Result | RAHP term | Use when |
|---|---|---|
| PASS | `PASS` | The evidence supports the claim. |
| FAIL | `FAIL` | The evidence shows a problem. |
| NOT SURE | `INDETERMINATE` | The evidence is missing or does not give a safe answer. |
| NOT APPLICABLE | `NOT_APPLICABLE` | The claim is outside the target. |

Zero findings is not the same as "safe". A report with zero FAIL results and seven NOT SURE results has seven open questions. Tell the user this clearly.

## Step 8: Find the place for each correction

For each FAIL or NOT SURE result, find one primary control plane. Select the smallest control plane that has the authority to make the change and a path to evidence.

Source: `docs/governance-boundaries.md`. Also: `docs/how-rahp-works.md`, section "Citable terminal assurance records".

1. Specification or documentation
2. Code
3. Test or evidence gap
4. Operator or runtime control
5. Governance and redress
6. User experience

Not all problems are code changes. A missing appeal process is a governance problem.

## Step 9: Write the record

Give the user one record for each finding. Use this shape.

Source: `examples/pressure-test-template.yaml` and `docs/pressure-testing-a-spec.md`, section "Record the finding".

```yaml
- id: F-001
  title: One short sentence
  personas: [P1]
  harm: Who gets the harm, and how
  claim: The claim that must be correct
  controls: What prevents the harm, or "none found"
  evidence:
    - source: path/to/file#section
      observation: What the file shows or does not show
  result: PASS | FAIL | NOT SURE | NOT APPLICABLE
  control_plane: specification | code | test | runtime | governance | user-experience
  recommendation: The correction, at the selected control plane
  retest_when: The change that makes a new check necessary
```

Then ask the user to make a decision about each finding. Do not mark a finding as closed. The user does that.

## Step 10: Check again after a change

After the user changes the target, do not repeat the full check. Find the claims that the change has an effect on. Keep the evidence that is still valid. Do the check again only for the claims that changed.

Source: `docs/getting-started.md`, section "After a material change". Also: `docs/continuous-assurance.md`.

## Common failure modes

1. **PASS with no evidence.** The claim looks correct, so the result becomes PASS. Correct result: NOT SURE.
2. **AI opinion as evidence.** The evidence is a sentence that you wrote, not a file. Correct action: find a source, or record NOT SURE.
3. **Valid credential as permission.** The app checks who the user is, but not what the user is permitted to do.

Source: `examples/a2a/pressure-test.yaml`, finding "A signed Agent Card can still be over-read as proof of authority or trust".
4. **Zero findings as "safe".** The report has no FAIL, but it has NOT SURE results. Correct action: show the NOT SURE count.
5. **Every correction in the code.** Some corrections belong in governance, in the user experience, or in an operator control.
6. **A part as the whole.** A PASS for one part does not give a PASS for the full system.

Source: `docs/how-rahp-works.md`, section "Evidence classes stay distinct".

## Where to learn more

The full method, tools, schemas, and worked examples are in the source repository: https://github.com/sankarshanmukhopadhyay/rahp-toolkit. Start with `docs/getting-started.md` and `examples/hello-rahp/README.md`.
