---
name: ai-incident-response
description: Help a small team or solo builder make an incident response plan for their own AI agent, based on the CoSAI AI Incident Response Framework V1.0. Use this skill when the user asks to "make an incident response plan", "what do I do if my agent goes wrong", "what if my agent gets a prompt injection", "how do I stop my agent", "which logs must I keep for an AI incident", "write an AI incident playbook", or asks how to contain, investigate, or recover from a problem with an AI agent or model they built.
---

# AI incident response plan

This skill helps the user make a short incident response plan for their own AI agent. The method comes from the [AI Incident Response Framework, V1.0](https://github.com/cosai-oasis/ws2-defenders/blob/main/incident-response/AI-Incident-Response.md) by [CoSAI](https://github.com/cosai-oasis) Workstream 2 (an [OASIS Open](https://github.com/oasis-open) project), at commit `b8dbec1`. The source was written for security teams in large organizations. This skill makes it smaller for one person or a small team.

Read and draft first. Do not change the agent, its logs, or its settings. Write the plan as a draft file in the project of the user, and show it before you save it. Never ask for a key, a token, or a password.

## Step 1: List the agents

Ask the user which AI agents or AI features they run. For each one, write:

1. The name and the owner.
2. The data it uses or can get to.
3. The tools it can use.
4. How important it is to the users or the business.

Source: section 1.3.2, "Preparation" (production model inventory).

## Step 2: Find the type of each system

Put each agent into one type. Source: section 6.2.

1. Basic model: a model that answers from a prompt only.
2. Model with memory: it keeps past conversations or facts.
3. Retrieval (RAG): it reads documents from a data source before it answers.
4. Agent: it plans steps and uses tools.
5. Agent with retrieval: an agent that also reads from data sources.

## Step 3: Write the first containment step

For each agent, write the first action that stops the damage. Use the type from step 2. Source: section 3.3.3, "Containment Strategies".

1. Basic model: validate the input and filter the content.
2. Model with memory: reset the memory and isolate the sessions.
3. Retrieval: quarantine the data source and check what it found.
4. Agent: disable the tools and check least privilege.
5. Agent with retrieval: combine the steps for retrieval and agent.

Also write how to roll back to an earlier version, and who can do it. If no person can stop the agent quickly, tell the user. This is the first gap to close.

## Step 4: Check the records

Find which of these records the user keeps today. Source: section 3.2 and section 3.3.3.1, "Forensics for AI Systems".

1. Each version of the system prompt.
2. The user prompts.
3. The model name, version, and settings.
4. The raw output of the model, before any filter.
5. Each tool call and its result. Include the calls to MCP servers.
6. The logs of connected systems, such as the web server and the database.

For each missing record, write it as a gap. Tell the user why the raw output is important. An AI model can give a different answer to the same input. Thus, the raw output is the only exact evidence. Ask how long they must keep each record, and write it in the plan.

## Step 5: Write who decides

Use the roles from section 1.3.3: incident commander, AI or ML engineer, legal and compliance, and communications. In a small team, one person can hold more than one role. Write a name for each role. Write who can declare an incident and who can take the agent offline. Label this adaptation for small teams as your suggestion, not as the words of the source.

## Step 6: Write one playbook

Ask the user which incident is most likely for their agent. For an agent that reads web pages, email, or documents, suggest prompt injection. Write a short playbook with the six parts from section 1.3.4:

1. Incident type.
2. Detection: the signal or report that shows it.
3. Triage and severity: how serious, and who to tell.
4. Containment steps.
5. Eradication and recovery: remove the cause, test, then restore and watch closely.
6. Communication: a short message for users, if they are affected.

For full examples, refer the user to section 4.3, "Sample Playbook Library" (for example 4.3.2, prompt injection). Do not copy those playbooks into the plan.

## Step 7: Plan the review

Write that after each incident, the team holds a blameless review within an agreed time. The review writes a timeline, the root cause, and actions with owners and deadlines. The actions update this plan. Source: section 1.3.5 and section 3.3.4.

## Common failure modes

1. **No person can stop the agent.** A plan has no value if nobody can disable the agent quickly. That person needs the authority and the access.
2. **The logs do not keep the raw output.** Filtered or summarized logs cannot show what the model actually did.
3. **Investigate before contain.** The damage continues while the team looks for the cause. Stop the damage first.
4. **A review that looks for blame.** People then hide problems. Look for the cause and the fix.
5. **A plan that nobody tests.** Suggest a short practice exercise with one made-up incident.

## Output

Give the user one draft file, for example `incident-plan.md`, with these sections: agents, system types, containment steps, records and gaps, roles, one playbook, and the review. Mark each item that is your suggestion and not from the source. List the gaps first, in order of risk.
