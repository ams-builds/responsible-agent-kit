---
name: agent-name-assurance
description: Help a user check their own AI agent against the Agent Name Assurance Baseline (ANAB), select a tier, a profile, and an assurance level, find the controls that apply, find evidence gaps, and write a draft conformance declaration and Agent Page text. Use this skill when the user asks to "check my agent against ANAB", "check my agent name", "which ANAB tier can my agent get", "write a conformance declaration", "prove that my agent is really mine", or asks how to stop other people from impersonating their agent. Also use it when the user publishes an agent with a public name, an Agent Page, or an A2A Agent Card and asks how to make people trust it.
---

# Agent Name Assurance

The Agent Name Assurance Baseline (ANAB) is an open draft standard by [Sankarshan Mukhopadhyay](https://github.com/sankarshanmukhopadhyay). Source: https://github.com/sankarshanmukhopadhyay/agent-name-assurance-baseline (version 0.10.0). All file paths in this skill refer to that repository.

The main idea of ANAB is that an agent name is only a hint. Trust comes from the proof that connects the name to a cryptographic key, and from the evidence for each rule. Each claim has three parts: a tier (AN-0 to AN-3), a profile (Core, Deploy, Transact, or Enterprise), and an assurance level (AL1 to AL4).

This skill helps a user who is not a security specialist. Use plain words. Explain each term when you use it for the first time.

## Safety rules

Obey these rules for all the steps:

1. Read and write drafts only. Do not change, publish, or delete files before the user approves.
2. Do not ask for private keys, passwords, or tokens. If the user pastes a secret, tell the user to remove it and to replace that secret.
3. Do not sign a declaration. The user or the operator of the agent signs it.
4. Report the tier that the evidence supports, not the tier that the user wants.
5. If a step needs a rule that this skill does not give, read the source file. Do not guess.

## Step 1: Learn about the agent

Ask the user these questions. Ask one question at a time.

1. What is the name of the agent, and where do people see that name?
2. Who operates the agent: a person, a company, or a public body?
3. Does the agent have an Agent Page, a DID, or an A2A Agent Card?
4. Can the agent do high-risk actions, for example payments, contracts, or actions for other people?
5. Does AI make or change decisions about people, trust scores, or credentials?
6. Who relies on the agent: the public, partner companies, or only your own team?

Write the answers in a short list. Use this list for all the other steps.

## Step 2: Select the profile

Read `conformance/applicability-matrix.md`, section 1. Select the profile from the answers in step 1:

| Profile | Use it when the agent | Minimum tier |
|---|---|---|
| Core | does discovery and basic interaction with low risk | AN-1 |
| Deploy | has a public deployment and works with other systems | AN-2 |
| Transact | does high-risk actions, for example delegation, payments, or actions with authority | AN-2 |
| Enterprise | works in a regulated or critical environment | AN-3 |

A profile is a minimum. The user can select a higher profile.

## Step 3: Find the tier that the evidence supports

Read `spec/agent-name-assurance-baseline.md`, section 2. Ask the user which proof exists now:

| Tier | Proof | Revocation |
|---|---|---|
| AN-0 Self-Asserted | the DID includes the agent name | none |
| AN-1 Domain-Control Verified | cryptographic proof of domain control, bound to the DID | check again every 90 days or less |
| AN-2 Trust Framework Verified | a Verifiable Credential from a recognized issuer | continuous checks |
| AN-3 High Assurance Verified | legal entity validation and operational security controls | real-time checks and a transparency log |

Compare the tier with the minimum tier of the profile from step 2. If the tier is too low, tell the user. Give the next proof that the user must get.

## Step 4: Select the assurance level

Read `docs/assurance-levels.md`. The source repository uses this rule of thumb:

1. AN-0 or Core: usually AL1 or AL2.
2. AN-1 or Deploy: usually AL2, and AL3 for higher exposure.
3. AN-2 or Transact: usually AL3 at minimum.
4. AN-3 or Enterprise: usually AL3 or AL4.

AL2 and higher need a published evidence bundle (spec section 1.1). A high tier with a low assurance level is a risk signal. Tell the user about this risk.

## Step 5: Make the list of controls

Read the table in `conformance/applicability-matrix.md`, section 2. Find the column for the profile. Make a table with these columns: control ID, title, level (M, S, or C), and a plain description.

For each conditional control (C), decide if the condition is true. If the condition is not true, mark the control `notApplicable` and write one sentence that gives the reason. Example: "This agent does not use AI to make decisions."

Use the requirement text in `spec/agent-name-assurance-baseline.md`, section 9, for the plain description.

## Step 6: Find the gaps

For each control in the list, ask the user for the evidence. Write one of these results:

1. **Evidence exists**: write the location of the evidence.
2. **Partial**: write what is missing.
3. **Gap**: write the first action that closes the gap.

Use `conformance/checklist.md` to make sure that you did not forget a control. Use `threat-model/threat-matrix.md` to tell the user why each gap is important. Give the attack that the control stops.

## Step 7: Write the draft declaration

Write a draft conformance declaration in the user's project folder. Use these source files:

1. `conformance/conformance-declaration-template.md` for the human-readable version.
2. `conformance/conformance-declaration.schema.json` for the JSON version. The required fields are `spec_version`, `assurance_level`, `implementation`, `verification_tier`, `conformance_profile`, `controls`, and `declaration`.
3. `conformance/sample-conformance-declaration.json` as an example.

Mark the file as a draft. Do not mark a control as implemented if step 6 found a gap. Tell the user to sign the final declaration.

## Step 8: Plan the evidence bundle

Do this step only for AL2 and higher. Read `evidence-bundles/README.md`. Write a draft `bundle.json` and a list of the artifacts:

1. `decision-log.md`
2. `risk-assessment.md`
3. `controls-mapping.md`
4. test results, settings, and runbooks

Use the examples in `evidence-bundles/examples/` to show the difference between "good enough" and "best practice".

## Step 9: Write the Agent Page text

Read `docs/implementer-guidance.md`. Write a draft section for the Agent Page with these items:

1. The ANAB version
2. The tier, the profile, and the assurance level
3. The link to the conformance declaration
4. The link to the evidence bundle

Show the real tier, for example "AN-1 Domain-Control Verified". Do not write a generic "Verified" badge (controls `ANAGB-UI-01` and `ANAGB-UI-02`).

## Step 10: Give the report

Give the user a short report:

1. The profile, the tier, and the assurance level that the evidence supports now
2. The number of controls with evidence, with partial evidence, and with gaps
3. The three most important gaps, and the first action for each gap
4. The files that you wrote

Tell the user that ANAB is a draft standard. Tell the user to read the source specification before a public claim.

## Frequent mistakes

1. **A generic "Verified" badge.** The badge hides the tier. A visitor cannot see how strong the proof is. Show the real tier.
2. **TLS treated as identity.** A website with `https` is not proof of the agent identity. TLS protects the connection only.
3. **A credential without revocation.** If nobody can cancel a credential, the credential does not give trust.
4. **The name implies authority.** A verified name does not give the agent permission to act. Control `ANAGB-AI-06` prohibits this.
5. **Long-lived shared keys for delegation.** You cannot revoke them easily, and you cannot audit them. Use scoped and time-limited delegation (control `ANAGB-AI-05`).
6. **A human check that is only advice.** If the agent can continue without approval, it gives no protection.
7. **Silent trust upgrades.** If the proof is missing, old, or not clear, the client must fail safe (control `ANAGB-A2A-10`).
