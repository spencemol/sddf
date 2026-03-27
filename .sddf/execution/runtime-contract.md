# SDDF Runtime Contract
**Version:** 0.5.0  
**Last Updated:** 2026-03-27  
**Status:** Normative (v1)

## Purpose
SDDF separates:
- **Adapter behavior**: how a specific agent tool behaves (Claude Code CLI, Codex CLI)
- **Runtime orchestration**: how work is dispatched, isolated, reviewed, and promoted

This contract defines runtime semantics for v1.

## Core Rule: Coordination Is Artifact-Based
SDDF agents do not use live peer-to-peer messaging for execution coordination.
Coordination must flow through artifacts:
- L4 task specs
- dispatch packets
- status manifests
- handoff notes
- validation reports
- review gates

If two agents need to coordinate, they do so by writing and reading artifacts.

## Runtime Terms
- **runtime**: platform that manages workspaces, threads, and workflow controls (Conductor in v1)
- **backend**: agent engine used in a thread (Claude Code CLI, Codex CLI)
- **workspace**: isolated filesystem context for a task lane
- **owner thread**: the only thread allowed to mutate repo state in a workspace
- **advisor/reviewer thread**: read-heavy support thread in same workspace; no mutation ownership
- **wave gate**: quality gate between dependency waves
- **task gate**: per-task R-G-F and boundary compliance gate

## Ownership And Mutation Rules
1. Exactly one owner thread per workspace by default.
2. Owner thread is the only mutation authority unless explicitly promoted.
3. Advisor/reviewer threads may inspect, propose, and annotate, but should not be default mutation paths.
4. Promotion of a non-owner thread to owner must be explicit and logged in artifacts.

## Workspace Lifecycle
1. **Create** workspace from repository baseline.
2. **Setup** via runtime setup script (dependencies, env links, bootstrap).
3. **Execute** assigned task phase in owner thread.
4. **Validate** task gate.
5. **Handoff** via artifacts (not chat memory).
6. **Gate** at wave boundary where required.
7. **Archive** workspace and run archive script.

## Backend Selection Policy
SDDF does not hardcode one model matrix for all teams.
Runtime manifests select a backend and model strategy per workload.

Recommended pattern classes:
- Reasoning-heavy planning/review: Opus-class or GPT-5.x reasoning models
- Implementation/testing: Sonnet-class or Codex-class implementation models

Project teams may override strategy by policy.

## Skill Portability Contract
Use **skill bundles** as the portable layer across backends:
- Claude-backed threads: map bundle to native skills and optional subagents
- Codex-backed threads: inject curated bundle context into task input

Behavioral intent must remain equivalent across backends even when mechanics differ.

## Checkpoints And History
- Runtime checkpoints are safety tooling, not the source of truth.
- In Conductor, checkpoint semantics are runtime-specific and currently Claude-only.
- SDDF source-of-truth remains git history + SDDF artifacts.

## Approval And Review Rules
- Task gate required for all tasks.
- Wave gate required for Full/Architecture modes.
- Human approval required for:
  - architecture boundary changes
  - runtime policy changes
  - failed wave-gate recovery plans

## Runtime Scope In v1
First-class runtime: Conductor.  
First-class backends inside Conductor:
- Claude Code CLI
- Codex CLI

Research-only watchlist:
- Codex App (not part of v1 implementation semantics)
- Google Antigravity
