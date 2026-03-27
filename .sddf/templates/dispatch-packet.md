# Dispatch Packet Template
**SDDF Layer:** Execution Runtime  
**Template version:** 0.5.0

> One packet per task lane execution.

---
## Identity
- Task ID: `[feature-###]`
- Feature: `[name]`
- Wave: `[N | n/a]`
- Phase: `[RED|GREEN|REFACTOR|QUICK]`

---
## Lane Assignment
- Workspace: `[workspace name/path]`
- Thread role: `[owner|advisor|reviewer]`
- Backend: `[claude-code-cli|codex-cli]`
- Model strategy: `[pattern id or explicit model choice]`
- Skill bundle: `[bundle id]`

---
## File Contract
- Files to modify:
  - `[path]`
- Files to reference:
  - `[path]`

---
## Validation
- Required commands:
  - `[command]`
- Gate target: `[task gate|wave gate precheck]`
- Expected outcome: `[pass criteria]`

---
## Handoff Artifacts
- Result summary path: `[path]`
- Diff/report path: `[path]`
- Risk notes path: `[path]`
- Next input refs: `[paths]`

---
## Failure Policy
- Retry limit: `[N]`
- Escalation trigger: `[condition]`
- Re-decompose trigger: `[condition]`
- Owner reassignment trigger: `[condition]`

---
*Dispatch Packet | SDDF v0.5.0*
