# Checklist

Use this page to record what you did for your agent. Each item links to the kit that explains it.

## Identity

- [ ] Show the real level of proof for the name of your agent. Do not show one general "verified" badge. ([identity kit](https://github.com/ams-builds/agent-name-assurance-explained#how-does-it-work))
- [ ] Keep proof that you control the name, for example your web domain, and check the proof again at regular intervals. ([identity kit](https://github.com/ams-builds/agent-name-assurance-explained#how-does-it-work))

## Harm

- [ ] List all the persons that your agent can affect, not only its users. For each possible harm, name the control that stops it. ([harm kit](https://github.com/ams-builds/rahp-toolkit-explained#what-does-it-do))
- [ ] Keep evidence in your files for each control. If you have no evidence, record "not sure", never "pass". ([harm kit](https://github.com/ams-builds/rahp-toolkit-explained#safe-by-default))
- [ ] Do the check again after each change to the agent. ([harm kit](https://github.com/ams-builds/rahp-toolkit-explained#how-does-it-work))

## Risk tier

- [ ] Give each risk a likelihood score and an impact score from 1 to 5, and multiply them to find the tier. If an input is not sure, use the higher tier. ([risk tier kit](https://github.com/ams-builds/dpi-ai-governance-explained#safe-by-default))
- [ ] For a high tier, make sure that a person confirms decisions and that affected people can appeal. ([risk tier kit](https://github.com/ams-builds/dpi-ai-governance-explained#how-does-it-work))

## Delegated authority

- [ ] Find the actions of your agent that are difficult to undo, and put a check in front of each one. ([delegated authority kit](https://github.com/ams-builds/oaaf-explained#what-does-it-do))
- [ ] For each task, give the agent only the permissions that the task needs. A sub-agent must never get more than the agent that started it. ([delegated authority kit](https://github.com/ams-builds/oaaf-explained#what-does-it-do))

## Audit trail

- [ ] Keep a signed record of each high-risk action. Keep the signing key outside the agent. ([audit trail kit](https://github.com/ams-builds/agent-receipts-explained#what-does-it-do))
- [ ] Keep a copy of a recent checkpoint in a different place, so that you can see if somebody removed records. ([audit trail kit](https://github.com/ams-builds/agent-receipts-explained#what-does-it-do))

## Behavioral rules

- [ ] Write down what your agent must never do, and when it must stop and ask a person. ([behavioral rules kit](https://github.com/ams-builds/agent-governance-spec-explained#what-does-it-do))
- [ ] Make sure that the agent cannot change its own rules file. ([behavioral rules kit](https://github.com/ams-builds/agent-governance-spec-explained#what-does-it-do))

## Sovereignty

- [ ] Make a map of each place where the data of your agent goes: model, tools, storage, and logs. Record the company, the region, and the law for each place. ([sovereignty kit](https://github.com/ams-builds/aegis-sovereign-ai-explained#what-does-it-do))
- [ ] For each location, record your proof. A location from an IP address is not proof. ([sovereignty kit](https://github.com/ams-builds/aegis-sovereign-ai-explained#what-does-it-do))

## Incident response

- [ ] Name the person who can stop the agent, and write the first step to contain it. ([incident response kit](https://github.com/ams-builds/ai-incident-response-explained#what-does-it-do))
- [ ] Keep the records that you will need after an incident, and write a short plan for one likely incident. ([incident response kit](https://github.com/ams-builds/ai-incident-response-explained#what-does-it-do))

This checklist does not make your agent legal, certified, or approved. It gives you a structure.
