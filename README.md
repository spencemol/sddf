# SDDF

Spec-Driven Development Framework for teams using coding agents in real projects.

SDDF is built around one idea: the spec stack should survive tool churn.
Agents, models, and runtimes can change. Your requirements, task contracts, and
review gates should not.

## Why SDDF
- Spec-first, execution-safe workflow from charter to task-level contracts.
- Explicit split between backend adapters and runtime orchestration.
- Artifact-based coordination for parallel agent work (not chat-memory coupling).
- Fast path for small fixes (`Quick`) without losing verification discipline.

## How SDDF Differs
| Framework | Strength | SDDF Differentiator |
|---|---|---|
| Superpowers | Rich persona/skill ergonomics | SDDF centers durable spec artifacts and stricter phase/gate discipline across tools |
| GSD | Very fast solo execution loops | SDDF adds stronger multi-phase traceability, weight classes, and review gates for team reliability |
| GitHub Spec Kit | Excellent Spec-Driven bootstrap toolkit/CLI | SDDF emphasizes runtime orchestration contracts (workspaces, owner threads, dispatch packets, wave gates) for multi-agent execution control |

This is not an anti-tool stance. SDDF is designed to compose with those ecosystems.

## Quick Setup
### 1) Add SDDF to your project
Copy `.sddf/` into your repository root.

```bash
cp -R /path/to/sddf/.sddf /path/to/your-project/
```

### 2) Choose runtime + backends
Default v1 runtime model:
- Runtime: `Conductor`
- Backends: `Claude Code CLI` and `Codex CLI`

Start from templates:
- `.sddf/templates/runtime-manifest.md`
- `.sddf/templates/conductor.json`
- `.sddf/templates/dispatch-packet.md`
- `.sddf/templates/skill-bundle.md`

### 3) If using Claude Code, sync SDDF skills
```bash
mkdir -p .claude/skills
cp .sddf/skills/*.md .claude/skills/
```

### 4) Pick task weight
- `Quick`: one-file style change, compressed R-G-F
- `Standard`: 2-5 files, full R-G-F
- `Full/Architecture`: wave-based multi-task flow with gates

### 5) Run your first task through SDDF
Use:
- `.sddf/modes/project-based.md`
- `.sddf/WEIGHT-GUIDE.md`
- `.sddf/templates/task-spec-quick.md` or `.sddf/templates/task-spec-full.md`

## Agent Managers And Coding Agents
### First-class in current SDDF
- Agent manager/runtime: `Conductor` (`.sddf/adapters/conductor.md`)
- Backends: `Claude Code CLI` and `Codex CLI`

### Additional adapter paths
- `Cursor` and `Gemini` adapters exist as stubs for future hardening.

### Watchlist (research-only)
- `Codex App`
- `Google Antigravity`

## High-Level Flows
### A) Project-Based, review-driven flow (Standard/Full)
```text
SCOPE -> SPEC -> DECOMPOSE -> EXECUTE -> VALIDATE -> SHIP
          |        |            |          |
          |        |            |          +-- Task/Wave gates
          |        |            +-- R-G-F with owner-thread mutation policy
          |        +-- L4 tasks + dispatch packets + lane ownership
          +-- L3 intent + constraints
```

In `Full`, tasks execute by waves in parallel workspaces, then pass wave gates
before the next wave starts.

### B) Quick mode flow (single-task fast path)
```text
DECOMPOSE (Quick checks) -> EXECUTE (compressed R-G-F) -> VALIDATE
```

Quick parallelism means multiple independent Quick tasks can run at the same
time in separate workspaces. It does not mean one Quick task is edited by
multiple mutating agents at once.

## Where To Go Next
- Framework overview: `.sddf/README.md`
- Runtime contract: `.sddf/execution/runtime-contract.md`
- Dispatch model: `.sddf/execution/dispatch-model.md`
- Capability matrix: `.sddf/execution/capability-matrix.md`
- Examples: `.sddf/examples/`
