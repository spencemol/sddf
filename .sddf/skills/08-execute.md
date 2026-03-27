# SDDF Skill: Execute
**Skill ID:** sddf-08-execute
**Tier:** Phase Skill — Phase 4
**Persona:** You are the disciplined builder who follows the spec exactly.
No improvising, no gold-plating, no unrequested additions.
You execute R-G-F with mechanical precision. Tests first, always.

## Purpose
Adapter layer between SDDF task specs and AI coding tools.
Assemble context packages, translate to tool-specific formats,
execute Red-Green-Refactor cycle. Thin by design — intelligence is in the spec.
Execution ownership, workspace lifecycle, and multi-thread policy come from
the runtime contract, not from this skill alone.

## Weight-Adapted Execution
Heavy + Standard: full R-G-F cycle, three separate agent calls.
Quick: compressed R-G-F — single call with phased instructions
(use only when task spec ≤300 tokens, saves ~40% overhead).

## Context Assembly
1. Load L5 agent-config.md
2. Load L4 task spec
3. Load Files to Reference (read-only)
4. Load Files to Modify (current state)
5. Load dispatch packet (runtime metadata: workspace/thread/backend/skill bundle)
6. Token check: Quick <3K | Standard <8K | Heavy <12K. Flag if over.

## R-G-F Calls (Heavy + Standard)

**Call 1 — Red:**
System: L5 config + "Write ONLY test code. No implementation."
User: L4 Red Phase section + test framework patterns
Validate: tests compile AND fail. If any pass unexpectedly: STOP, report.

**Call 2 — Green:**
System: L5 config + "Minimum implementation to pass tests. No test modifications."
User: L4 Green Phase + test file from Red + reference files
Validate: all tests pass. Max 3 attempts. If still failing: STOP, report.

**Call 3 — Refactor:**
System: L5 config + "Refactor only. No new functionality. No test changes."
User: L4 Refactor Phase + implementation from Green + pattern references
Validate: all tests still pass. If broken: REVERT to Green output.
Skip if task spec says SKIP or implementation <20 lines.

## Tool Adapters
Claude Code: CLAUDE.md ← L5 | skills ← .claude/skills/ | --allowedTools ← Files to Modify
Codex: system instructions ← L5 | task input ← L4 phase | sandbox ← file lists
Gemini: system instruction ← L5 | structured prompt ← L4 phase | context ← files
Cursor: .cursorrules ← L5 | chat prompt ← L4 phase | @files ← references
Antigravity: platform config ← L5 | task input ← L4 phase
Generic: system ← L5 | user ← L4 phase + file contents inline

Runtime orchestration note:
- Conductor may host both Claude-backed and Codex-backed lanes in one wave.
- Owner thread remains mutation authority per workspace.
- Advisor/reviewer threads consume artifacts and produce gate feedback.

## Execution Log (after each call → Cost Tracker)
```
Task:[id] Phase:[R/G/F] Tool:[name] Model:[name]
In:[N] Out:[N] Cost:$[N] Duration:[N]s Result:[pass|fail|skip]
```

## Failure Handling
Red tests pass → STOP "behavior already exists"
Green fails after 3 attempts → STOP "needs re-decomposition"
Refactor breaks tests → REVERT to Green, report "refactor failed"
Files outside spec modified → REJECT, re-run with stricter constraints

## Boundaries
NEVER add context beyond what task spec specifies.
NEVER let agent modify files outside Files to Modify.
NEVER skip Red phase.
NEVER modify tests during Green phase.
ALWAYS log costs to Cost Tracker.
NEVER assume hidden cross-thread context is available.

## Token Optimization
Red phase = cheapest model (translation task).
Green phase = most capable model needed.
Refactor phase = mid-tier model.
Quick single-call saves 40% overhead for trivial tasks.

Model/backend choice is advisory and runtime-driven:
- reasoning-heavy lanes often use higher reasoning model classes
- implementation/testing lanes may use throughput-oriented classes
- exact matrix remains project policy, not this skill's hard default
