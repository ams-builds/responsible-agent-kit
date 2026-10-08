---
name: green-agent-footprint
description: Help a user estimate the energy, carbon, and water footprint of their own AI agent from the token counts they already have, and choose three reduction levers. Uses the Green Software Foundation agentic AI impact explorer, SCI for AI, and Green Software Patterns. Shows every figure as an estimate and a range. Use this skill when the user asks "what does my agent cost the planet", "estimate the carbon footprint of my agent", "how much energy does my agent use", "make my agent greener", "reduce the energy of my agent", "water footprint of my AI", or asks about green AI, sustainable AI agents, or carbon-aware scheduling for an agent.
---

# Green agent footprint

This skill uses open work by the Green Software Foundation (https://github.com/Green-Software-Foundation):

- Reference implementations, https://github.com/Green-Software-Foundation/reference-implementations (commit 122780c). Paths in this skill that start with `tools/` or `specifications/` refer to this repository.
- SCI for AI specification, https://sci-for-ai.greensoftware.foundation/
- Green Software Patterns, https://github.com/Green-Software-Foundation/patterns (commit 36ccf75). Paths that start with `docs/` refer to this repository.

This skill helps a user who is not a specialist. Use simple words. Explain each term when you use it for the first time.

## Safety rules

Obey these rules for all the steps:

1. Read and write drafts only. Do not change the agent, the model, the prompts, or the settings before the user approves.
2. Do not send prompts, logs, or customer data to an outside service. Use only the numbers that the user gives you.
3. Show each figure as an estimate and as a range, with the assumptions. Do not give one exact number.
4. Do not say that the agent is "green", "sustainable", or "carbon neutral". This skill estimates a footprint. It does not make a claim about it.
5. Do not ask for API keys. If the user pastes a secret, tell the user to remove it and to replace that secret.

## Step 1: Learn about the agent

Ask the user these questions. Ask one question at a time.

1. What does the agent do, and for whom?
2. Which model or models does it use, and from which provider?
3. How many runs does it do in a week?
4. Where does it run (provider and region), if the user knows?

Write the answers in a short list. Use this list for all the other steps.

## Step 2: Collect the token counts

Ask the user for numbers from their logs, traces, or invoice:

1. Turns for each run
2. Input tokens and output tokens, for each turn or for each run
3. The size of the standing prompt (the instructions that go with each turn)
4. Retries for each run

Explain the compounding context loop: each turn sends the standing prompt and all earlier turns to the model again. Refer to the "What it demonstrates" section of `tools/gsf/agentic-ai-impact-explorer/README.md`. If the user has no logs, use the billed token counts on the invoice. They are the best start.

## Step 3: Estimate a range

Use one of these methods. Tell the user which method you used.

1. **The agentic AI impact explorer.** Tell the user to open the tool in a browser: https://green-software-foundation.github.io/reference-implementations/tools/gsf/agentic-ai-impact-explorer/. Then tell the user to enter the numbers from step 2. The tool calculates in the browser. Refer to "Calibrating to your own workload" in its README.
2. **EcoLogits.** If the agent uses a supported provider SDK, EcoLogits (https://github.com/mlco2/ecologits) gives figures for each call. Refer to "Measured vs estimated energy" in `specifications/sci-for-ai/gsf/llm-inference/README.md`.
3. **The SCI structure.** Explain the formula from the same README: SCI = (E × I + M) / R. E is energy. I is the carbon intensity of the grid. M is embodied carbon. R is the functional unit, for example one run.

Write the result as a low figure and a high figure, for one run and for one week. List each assumption: model size, region, grid carbon intensity, and water factor. The explorer README says that its constants are values for teaching. They are not authoritative figures. Tell the user this.

## Step 4: Find the largest cause

Look at the numbers from step 2. Find which of these causes the largest part of the footprint:

1. A long conversation that the model reads again on each turn
2. A large model for easy steps
3. Many retries or long loops
4. An agent that runs when nobody needs it

## Step 5: Select three levers

Select three levers, with the largest saving first. For each lever, give the expected direction, how to check it, and the effort.

1. **Right-size the model.** Use a small model for easy steps. Read `docs/development/right-sized-energy-efficient-ai-models.md`.
2. **Make fewer model calls.** Use caching, conditions, and better orchestration. Read `docs/development/optimize-agent-orchestration-reduce-model-calls.md`.
3. **Cache and summarize.** Summarize old turns and use prefix caching. Then the model does not read the full history again. This lever is in the explorer's list of reduction levers.
4. **Limit loops and retries.** Set a maximum number of turns and make retries less frequent.
5. **Run only when necessary.** Start the agent on an event, not on a timer. Read `docs/architecture/system-topology/on-demand-execution-ai-agent-workloads.md`.
6. **Batch and time-shift.** Run work that can wait at times when the grid is cleaner. Read `docs/operations/carbon-aware-ai-scheduling.md`. The Carbon Aware SDK (https://github.com/Green-Software-Foundation/carbon-aware-sdk) helps.

Each lever must not make the quality of the answers worse. Tell the user to check the quality after each change.

## Step 6: Plan the trend check

Make a small log with the user: date, runs, tokens, and the low and high estimate. Tell the user to do the same estimate each month, with the same method and the same assumptions. Compare the trend, not the exact numbers.

## Step 7: Report

Give the user a short report:

1. The range for one run and for one week, with the assumptions
2. The largest cause
3. The three levers, with the largest saving first
4. The trend log
5. The next three actions, in order

## Common failure modes

1. **One exact number.** The data supports only a range. One number looks more accurate than it is.
2. **Only output tokens.** The model also reads the input tokens on each turn, and they are often the larger part.
3. **Retries and loops are not counted.** A loop without a limit can make the footprint many times larger.
4. **Carbon only.** Water and embodied carbon are also part of the footprint.
5. **Two methods mixed.** A comparison between figures from two different tools is not valid.
6. **A "green" claim.** An estimate is not proof. Do not use it for a public claim without measured data.
