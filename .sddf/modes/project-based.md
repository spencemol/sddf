# SDDF Mode: Project-Based
**Version:** 0.5.0

## Philosophy
Project-Based Mode optimizes for production durability.
You know what you're building. Code is a deliverable that must survive
in a real system. The human owns the spec. The agent executes.
Review gates enforce quality at every phase transition.
Runtime orchestration is explicit and separate from backend adapter rules.

## Weight Classes

### Quick
Single-file, bug fix with known root cause, trivial addition in established pattern.
Process: L4 only → compressed R-G-F (single call) → fast validation gate
Appropriate for: bug fixes, config changes, extending enums, tiny additions
NOT for: any MCP/REST integration, any agent decision logic, first-time patterns

### Standard
2-5 files, well-understood pattern, established architecture.
Process: lightweight L3 → L4 → R-G-F (3 calls) → validation
Appropriate for: new endpoint following existing pattern, new event handler
mirroring an existing one, moderate feature additions

### Full
New capability, new patterns, integration work, agent decision logic.
Process: L1 reference → L2 review → L3 → L4s → wave plan →
R-G-F per task → wave gates → validation → ship
Appropriate for: most new features, MCP integrations, autonomous behavior

### Architecture
System boundary change, new service, new integration contract, L2 update.
Process: full pipeline + mandatory architect review before any L4 tasks.
L2 must be approved before decomposition begins.

## Weight Classification Rules
When in doubt, classify heavier.
First-time patterns = Full (even if one file).
MCP/REST integration = Standard or Full (never Quick).
Agent decision logic = Full always.
System boundary change = Architecture.

## The 5 Phases
```
SCOPE → SPEC → DECOMPOSE → EXECUTE → VALIDATE
(Human)  (Human)  (Human)    (Agent)   (Human)
```

Quick collapses to: DECOMPOSE → EXECUTE → VALIDATE
Standard collapses to: SPEC (lightweight) → DECOMPOSE → EXECUTE → VALIDATE

## Execution Model
Every task follows R-G-F regardless of weight:
Red: failing tests first | Green: minimum impl | Refactor: clean up with safety net
Quick mode: compressed to single agent call (≤300 token spec only).

Quick refactor may be skipped by spec rule.

## Wave Execution (Full + Architecture only)
Tasks grouped by dependency depth. Within-wave tasks run simultaneously.
Wave gate (full test suite) runs after each wave before advancing.
See Decompose Skill (07) for wave plan format.

## Runtime Ownership Model (All Weights)
- One workspace owner thread owns mutations by default.
- Additional threads in a workspace are advisor/reviewer unless explicitly promoted.
- Cross-lane coordination is artifact-based, not live peer-to-peer chat coordination.
- Runtime-specific controls (workspaces, scripts, checkpoints) come from runtime guides.

See `.sddf/execution/runtime-contract.md` and `.sddf/execution/dispatch-model.md`.

## Parallel Quick Clarification
Parallel Quick means multiple independent Quick tasks may run concurrently,
each in a separate workspace/lane with single-owner mutation policy.
It does not mean one Quick task is split across multiple mutating agents.

## Review Gates
| Gate | Weight | What's Checked |
|---|---|---|
| Spec gate | Full | L3 completeness check (Eval Skill) |
| Decompose gate | Full | L4 atomicity + file conflicts |
| Task gate | All | R-G-F audit + file boundaries + requirements trace |
| Wave gate | Full | Full suite + type check + lint + interface compat |
| Ship gate | All | All tasks done + coverage + no open TODOs |

## Proto → Project Transition
When proto output graduates via the Graduation Eval Gate:
1. Human selects weight class based on eval recommendation
2. Decompose Skill writes fresh L4 specs using proto as reference
3. Proto code is reference material only — never modified in-place
4. Project pipeline runs normally from that point
