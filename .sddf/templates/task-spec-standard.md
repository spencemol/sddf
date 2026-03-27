# L4: Task Spec (Standard)
**SDDF Layer:** L4 — What the agent executes
**Pipeline weight:** Standard
**Template version:** 0.4.0

> Standard weight: 2-5 files, established patterns, no new architecture.
> Atomicity check: one sentence objective, ≤3 files, enumerable tests. ✓

---
## Task: [verb] [noun]

---
## Objective
[One sentence. What does this task produce?]

---
## Files to Modify
| File | Change |
|---|---|
| `src/[path]/[file].[ext]` | [what changes] |

---
## Files to Reference
| File | Why |
|---|---|
| `src/[path]/[file].[ext]` | [pattern / type / example] |

---
## Requirements
1. MUST [behavior]
2. MUST [behavior]
3. MUST NOT [prohibition]
4. SHOULD [preferred behavior]

---
## Patterns to Follow
- **[Pattern name]** — `Pattern Library: [entry]`

---
## Red Phase
**Test file:** `[path]`  **Framework:** [name]

Tests — all MUST fail before Green:
- GIVEN [state], WHEN [action], THEN [result]
- GIVEN [state], WHEN [action], THEN [result]
- GIVEN [error state], WHEN [action], THEN [error result]

---
## Green Phase
**Implement in:** `[path]`
Minimum implementation to pass Red tests. Do not modify tests.
New dependencies: [package@version or "None"]

---
## Refactor Phase
[Specific instruction or SKIP if implementation under 20 lines]

---
## Out of Scope
- [Exclusion 1]
- [Exclusion 2]

---
*L4 Task Spec (Standard) | SDDF v0.4.0*
