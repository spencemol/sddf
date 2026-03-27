# SDDF Runtime Guide: Conductor
**Runtime:** Conductor  
**Role in SDDF:** Execution runtime orchestration (not L5 adapter replacement)  
**Version:** 0.5.0

## Positioning
Conductor is the first-class SDDF runtime in v1.
It manages workspace/thread orchestration while SDDF artifacts remain source-of-truth.

Backends supported in this runtime guide:
- Claude Code CLI
- Codex CLI

## Runtime Defaults
1. One workspace per parallel task lane
2. One owner chat per workspace
3. Optional advisor/reviewer chats allowed, but owner owns mutations
4. Checkpoints are optional safety tooling, not source-of-truth state

## `conductor.json` Baseline
Start from `.sddf/templates/conductor.json`.

Expected script contracts:
- `setup`: workspace bootstrap (symlink/copy ignored config, install deps, init env)
- `run`: project run/test command for the workspace
- `archive`: cleanup ephemeral workspace artifacts after merge/close

## Workspace And Branch Policy
- Workspace naming: `<feature>-<task-id>`
- Branch naming: `sddf/<feature>/<task-id>`
- One task lane per workspace unless explicitly bundled by orchestrator decision

## Thread Role Policy
- **Owner thread**: writes code and runs mutation commands
- **Advisor thread**: helps with analysis/planning/review, not mutation owner
- **Reviewer thread**: audits output and gates promotion

Any ownership transfer must be explicit and reflected in dispatch packet/handoff notes.

## Backend Use Inside Conductor
Conductor threads may run different backends by lane:
- `claude-code-cli` for native SDDF skills and subagent support
- `codex-cli` for strong implementation/testing lanes where skill bundles are injected

Use runtime manifest + dispatch packet to record backend/model strategy choices.

## Skill Continuity Across Backends
Use SDDF skill bundles (`.sddf/templates/skill-bundle.md`):
- Claude threads map bundle to native `/project:` skills and hooks
- Codex threads inject curated bundle context

Goal: equivalent task behavior despite backend differences.

## Checkpoints
Checkpoints can improve safety during risky edits.
For SDDF:
- optional runtime aid
- never a substitute for git commit history and SDDF artifacts

## Provider And Account Controls
Conductor env/provider configuration may change:
- which account is billed
- which model/provider is active
- which credentials a workspace thread uses

Record provider assumptions in runtime manifest so model/token spreading is intentional.

## Review Gate Flow
Recommended review flow:
1. Owner thread completes task gate evidence
2. Reviewer thread audits diff + artifacts
3. Human approves task/wave gate decisions
4. Promote lane output to integration branch

## Out Of Scope For This Guide
- Codex App runtime mapping (watchlist only in v1)
- Antigravity runtime mapping (watchlist only in v1)
