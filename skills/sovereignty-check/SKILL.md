---
name: sovereignty-check
description: Map where the data of an AI agent goes (model provider, tools, storage, logs, memory), which country and law apply to each place, and what proof exists for each location. Use when the user asks "where does my agent's data go", "do a sovereignty check", "data residency for my agent", "which country processes my prompts", "is my agent GDPR safe on location", or asks how to prove where an AI workload ran. Based on AegisSovereignAI (Apache 2.0). Read-only and draft-first.
---

# Sovereignty check

This skill helps a small team to find where the data of its AI agent goes. It also finds which law applies, and the proof. The ideas come from [AegisSovereignAI](https://github.com/lfedgeai/AegisSovereignAI) by [InfiniEdge AI](https://github.com/lfedgeai) at LF Edge (commit `0917127`). The four questions and the data map are a method for small teams. They are not part of the source.

## Rules

1. Read and draft only. Do not change files, settings, providers, or access. Write one draft file in the project folder after the user agrees.
2. Never ask for keys, tokens, or passwords. If the user pastes one, tell them to remove it and to rotate it.
3. Mark each answer with one of three labels: PROOF, PROVIDER STATEMENT, or UNKNOWN. Do not change UNKNOWN to a guess.
4. Do not say that the agent is "sovereign" or "compliant". Say what the evidence shows.
5. This skill does not give legal advice. For a legal decision, tell the user to ask a lawyer.

## Steps

1. Ask the user which agent to check. Read its configuration, code, and documents.
2. Make a list of each place where data goes. Include the model provider, each tool or API, storage, memory, logs, backups, and monitoring tools.
3. For each place, record the company and the region. Use the configuration first, then the provider documents. Mark the source of each answer.
4. For each place, record the jurisdiction. Also record if the company is under the law of a different country. Mark the answer UNKNOWN if the documents do not say.
5. Record the type of data at each place: personal data, financial data, health data, or other. Source: the regulated sectors in `README.md` ("Enterprise Sovereign Use Cases").
6. For each location, find the type of proof:
   - An IP address check is weak. A VPN can change it. Source: `README.md`, "The Fragility of Identity & Geofencing".
   - A provider statement or contract is better, but it is not proof of each request.
   - A hardware-rooted check is strong. Source: `README.md`, "Layer 2: Unified and Extensible Identity", and `hybrid-cloud-poc/README.md`.
7. Find logs that keep raw prompts or outputs with personal data. Explain the audit paradox and the "batch and purge" method. Source: `docs/auditor-privacy-preserving-ai-governance.md`, Track C and Track D.
8. If the agent handles regulated data, show the evidence bundle example as a model of strong proof. Source: `docs/auditor.md`, section "GRC & SIEM Integration".
9. Write a draft data map. Put the gaps in order of risk: personal data in an UNKNOWN place first.
10. Show the draft to the user. Ask which gap to close first.

## Draft data map format

For each place, write one row: place, company, region, jurisdiction, type of data, proof label, and the next step.

## Common failure modes

1. **IP check as proof.** Do not accept a location from an IP address as proof.
2. **The model only.** Tools, logs, and backups also move data. Check all of them.
3. **Raw prompts for the audit.** Logs with raw prompts keep personal data. Ask if a summary or a proof is sufficient.
4. **Region is not jurisdiction.** A server in one country can belong to a company in a different country. Record both.
5. **The heavy fix first.** Do not tell a small team to install TPM hardware first. Close the UNKNOWN answers first.
