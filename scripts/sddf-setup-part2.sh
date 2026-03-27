#!/usr/bin/env bash
set -euo pipefail
echo "🔧 SDDF Setup — Part 2: Templates"

# ── L1: Project Charter ───────────────────────────────────────────────────────
cat > .sddf/templates/project-charter.md << 'EOF'
# L1: Project Charter
**SDDF Layer:** L1 — Why we are building this
**Owner:** Product + Engineering Leadership
**Sent to agents:** Never
**Template version:** 0.4.0

> Fill every section. Vague charters produce vague features.
> Mark APPROVED when all stakeholders sign off.
> No L2 or L3 work begins until APPROVED.

**Status:** [ ] DRAFT  [ ] IN REVIEW  [ ] APPROVED
**Approved by:** _______________  **Date:** _______________

---
## Project: [Name]
*Use this name consistently across all SDDF docs, repos, and agent configs.*

---
## Business Problem
<!--
2-3 sentences. What pain exists today? Who feels it? What does it cost?
Do NOT describe the solution — only the problem.
-->

---
## Success Metrics

| Metric | Baseline | Target | Measurement Method |
|---|---|---|---|
| [Metric 1] | | | |
| [Metric 2] | | | |

---
## Stakeholders

| Name / Role | Decision Authority | Primary Concern |
|---|---|---|
| | Final approval | |
| | Input | |

---
## Hard Constraints

**Timeline:** Must be in production by: ___  Key deadlines: ___

**Technology:** Required stack: ___  Forbidden: ___
Existing systems that must not break: ___

**Compliance / Regulatory:** ___

**Team / Budget:** Team: ___  Budget ceiling: ___

---
## Out of Scope
*CRITICAL. Minimum 3 explicit exclusions.*

- [ ] [Thing someone would assume is included]
- [ ] [Thing 2]
- [ ] [Thing 3]

---
## Dependencies

| Dependency | Owner | Status | Risk if Delayed |
|---|---|---|---|

---
## Risks

| Risk | Likelihood | Impact | Mitigation | Owner |
|---|---|---|---|---|

---
## Changelog

| Date | Change | Author |
|---|---|---|
| [date] | Initial draft | |

---
*L1 Project Charter | SDDF v0.4.0*
EOF

# ── L2: Architecture Document ─────────────────────────────────────────────────
cat > .sddf/templates/architecture-doc.md << 'EOF'
# L2: System Architecture Document
**SDDF Layer:** L2 — How the system is shaped
**Owner:** Staff / Principal Engineers
**Sent to agents:** Relevant sections only
**Template version:** 0.4.0

> This document defines system shape before feature work begins.
> Updated when architectural decisions change — not when features are added.
> Complete the Agent Architecture Addendum for autonomous/pipeline systems.
> Mark APPROVED before any L4 task specs are written.

**Status:** [ ] DRAFT  [ ] IN REVIEW  [ ] APPROVED
**Approved by:** _______________  **Last updated:** _______________

---
## System: [Name]

---
## System Boundary
[What this system owns vs. delegates]

### Context Diagram
```mermaid
graph LR
  A[External Caller] -->|REST| B[This System]
  B -->|MCP| C[External Service]
```

---
## Service / Module Inventory

| Module | Location | Responsibility | Key Exports | Depends On |
|---|---|---|---|---|

---
## Integration Points

| External System | Protocol | Direction | Auth | Rate Limit | Freshness | On Failure |
|---|---|---|---|---|---|---|

---
## Technology Stack

| Concern | Choice | Version | Rationale |
|---|---|---|---|
| Language | | | |
| Framework | | | |
| Test framework | | | |
| Database | | | |
| Deployment | | | |

---
## Data Model
```typescript
interface [EntityName] {
  id: string;
  // key fields
  createdAt: string;
  updatedAt: string;
}
```

---
## Approved Patterns

| Pattern | Pattern Library Reference | Where Used |
|---|---|---|

---
## Architectural Constraints
- MUST NOT: [constraint]
- MUST NOT: [constraint]
- SHOULD NOT: [softer constraint]

---
## Known Technical Debt

| Item | Location | Why | Plan | Impact on Task Specs |
|---|---|---|---|---|

