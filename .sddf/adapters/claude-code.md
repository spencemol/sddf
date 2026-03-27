# SDDF Adapter: Claude Code
**Tool:** Claude Code (Anthropic)
**L5 source:** .sddf/agent-config.md
**Adapter version:** 0.5.0

## Overview
Claude Code is the strongest native backend for SDDF skill execution.
In v0.5.0 it is treated as a backend that can run inside Conductor runtime lanes.

Key properties:
- native SDDF skill mapping through `.claude/skills/`
- strong file-boundary enforcement with `--allowedTools`
- optional subagents as intra-thread helpers

Runtime orchestration (workspaces, owner threads, review threads) is defined in:
- `.sddf/execution/runtime-contract.md`
- `.sddf/adapters/conductor.md`

## File Layout
```
project-root/
├── CLAUDE.md                    ← L5 config (generated from agent-config.md)
├── .claude/skills/              ← 14 SDDF skill files (synced from .sddf/skills/)
└── .sddf/agent-config.md        ← L5 source (vendor-neutral, edit here)
```

Sync command (run after any skill update):
```bash
cp .sddf/skills/*.md .claude/skills/
```

## CLAUDE.md Generation
Generate from agent-config.md. Map each section verbatim.
Hard Boundaries section → use ALL CAPS heading.
Add SDDF skills list at the end.
Target: under 1,000 tokens total.

Key additions beyond raw L5 content:
```
## SDDF Skills
This project uses SDDF. Skills are in .claude/skills/.
Invoke with /project:[skill-name].

Available:
- /project:sddf-07-decompose  — Break L3 into L4 task specs
- /project:sddf-08-execute    — Execute L4 via R-G-F cycle
- /project:sddf-09-validate   — Validate output against spec
- /project:sddf-03-eval       — Quality gate + graduation eval
- /project:sddf-05-scope      — Draft/review L1/L2
- /project:sddf-06-spec       — Draft/review L3
[etc.]
```

## Runtime-Aware Thread Usage (Conductor)
Use one owner chat per workspace by default.

When to use separate workspace threads:
- task has independent file boundaries
- task is wave-parallelizable
- task needs independent mutation ownership

When to use Claude subagents (same owner thread):
- bounded side analysis
- focused review/checking helpers
- non-owner decomposition of context-heavy reasoning

Subagents are helpers, not replacements for workspace-level parallel lanes.

## Hook Guidance
Recommended hook coverage:
- `SessionStart`: load workspace policy and skill bundle summary
- `PreToolUse`: enforce path boundary policy and disallowed command checks
- `PostToolUse`: write artifact snippets for traceability (tests run, changed files)
- subagent lifecycle hooks/events: ensure subagents inherit bundle constraints

## Phase Execution Commands (CLI-oriented)

Full pipeline task — Red phase:
```bash
claude --no-continue \
       --model claude-haiku-4-5 \
       --allowedTools "Edit(.sddf/tasks/[feature]/[task]-tests.[ext])" \
       --context .sddf/tasks/[feature]/[task].md \
       --context .sddf/agent-config.md \
       "Execute Red phase only. Write tests. Confirm they fail."
```

Full pipeline task — Green phase:
```bash
claude --no-continue \
       --model claude-sonnet-4-6 \
       --allowedTools "Edit(src/[specific-file].[ext])" \
       --context .sddf/tasks/[feature]/[task].md \
       --context [test-file-from-red] \
       --context [reference-files] \
       "Execute Green phase. Minimum implementation to pass Red tests."
```

Quick Mode (compressed, single call):
```bash
claude --no-continue \
       --model claude-haiku-4-5 \
       --allowedTools "Edit(src/[single-file].[ext])" \
       --context .sddf/tasks/quick/[task].md \
       --context .sddf/agent-config.md \
       "Execute Quick Mode R-G-F. Phase 1: write test, confirm fail.
        Phase 2: minimal change to pass. Phase 3: SKIP."
```

Proto spike:
```bash
claude --no-continue \
       --model claude-haiku-4-5 \
       --allowedTools "Edit(proto/[spike-name]/**)" \
       --context [filled-proto-spike-spec] \
       "Execute this proto spike. Proto Mode active — constraints relaxed."
```

## --allowedTools Mapping
| Task Spec Field | --allowedTools Pattern |
|---|---|
| src/services/X.ts (modify) | Edit(src/services/X.ts) |
| src/services/X.test.ts (modify) | Edit(src/services/X.test.ts) |
| src/services/Y.ts (reference) | Read(src/services/Y.ts) |
| proto spike | Edit(proto/[name]/**) |

NEVER use Edit(**) or Edit(src/**) for project-mode tasks.

## Model Selection
| Phase / Skill | Model |
|---|---|
| Red phase | claude-haiku-4-5 |
| Green phase | claude-sonnet-4-6 |
| Refactor phase | claude-haiku-4-5 |
| Decompose Skill | claude-opus-4-6 |
| Spec Skill | claude-haiku-4-5 |
| Eval / Validate | claude-sonnet-4-6 |
| Proto Vibe | claude-haiku-4-5 |
| Proto Scaffold | claude-sonnet-4-6 |

Cost impact: Haiku for Red + Refactor saves ~30-40% per task vs. Sonnet throughout.
Treat this table as an adapter pattern, not a framework-wide mandatory matrix.

## package.json Scripts
```json
{
  "scripts": {
    "sddf:decompose": "claude --model claude-opus-4-6 --skill sddf-07-decompose",
    "sddf:spec":      "claude --model claude-haiku-4-5 --skill sddf-06-spec",
    "sddf:scope":     "claude --model claude-sonnet-4-6 --skill sddf-05-scope",
    "sddf:eval":      "claude --model claude-sonnet-4-6 --skill sddf-03-eval",
    "sddf:validate":  "claude --model claude-sonnet-4-6 --skill sddf-09-validate",
    "sddf:status":    "claude --model claude-haiku-4-5 --skill sddf-01-orchestrator 'Report status'",
    "sddf:grad-eval": "claude --model claude-sonnet-4-6 --skill sddf-03-eval --context .sddf/templates/graduation-eval.md"
  }
}
```

## Key Behaviors to Know
- Skills are context, not system prompts. Hard Boundaries must be in CLAUDE.md,
  not only in skill files — skill files can be overridden more easily.
- --allowedTools is API-enforced (cannot be overridden by agent reasoning).
  Use it for all file boundary enforcement.
- Run each R-G-F phase with --no-continue for clean context windows
  and accurate token accounting.
- CLAUDE.md loads on every invocation — keep it under 1,000 tokens.
- In Conductor runtime, owner thread mutation policy still applies even with subagents.
- Checkpoints are optional runtime safety tools; git + SDDF artifacts stay source-of-truth.

## Skill Bundle Continuity
Claude-backed lanes should consume bundle definitions from:
- `.sddf/templates/skill-bundle.md`

Mapping approach:
1. map bundle role to native `/project:` skills
2. preload critical constraints in session/hook startup
3. require subagents to inherit same bundle expectations

## Setup Checklist
- [ ] CLAUDE.md generated from .sddf/agent-config.md
- [ ] .claude/skills/ synced with all 14 skill files
- [ ] package.json scripts added
- [ ] CLAUDE.md under 1,000 tokens
- [ ] .gitignore: proto/ added, .claude/ kept in source control
- [ ] runtime manifest defines owner thread policy for Claude-backed lanes
- [ ] hook policy documented for SessionStart/PreToolUse/PostToolUse
- [ ] skill bundle mapping documented for Claude lanes

---
*SDDF Claude Code Adapter | v0.5.0 — source: .sddf/agent-config.md*
