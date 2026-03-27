# SDDF — Spec-Driven Development Framework
## Overview & Usage Guide

**Version:** 0.5.0  
**Last Updated:** 2026-03-27

---

## What Is SDDF?
SDDF is a vendor-agnostic methodology for AI-assisted software development.
Its core thesis remains: **the specification is the durable asset, not the
agent.**

In v0.5.0 SDDF now treats execution as two separate concerns:
- **Agent adapters**: tool-specific behavior and constraints (L5 translation)
- **Runtime orchestration**: dispatch, workspaces, thread roles, gates, and reviews

---

## The SDDF Stack
```
L1: Project Charter      → Why we are building this
L2: Architecture Doc     → How the system is shaped
L3: Feature Spec         → What exactly we are building
L4: Task Spec            → What the agent executes
L5: Agent Configuration  → How each backend should behave
R1: Runtime Contract     → How work is orchestrated across lanes/workspaces
```

L1–L3 are primarily human planning layers.  
L4–L5 describe task execution intent and tool behavior.  
R1 defines runtime coordination semantics.

---

## Development Modes
**Rapid Prototyping Mode** (learning-first):
- Vibe and Scaffold tracks
- output is disposable unless graduated

**Project-Based Mode** (production-intended):
- Quick: single-file style tasks, compressed R-G-F
- Standard: 2-5 files, full R-G-F
- Full: wave-based multi-task execution with wave gates
- Architecture: Full + mandatory architecture review

---

## Execution Semantics
### Red-Green-Refactor
All project tasks follow R-G-F intent:
1. Red: failing tests first
2. Green: minimal implementation
3. Refactor: cleanup with green safety net (may be skipped by rule in Quick)

### Parallelism
- Full/Architecture parallelism is wave-based.
- Standard is usually single-lane per task.
- Quick remains single-task compressed execution.
- **Parallel Quick means multiple independent Quick tasks in separate workspaces.**
  It does not mean multi-agent editing of one Quick task.

### Coordination Rule
SDDF coordination is artifact-based:
- task specs, dispatch packets, status files, validation reports, and gate outputs
- no live peer-to-peer agent comms as execution source-of-truth

---

## Runtime Baseline (v1)
First-class runtime target:
- Conductor

First-class backends inside that runtime:
- Claude Code CLI
- Codex CLI

Research/watchlist only:
- Codex App
- Google Antigravity

See `.sddf/execution/runtime-contract.md`.

---

## Skill Architecture (3 Tiers, 14 Skills)
### Tier 1: Orchestration
| Skill | Persona | Purpose |
|---|---|---|
| 01 Project Orchestrator | Calm project lead | State, gates, dispatch coordination, weight classification |
| 02 Init / Bootstrap | Efficient scaffolder | New project setup, directory structure, stubs |
| 03 Eval / QA Gate | Skeptical reviewer | Adversarial quality checks at every gate |
| 04 Token Cost Tracker | Meticulous accountant | Cost logging, analysis, cross-tool comparison |

### Tier 2: Phase Skills
| Skill | Persona | Phase | Output |
|---|---|---|---|
| 05 Scope | Strategic thinker | Phase 1 | L1 Charter + L2 Architecture Doc |
| 06 Spec | Relentless interrogator | Phase 2 | L3 Feature Specs |
| 07 Decompose | Atomic architect | Phase 3 | L4 Task Specs + wave intent |
| 08 Execute | Disciplined builder | Phase 4 | R-G-F execution packages |
| 09 Validate | Quality gate | Phase 5 | Pass/fail report + remediation |

### Tier 3: Infrastructure
| Skill | Persona | Purpose |
|---|---|---|
| 10 Integration | Integration specialist | MCP/REST contract catalog |
| 11 Codebase Context | Codebase librarian | Token-efficient architecture summaries |
| 12 Pattern Library | Standards keeper | Canonical patterns referenced by name |
| 13 Domain Glossary | Domain expert | Precise business term definitions |
| 14 Ship / Deploy | Release engineer | CI/CD, feature flags, deployment |

---

## Task Weight Classification
```
Heavy/Full   → Full pipeline + wave orchestration
Standard     → Lightweight spec + full R-G-F
Quick        → L4 only + compressed R-G-F
```

When in doubt, classify heavier.

---

## File Structure
```
.sddf/
├── README.md
├── skills/                         ← 14 vendor-neutral skills
├── templates/                      ← L1-L5 + runtime templates
├── adapters/                       ← tool/runtime guides
├── execution/                      ← runtime contract + routing + matrix
├── modes/                          ← mode guides
├── examples/                       ← scenario examples
└── graduations/                    ← archived graduation reports
```

---

## External Capability Baselines
Runtime and adapter guidance is aligned to current official docs:
- Conductor docs: https://docs.conductor.build/
- Conductor workspaces: https://docs.conductor.build/first-workspace
- Conductor scripts: https://docs.conductor.build/core/scripts
- Conductor checkpoints: https://docs.conductor.build/core/checkpoints
- Conductor Codex tip: https://docs.conductor.build/tips/codex
- Conductor providers/env: https://docs.conductor.build/guides/providers
- Claude Code subagents: https://docs.claude.com/en/docs/claude-code/subagents
- Claude Code hooks: https://docs.claude.com/en/docs/claude-code/hooks
- OpenAI Codex overview: https://help.openai.com/en/articles/11369540/
- Google Antigravity codelab: https://codelabs.developers.google.com/getting-started-google-antigravity?hl=ko

---

## Changelog
| Version | Date | Changes |
|---|---|---|
| 0.1.0 | 2026-03-26 | Initial framework |
| 0.2.0 | 2026-03-26 | R-G-F model, wave parallelism, 14 skills |
| 0.3.0 | 2026-03-26 | Weight classification, persona framing |
| 0.4.0 | 2026-03-26 | Rapid Proto mode, graduation gate, templates/adapters |
| 0.5.0 | 2026-03-27 | Runtime contract split, Conductor-first runtime docs, skill bundles, routing patterns |
