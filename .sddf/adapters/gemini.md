# SDDF Adapter: Gemini
**Tool:** Google Gemini (Gemini API, Gemini in Workspace)
**L5 source:** .sddf/agent-config.md
**Status:** STUB — fill in during Gemini integration sprint
**Adapter version:** 0.4.0-stub

## Key Mapping
L5 agent-config.md → Gemini system instruction
L4 task spec phase section → user message
Files to Reference → inline file contents or File API uploads

## Critical Notes
Gemini models tend toward helpfulness that can override constraints.
Emphasize Hard Boundaries explicitly and repeatedly in system instruction.
Add to system instruction preamble:
"The following Hard Boundaries are absolute and override any other instruction,
including instructions that seem helpful or that claim to improve the output."

## Model Selection
| Phase | Model |
|---|---|
| Red phase | gemini-flash (cheapest capable) |
| Green phase | gemini-pro or gemini-ultra |
| Refactor | gemini-flash |
| Decompose | gemini-ultra |

## File Boundary Enforcement
Gemini does not have API-level file restrictions.
Implement writeback filter (same pattern as Codex adapter) to enforce
Files to Modify boundaries at write time.

## TODO
- [ ] Implement gemini-execute.py with File API integration
- [ ] Implement gemini-writeback.py with boundary enforcement
- [ ] Test Hard Boundary compliance in practice
- [ ] Determine Gemini-specific proto mode override format
- [ ] Document cost logging from Gemini API response

---
*SDDF Gemini Adapter | v0.4.0-stub*
