# Skill Bundle Template
**SDDF Layer:** Portable skill context  
**Template version:** 0.5.0

> Bundle reusable SDDF guidance so behavior stays consistent across backends.

---
## Bundle Identity
- Bundle ID: `[bundle-name-vN]`
- Purpose: `[one sentence]`
- Owner: `[team/persona]`

---
## Role Applicability
- Applicable roles:
  - `[orchestrator|implementer|reviewer|validator]`
- Not for:
  - `[roles or contexts]`

---
## Claude Native Mapping
- Native skills used:
  - `/project:[skill-name]`
- Required hooks (if any):
  - `[SessionStart|PreToolUse|PostToolUse|SubagentStop]`
- Subagent preload behavior:
  - `[how this bundle is provided to subagents]`

---
## Codex Injected-Context Mapping
- System content fragments:
  - `[path/section]`
- User content fragments:
  - `[path/section]`
- Ordering:
  1. `[fragment 1]`
  2. `[fragment 2]`
  3. `[task input]`

---
## Context Budget
- Max token budget: `[N]`
- Trim policy:
  - `[what can be dropped first]`
- Must-keep sections:
  - `[critical constraints]`

---
## Handoff Expectations
- Required outputs:
  - `[artifact types]`
- Required traceability:
  - `[task id, phase, validation evidence]`
- Failure reporting format:
  - `[template/path]`

---
*Skill Bundle | SDDF v0.5.0*