---
## Brownfield Notes *(skip for greenfield)*

### Legacy Patterns to Avoid
- [Pattern] in [location] — DO NOT replicate. Use [better pattern] instead.

### Backward Compatibility Requirements
[What must not break, and for how long]

---
## Agent Architecture Addendum
*(Complete for autonomous-agent and workflow-pipeline types only)*

### System Type
[ ] Autonomous Agent  [ ] Workflow Pipeline  [ ] Hybrid  [ ] N/A

### Trigger Conditions
| Trigger | Mechanism | Frequency / Condition |
|---|---|---|

### Tool Access
| Tool / API | Protocol | Permission | Purpose | Rate Limit |
|---|---|---|---|---|

### Decision Boundaries
| Decision | Autonomous? | Approval From | Escalation Path |
|---|---|---|---|

### Failure Modes
| Failure | Detection | Agent Response | Human Alert? |
|---|---|---|---|

### Observability
Decision audit log: `{ timestamp, trigger, inputs, decision, action, outcome }`
Retention: ___  Location: ___

Metrics:
| Metric | Type | Alert Threshold |
|---|---|---|

Shadow Mode required: [ ] Yes (duration: ___)  [ ] No

---
## Changelog

| Date | Change | Author | Impact |
|---|---|---|---|

---
*L2 System Architecture Document | SDDF v0.4.0*
EOF

# ── L3: Feature Spec ──────────────────────────────────────────────────────────
cat > .sddf/templates/feature-spec.md << 'EOF'
# L3: Feature Spec
**SDDF Layer:** L3 — What exactly we are building
**Owner:** Product + Engineering
**Sent to agents:** Never directly. Decomposed into L4 task specs.
**Template version:** 0.4.0

> Fill every section before marking APPROVED.
> Use MUST / SHOULD / MAY (RFC 2119) throughout.
> Every MUST needs a corresponding acceptance criterion.
> Starred (*) sections required for Standard weight (lightweight L3).

**Status:** [ ] DRAFT  [ ] IN REVIEW  [ ] APPROVED
**Weight:** [ ] Standard (lightweight)  [ ] Full  [ ] Architecture

---
## Feature: [Name] *

---
## Context *
[Why this feature exists. Link to L1 charter goal.]
**Charter reference:** [project name] — [success metric this supports]

---
## User Stories *
- As a **[role]**, I want **[capability]**, so that **[outcome]**.

---
## Behavior Specification *

### Happy Path
1. [Step 1]
2. [Step 2]

### Edge Cases
| Condition | Expected Behavior |
|---|---|

### Error States
| Condition | Response | HTTP Status | User Message |
|---|---|---|---|

---
## Acceptance Criteria *
*(GIVEN/WHEN/THEN. Min 5 for Full, min 3 for Standard.)*

- [ ] GIVEN [state], WHEN [action], THEN [specific measurable result]
- [ ] GIVEN [state], WHEN [action], THEN [specific measurable result]
- [ ] GIVEN [state], WHEN [action], THEN [specific measurable result]
- [ ] GIVEN [state], WHEN [action], THEN [specific measurable result]
- [ ] GIVEN [state], WHEN [action], THEN [specific measurable result]

---
## Scope Boundary *
*(Min 3 explicit exclusions. This section is never optional.)*

This feature does NOT include:
- [ ] [Explicit exclusion 1]
- [ ] [Explicit exclusion 2]
- [ ] [Explicit exclusion 3]

---
## Integration Contract *(skip if no external calls)*

| External System | Tool / Endpoint | Direction | Auth | Rate Limit | Failure Handling | Freshness |
|---|---|---|---|---|---|---|

---
## Data Requirements
New entities: ___
| Entity | Field | Type | Default | Migration? |
|---|---|---|---|---|

---
## UI / UX Reference
[ ] No UI changes  [ ] Wireframes: [link]  [ ] Mockups: [link]

---
## Dependencies
| Dependency | Type | Status | Owner | Risk |
|---|---|---|---|---|

---
## Rollout Strategy
Feature flag required: [ ] Yes  [ ] No
Flag name: `[flag-name]`
1. Shadow mode — [duration]
2. [N]% — [gate condition]
3. 50% — [gate condition]
4. 100% — [final condition]
Rollback: [how to disable]

