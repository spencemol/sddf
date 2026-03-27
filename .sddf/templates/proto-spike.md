# Proto Spike Template
**SDDF Mode:** Rapid Prototyping — Vibe Sub-Mode
**Agent Autonomy:** Maximum
**Output Status:** Disposable unless graduated
**Template version:** 0.4.0

> ⚠️ PROTO CONTEXT: Code produced here is NOT production-intended.
> Agent has relaxed constraints. Nothing enters production without
> passing the Graduation Eval Gate.

---
## Spike: [Name]

---
## What Are We Trying to Learn?
*(One specific question. The more specific, the more useful the spike.)*
[Learning question]

---
## Time / Token Budget
- Time box: [N hours / days — hard limit]
- Token budget: [N tokens — suggested 10-20K]
- Stop condition: if budget is hit before question is answered, STOP and report.

---
## Hard Constraints
*(Things the agent MUST NOT do even in exploration mode. Keep this short.)*
- MUST NOT modify any production files (only create in proto/[name]/)
- MUST NOT add packages to package.json / requirements.txt
- MUST NOT connect to real production APIs or databases
- [Project-specific hard constraint]

---
## Exploration Scope
- Target area: [what part of the system / problem space]
- Approaches to try: [hypotheses, or leave open]
- Reference material: [files or docs for inspiration — not prescription]

---
## Throwaway Conditions
*(If any trigger, discard output and capture learning only)*
- If core approach requires more than [N] new external dependencies
- If implementation exceeds [N] lines for core logic
- If [specific technical condition]

---
## Success Signal
*(What would make you say "this is worth something")*
- [Concrete observable outcome 1]
- [Concrete observable outcome 2]

---
## Graduation Criteria (Preliminary)
- Tests required: [kind]
- Error handling needed: [what cases]
- Pattern alignment: [which patterns apply]
- Estimated project weight: [Quick / Standard / Full / Architecture]

---
## Agent Instructions

You are running in **PROTO SPIKE MODE**. Constraints are deliberately relaxed.
Your goal: answer the learning question above — not build production code.

1. Read the learning question. Keep it in mind throughout.
2. Explore freely within Hard Constraints.
3. Create ALL files under `proto/[spike-name]/`. Touch nothing outside.
4. Try approaches. If one isn't working, abandon it and try another.
5. Leave comments explaining choices, dead ends, and uncertainty.
6. Do not clean up or polish. Proto-quality is the target.
7. Produce a Spike Report (below) before stopping.

### Spike Report (agent produces at end)
```
## Spike Report: [Name]
Date: [date]  Token cost: [N]

### Answer
[Direct answer to the learning question]

### What We Built
[2-3 sentences]

### Key Findings
- [specific technical finding]
- [finding 2]

### Approaches Tried
| Approach | Outcome | Why Abandoned / Kept |

### Throwaway Conditions
- [ ] [condition] — [triggered / not triggered]

### Recommendation
[ ] Discard  [ ] Graduate

### If Graduating
Project weight: ___  What to keep: ___  What to rewrite: ___  Est. tokens: ___
```

---
## L5 Override (Proto Spike Mode)
File boundaries: RELAXED (proto/[name]/ only)
Dependencies: NOTE don't install — `// NEEDS: package@version`
Pattern compliance: OPTIONAL
Coverage: NOT ENFORCED
Type safety: RELAXED
Commits: `proto: spike - [description]`
Agent comments: REQUIRED — explain choices and dead ends
Proto shortcuts: mark `// PROTO-ONLY: [what production needs]`

---
*Proto Spike Template | SDDF v0.4.0*
