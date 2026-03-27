# Proto Scaffold Template
**SDDF Mode:** Rapid Prototyping — Scaffold Sub-Mode
**Agent Autonomy:** High (guided goal, open implementation)
**Output Status:** Disposable unless graduated. Expect to rewrite most of it.
**Template version:** 0.4.0

> ⚠️ PROTO CONTEXT: Working demonstration, NOT production-ready.
> Missing error handling, incomplete tests, pattern deviations, deliberate shortcuts.
> Nothing enters production without passing the Graduation Eval Gate.

---
## Scaffold: [Name]

---
## What Are We Demonstrating?
*(Specific observable behavior. Someone should watch a demo and say "yes, that's it.")*
[Demonstration goal]

---
## Why Scaffold Before Building?
*(What uncertainty does this resolve?)*
[Justification]

---
## What This Scaffold IS
- [Observable behavior 1]
- [Observable behavior 2]
- [Observable behavior 3]

---
## What This Scaffold IS NOT
- NOT production-ready (minimal error handling, illustrative tests only)
- NOT the final architecture
- NOT [specific stakeholder assumption]
- NOT [another exclusion]

---
## Acceptance Signal

**Minimum acceptance:**
- [ ] [Core behavior 1]
- [ ] [Core behavior 2]

**Stretch goals (only after minimum acceptance):**
- [ ] [Additional behavior]

---
## Time / Token Budget
- Time box: [N hours / days]
- Token budget: [N tokens — suggested 20-50K]
- Checkpoint: evaluate acceptance signal at [N tokens / halfway]

---
## Hard Constraints
- MUST NOT modify production files outside proto/[scaffold-name]/
- MUST NOT connect to real production APIs (use stubs or fixture data)
- MUST NOT add to package.json / lock files
- SHOULD produce a demo script or simple test showing acceptance signal
- [Project-specific constraint]

---
## Reference Material
- Draw inspiration from: [Pattern Library entries, existing services]
- Data fixtures: [where to find or create realistic test data]
- Integration stubs: [how to simulate external systems]

---
## Known Design Decisions to Explore
*(Agent picks one, implements it, comments on tradeoffs)*

- Decision: [e.g., "Rule table vs. function chain for decision engine?"]
  - Option A: [description]
  - Option B: [description]

---
## Graduation Criteria (Preliminary)
**Worth keeping:** [specific pieces likely to survive]
**Will be rewritten:** [pieces that are intentionally shortcuts]
**Patterns to align:** [Pattern Library entries currently violated]
**Estimated project weight:** [Quick / Standard / Full / Architecture]

---
## Agent Instructions

You are running in **PROTO SCAFFOLD MODE**. Goal: working demonstration.

1. Read "What This Scaffold IS" — that's your definition of done.
2. Read "What This Scaffold IS NOT" equally carefully. Stay inside scope.
3. Create ALL files under `proto/[scaffold-name]/`.
4. At the acceptance signal, pause and produce an Interim Report.
5. For each Design Decision, make an explicit choice and comment:
   `// DESIGN DECISION: Chose [X] over [Y] because [reason]. Revisit at graduation.`
6. Mark shortcuts: `// PROTO-ONLY: No error handling. Production needs [X].`
7. Produce Scaffold Report at the end.

### Interim Report (at acceptance signal)
```
## Scaffold Interim: [Name]
Tokens so far: [N]  Remaining: [N]

Acceptance signal:
- [x] [item 1] — ACHIEVED
- [ ] [stretch goal] — not yet

Continue to stretch goals? [Y/N with reasoning]
```

### Scaffold Report (at end)
```
## Scaffold Report: [Name]
Date: [date]  Total tokens: [N]

### Demonstration Summary
[2-3 sentences]

### Acceptance Signal
- [x] [minimum 1]
- [ ] [stretch — reached/not reached]

### Design Decisions Made
| Decision | Choice | Tradeoffs Observed |

### Proto Shortcuts Logged
| File:Line | Shortcut | Production Needs |

### Code Worth Keeping vs Rewriting
| Component | Keep/Rewrite | Notes |

### Architectural Surprises
[Anything unexpected — good or bad]

### Recommendation
[ ] Discard  [ ] Graduate

### If Graduating
Weight: ___  Est. tokens: ___
First tasks: [rough L4 task names]
```

---
## L5 Override (Proto Scaffold Mode)
File boundaries: RELAXED (proto/[scaffold-name]/ only)
Dependencies: NOTE don't install — `// NEEDS: package@version`
Pattern compliance: GUIDED — deviate with `// PROTO: using X instead of Y for speed`
Coverage: ILLUSTRATIVE — one test showing acceptance signal minimum
Type safety: PRAGMATIC
Error handling: MINIMAL — happy path only, console.log errors, mark PROTO-ONLY
Commits: `proto: scaffold - [description]`
Design decisions: REQUIRED to be commented explicitly
Proto shortcuts: REQUIRED to be marked with `// PROTO-ONLY:`

---
*Proto Scaffold Template | SDDF v0.4.0*