---
## Observability
Logs: ___
| Metric | Type | Alert Threshold |
|---|---|---|

---
## Open Questions
*(Must all be resolved before APPROVED)*

| Question | Owner | Resolution Date | Answer |
|---|---|---|---|

---
## Changelog
| Date | Change | Author |
|---|---|---|

---
*L3 Feature Spec | SDDF v0.4.0*
EOF

# ── L4: Task Spec Full ────────────────────────────────────────────────────────
cat > .sddf/templates/task-spec-full.md << 'EOF'
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
EOF

# ── L4: Task Spec Standard ────────────────────────────────────────────────────
cat > .sddf/templates/task-spec-standard.md << 'EOF'
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
EOF

# ── L4: Task Spec Quick ───────────────────────────────────────────────────────
cat > .sddf/templates/task-spec-quick.md << 'EOF'
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
EOF

# ── L5: Agent Config ──────────────────────────────────────────────────────────
cat > .sddf/templates/agent-config.md << 'EOF'
# L5: Agent Configuration
**SDDF Layer:** L5 — How the agent behaves
**Owner:** Engineering Lead / DevEx team
**Vendor-neutral source:** translate to tool-specific adapters
**Target:** under 800 tokens total
**Template version:** 0.4.0

> This is the vendor-neutral source. Do not put tool-specific syntax here.
> After completing, generate adapter files from adapters/*.md.

---
## Project: [Name]

---
## Agent Persona
You are a disciplined engineer working on [project name]. You follow the task
spec exactly, use established patterns, write tests before implementation,
and do not add unrequested functionality.

---
## Code Style
- Language: [TypeScript strict / Python 3.11+ / etc.]
- [Rule that would be violated without explicit instruction]
- [Rule 2]
- [Rule 3]

---
## Naming Conventions
| Element | Convention | Example |
|---|---|---|
| Files | [kebab-case] | user-service.ts |
| Classes | [PascalCase] | UserService |
| Functions | [camelCase] | deactivateUser |
| Constants | [SCREAMING_SNAKE] | MAX_RETRY_COUNT |
| Test files | [pattern] | user-service.test.ts |

---
## Testing Standards
- Framework: [name]
- Coverage: [N]% on all new code
- Location: [colocated / separate tests/]
- Structure: describe → it/test → arrange → act → assert
- Mocking: [preferred approach]
- Minimum: happy path + at least one error/edge case per task

---
## Commit Convention
- Format: [Conventional Commits / other]
- Pattern: `[type](scope): description`
- One logical change per commit
- Proto prefix: `proto: [spike|scaffold] - description`

---
## Import / Dependency Rules
- Package manager: [npm / pip / etc.]
- Import order: [external → internal → relative]
- Circular dependencies: NEVER introduce

---
## HARD BOUNDARIES (override all other instructions)
1. NEVER modify files not listed in the task spec's Files to Modify
2. NEVER add packages to package.json / requirements.txt unless
   explicitly approved in the task spec's Green Phase section
3. NEVER refactor code outside the task spec's scope
4. NEVER skip the Red phase — tests must fail before implementation
5. NEVER modify test files during the Green phase
6. [Project-specific boundary]

---
## Error Handling
- Error base class: [e.g., DomainError from src/errors/]
- HTTP error shape: [e.g., { error: string, code: string }]
- Logging on error: [e.g., always log with correlation ID + stack]
- Retries: [e.g., max 3 with exponential backoff]

---
## Observability
- Logger: [import path] — `logger.[level](message, { context })`
- Correlation ID: [how to propagate]
- Metrics: [how to emit]

---
## Proto Mode Overrides
*(Active only when task spec is marked PROTO SPIKE MODE or PROTO SCAFFOLD MODE)*

- File boundaries: RELAXED — create files in proto/[name]/ only
- Dependencies: NOTE but don't install — comment `// NEEDS: package@version`
- Pattern compliance: OPTIONAL — deviate with explicit comment
- Coverage: NOT ENFORCED
- Type safety: PRAGMATIC — use any where it speeds exploration
- Commits: `proto: [spike|scaffold] - description`
- Proto shortcuts: mark with `// PROTO-ONLY: [what production needs]`
- Comments explaining choices and dead ends: REQUIRED

---
## Adapter Notes
*(For the human generating tool-specific adapter files)*

Claude Code (CLAUDE.md): Hard Boundaries verbatim. Use --allowedTools.
Drop skills into .claude/skills/.

Codex: Map to system instructions. Hard Boundaries first.
Implement writeback filter to enforce file boundaries at write time.

Cursor (.cursorrules): Map Hard Boundaries to rules.
Use @files syntax for task spec reference files.

Gemini: Emphasize Hard Boundaries explicitly — Gemini models tend toward
helpfulness that can override constraints without explicit emphasis.

---
*L5 Agent Configuration | SDDF v0.4.0 — vendor-neutral source*
EOF

# ── Proto Spike ───────────────────────────────────────────────────────────────
cat > .sddf/templates/proto-spike.md << 'EOF'
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
EOF

# ── Proto Scaffold ────────────────────────────────────────────────────────────
cat > .sddf/templates/proto-scaffold.md << 'EOF'
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
EOF

# ── Graduation Eval ───────────────────────────────────────────────────────────
cat > .sddf/templates/graduation-eval.md << 'EOF'
# Graduation Eval Gate Template
**SDDF Mode:** Transitional (Proto → Project)
**Agent role:** Produces Parts 1-5
**Human role:** Makes graduation decision (Part 6) — never automated
**Template version:** 0.4.0

> This is the firewall between prototyping and production.
> Proto code NEVER directly becomes production code.
> L4 task specs for graduated work are written FRESH.
> The proto is reference material only — not a foundation.

---
## Graduation Eval: [Proto Name]
**Proto type:** [ ] Spike  [ ] Scaffold
**Proto directory:** `proto/[name]/`
**Date:** ___  **Evaluated by:** ___

---
## Part 1: Learning Capture (Agent-Produced)

### Learning Question
[Restate from proto spec]

### Was It Answered?
[ ] Yes — fully  [ ] Partially  [ ] No

### Core Findings
1. [Finding — specific, technical, honest]
2. [Finding]
3. [Finding]

### Architectural Revelations
[What did the proto reveal that wasn't anticipated, or "None — confirmed assumptions"]

### Approach Validation
| Approach / Decision | Validated? | Evidence | Recommendation |
|---|---|---|---|

---
## Part 2: Throwaway Conditions Check (Agent-Produced)

| Condition | Status | Evidence |
|---|---|---|
| [Condition from proto spec] | [Triggered / Not triggered] | [specific] |

**Verdict:** [ ] No conditions triggered — proceed  [ ] Condition(s) triggered — recommend DISCARD

---
## Part 3: Production Gap Assessment (Agent-Produced)

### Pattern Library Gaps
| Proto Approach | Required Pattern | Effort (S/M/L) | Files Affected |
|---|---|---|---|

### Missing Error Handling
| File:Line | Shortcut | Production Requirement |
|---|---|---|

### Missing Test Coverage
| Behavior | Proto Tests | Production Tests Required |
|---|---|---|

### Missing Resilience
| Integration Point | Proto Handling | Production Requirement |
|---|---|---|

### Type Safety Gaps
- [Location] — [gap]

### Security / Compliance Gaps
- [Gap or "None identified"]

### Hardcoded Values
| Value | Location | Should Become |
|---|---|---|

---
## Part 4: Code Salvage Assessment (Agent-Produced)

| Component | Location | Quality | Recommendation | Notes |
|---|---|---|---|---|
| [name] | [file(s)] | [proto-only/salvageable/solid] | [discard/rewrite/keep+tests/keep] | |

**Summary:** Keep with tests: [N]  |  Rewrite using proto as ref: [N]  |  Discard: [N]

---
## Part 5: Graduation Options (Agent-Produced, Human-Decided)

### Option A: DISCARD
Appropriate if: throwaway conditions triggered, acceptance not reached,
or code value doesn't justify productionizing.
What happens: proto archived, learning captured, no L4 tasks created.

### Option B: Quick Mode
Appropriate if: essentially single-file, mostly clean, minimal gaps.
Estimated: [N] tasks | [N] tokens | [N hours] gap closure

### Option C: Standard Pipeline
Appropriate if: 2-5 file changes, established patterns, moderate gaps.
Estimated: [N] tasks | [N] tokens | L3: [brief description]

### Option D: Full Pipeline
Appropriate if: significant capability, substantial gaps, proto is design reference.
Estimated: [N] tasks across [N] waves | [N] tokens | [N] L3 specs | L2 update: Y/N

### Option E: Architecture Review First
Appropriate if: proto revealed architectural implications requiring L2 update.
Architectural implications: [list]
Next step: Scope Skill session to update L2 before decomposition.

---
## Part 6: Human Decision

### Decision
[ ] DISCARD — reasoning: ___
[ ] GRADUATE — Quick Mode
[ ] GRADUATE — Standard Pipeline
[ ] GRADUATE — Full Pipeline
[ ] GRADUATE — Architecture Review First
[ ] RETURN TO PROTO — additional exploration needed: ___

### Decision Rationale
[2-3 sentences — captured for project history]

### Knowledge That Survives (even if discarding)
- [Learning that informs future decisions]
- [Learning 2]

### If Graduating: Fresh Spec Instructions
> L4 task specs are written FRESH. Proto is reference only.
> Invoke Decompose Skill (Skill 07) with this eval as input.

Reference material: `proto/[name]/REPORT.md`
Components worth keeping: [from Part 4]
Design decisions validated: [from Part 1]
Patterns to follow: [from Part 3]

---
## Part 7: Token Accounting (Auto-populated by Cost Tracker)

| Category | Tokens | Cost |
|---|---|---|
| Proto execution | [N] | $[N] |
| Graduation eval | [N] | $[N] |
| **Proto total** | **[N]** | **$[N]** |
| Est. project tokens (if graduating) | [N] | $[N] |
| **Proto ROI** | proto_cost / project_savings if right direction | [ratio] |

---
## Completion Checklist
- [ ] Part 1: findings specific and honest
- [ ] Part 2: all throwaway conditions checked with evidence
- [ ] Part 3: all gap categories addressed (N/A acceptable)
- [ ] Part 4: every proto component assessed
- [ ] Part 5: all applicable options estimated
- [ ] Part 6: human decision recorded with rationale
- [ ] Part 7: token accounting complete

---
*Graduation Eval Gate | SDDF v0.4.0*
*Archive to: .sddf/graduations/[name]-[date].md*
EOF

# ── Weight Guide ──────────────────────────────────────────────────────────────
cat > .sddf/WEIGHT-GUIDE.md << 'EOF'
# SDDF Task Weight Classification Guide

## Decision Tree
```
Is this a new feature or architectural change? → YES → Heavy
Does it touch more than 3 files? → YES → Heavy
Does it introduce a new pattern or integration? → YES → Heavy
Does it involve agent decision logic or autonomous behavior? → YES → Heavy

Is it a well-understood change following existing patterns?
  → YES, 2-5 files → Standard
  → YES, 1 file → Quick

Is it a bug fix with known, verified root cause? → YES → Quick
Is it a config or documentation change? → YES → Quick
```

## Rules

- When in doubt, classify heavier
- First-time patterns = Heavy (even if one file)
- MCP/REST integration = Standard or Heavy (never Quick)
- Agent decision logic = Heavy always
- Engineer must justify any downgrade in classification

## Process per Weight

| Weight | L-Docs Required | R-G-F | Wave Plan | Review Gates |
|---|---|---|---|---|
| Heavy | L1 + L2 + L3 + L4 | Enforced (3 calls) | Required | 3 gates |
| Standard | Lightweight L3 + L4 | Enforced (3 calls) | Only if 3+ tasks | 2 gates |
| Quick | L4 only | Compressed (1 call) | Never | 1 gate |
| Proto Spike | Proto spec only | Not enforced | Never | Grad eval only |
| Proto Scaffold | Proto spec only | Encouraged | Never | Grad eval only |
EOF

echo ""
echo "✅ Part 2 complete — all 12 templates written"
echo "   Next: run sddf-setup-part3.sh (adapters + modes)"