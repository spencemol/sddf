# L4: Task Spec (Quick)
**SDDF Layer:** L4 — What the agent executes
**Pipeline weight:** Quick
**Template version:** 0.4.0

> Quick Mode checklist before using this template:
> - [ ] Single file change (or two if test is separate)
> - [ ] Known pattern — no new architecture
> - [ ] No MCP/REST integration
> - [ ] No agent decision logic
> - [ ] Bug fix with verified root cause OR trivial addition
> If any box is unchecked → upgrade to Standard or Full.

---
## Quick Task: [Short descriptive name]

---
## Objective
[One sentence]

---
## File to Modify
`[exact path]` — [what changes in one sentence]

---
## Change Description
[2-4 sentences. Enough for no ambiguity. More than 4 sentences = not Quick weight.]

---
## Pattern Reference
[Pattern Library entry name, or "N/A — follows adjacent code in [file]"]

---
## Test
- GIVEN [state], WHEN [action], THEN [specific result]
- [Second case if needed]

Existing tests must continue passing.

---
## R-G-F (single call)
```
Phase 1 — Red: Write the test above. Run it. Confirm it FAILS.
Phase 2 — Green: Minimal change to pass. Do not modify the test.
Phase 3 — Refactor: SKIP (Quick Mode).
Final: Run full test suite. All existing tests must still pass.
```

---
*L4 Task Spec (Quick) | SDDF v0.4.0*
