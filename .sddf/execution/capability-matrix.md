# SDDF Runtime Capability Matrix
**Version:** 0.5.0  
**Last Updated:** 2026-03-27  
**Status:** Normative reference for adapter/runtime decisions

## Legend
- **Native**: built-in capability
- **Adapted**: available through SDDF adapter logic
- **Runtime**: provided by runtime platform behavior
- **N/A**: not applicable

## Core Capabilities
| Capability | Claude Code CLI | Codex CLI | Conductor Runtime |
|---|---|---|---|
| Native skill system | Native (`.claude/skills`) | Adapted (context injection) | Runtime-agnostic |
| Skill-bundle portability target | Native mapping | Injected mapping | Runtime selection + continuity |
| Subagents | Native | No direct equivalent in SDDF v1 | Runtime can host thread-level parallelism |
| File boundary enforcement | Strong (`--allowedTools`) | Adapted (writeback + policy) | Runtime workspace boundaries |
| Workspace isolation | Via local tooling/worktrees | Via local tooling/worktrees | Native multi-workspace orchestration |
| Multi-thread execution view | CLI/session based | CLI/session based | Native chat/thread management |
| Setup/run/archive scripts | External | External | Native `conductor.json` script hooks |
| Checkpoints | Not native in CLI itself | Not native in CLI itself | Runtime feature (currently Claude-only) |
| Provider/env routing controls | CLI + env | CLI + env | Runtime-level provider/env controls |
| Diff/review surface | Git + external tools | Git + external tools | Runtime review UI + workflow |

## Interpretation Rules
1. SDDF semantics are portable; backend mechanics differ.
2. Conductor runtime features do not replace SDDF artifacts.
3. Missing native backend features are compensated by adapter controls.
4. Checkpoints are optional safeguards, never source-of-truth state.

## Baseline Sources
- Conductor docs (core scripts, checkpoints, workspaces, providers, Codex tip)
- Claude Code docs (subagents, hooks)
- OpenAI Codex docs/help overview
- Antigravity codelab (watchlist baseline only)
