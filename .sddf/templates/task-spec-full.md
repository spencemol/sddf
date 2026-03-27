# L4: Task Spec (Full)
**SDDF Layer:** L4 — What the agent executes
**Pipeline weight:** Full
**Template version:** 0.4.0

> Atomicity check before submitting:
> Objective in one sentence with no "and"? ✓
> Files to Modify lists ≤3 files? ✓
> Can you enumerate Red phase tests right now? ✓
> If any check fails — split this task further.

---
## Task: [verb] [noun]

---
## Metadata
| Field | Value |
|---|---|
| Task ID | `[feature]-[NNN]` |
| Feature | [L3 feature spec name] |
| Wave | [N] |
| Dependencies | [Task IDs or "None"] |
| Blocks | [Task IDs or "None"] |
| Estimated tokens | [N] (spec ~500 + config ~800 + refs ~[N]) |
| Pattern Library refs | [pattern names] |

---
## Objective
[One sentence. What does this task produce?]

---
## Files to Modify
| File | Change Description |
|---|---|
| `src/[path]/[file].[ext]` | [what specifically changes] |
| `src/[path]/[file].test.[ext]` | [test cases added] |

---
## Files to Reference (Read-Only, max 5)
| File | Why Referenced |
|---|---|
| `src/[path]/[file].[ext]` | [specific reason] |

---
## Requirements
1. MUST [specific verifiable behavior]
2. MUST [specific verifiable behavior]
3. MUST NOT [specific prohibition]
4. SHOULD [preferred behavior]
5. MAY [optional enhancement]

---
## Patterns to Follow
- **[Pattern name]** — `Pattern Library: [entry]`
  *Specific application: [how it applies here]*

---
## Execution Mode
**Cycle:** Red → Green → Refactor

### Red Phase — Tests First
**Test file:** `[path]`  **Framework:** [name]

| # | Case | GIVEN | WHEN | THEN |
|---|---|---|---|---|
| 1 | [name] | [precondition] | [action] | [expected result] |
| 2 | [name] | | | |
| 3 | [name] | | | |
| 4 | [negative case] | | | [error thrown] |
| 5 | [edge case] | | | |

**Confirm:** All tests MUST fail before Green. If any pass: STOP and report.

### Green Phase — Minimum Implementation
**Implement in:** `[path(s)]`
- Do NOT add functionality beyond what tests require
- Do NOT modify test files
- Do NOT refactor adjacent code
**Approved new dependencies:** [package@version or "None"]
**Confirm:** All tests MUST pass. Max 3 attempts. If still failing: STOP and report.

### Refactor Phase
**Skip if** implementation is under 20 lines.
- [Specific action — e.g., "Extract validation into private method"]
- [Specific action — e.g., "Align error throwing with DomainError pattern"]
**Confirm:** All tests still pass. If refactoring breaks tests: REVERT to Green output.

---
## Out of Scope
- [Explicit exclusion — the "while I'm in there" temptations]
- [Handled in task: [name] — [ID]]

---
## Brownfield Notes *(skip for greenfield)*
**Existing behavior that MUST NOT change:** [list]
**Backward compatibility:** [requirement]

---
*L4 Task Spec (Full) | SDDF v0.4.0 — Agent sees: this file + L5 + Files to Reference only*
