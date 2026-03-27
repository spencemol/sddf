# SDDF — Spec-Driven Development Framework
## Overview & Usage Guide

**Version:** 0.4.0
**Last Updated:** 2026-03-26

---

## What Is SDDF?

SDDF is a vendor-agnostic, cost-optimized methodology for AI-assisted software
development. The core thesis: **the specification is the durable asset, not the
agent.** Precise, layered specs let you swap AI tools freely while keeping costs
predictable and output quality high.

Designed for:
- Enterprise engineering teams with existing systems
- Greenfield microservices integrating via MCP or REST
- Autonomous agent systems requiring rigorous testing
- Workflow-oriented agent pipelines with human-in-the-loop gates
- Teams evaluating or switching between AI coding tools

---

## How SDDF Compares

### vs. Superpowers (BMAD Method)
Superpowers provides rich persona-based agents and a large template library.
SDDF borrows: persona framing per skill, ready-made templates, pre-flight
checklists. SDDF diverges: Superpowers loads 20-30K tokens of system
instructions before any task, is coupled to specific tools, and conflates
specification with execution. SDDF treats token budgeting as first-class.

### vs. GSD (Get Shit Done)
GSD is lightweight and optimizes for solo developer velocity.
SDDF borrows: the fast-path concept (Quick Mode). SDDF diverges: GSD
doesn't capture rationale, enforce testing discipline, budget tokens, or
scale to teams. SDDF's Quick Mode gives you GSD speed within a rigorous frame.

### vs. ContextHub / Automated Context Tools
SDDF borrows: automated context generation for Codebase Context and Pattern
Library skills. SDDF diverges: use automated tools to *generate* context
summaries, then curate them down to minimum viable context per task. Never
feed raw auto-generated context directly to agents.

---

## The Spec Stack
```
L1: Project Charter      → Why we are building this     (human, written once)
L2: Architecture Doc     → How the system is shaped     (human, per service)
L3: Feature Spec         → What exactly we are building (human, per feature)
L4: Task Spec            → What the agent executes      (human-authored, agent-consumed)
L5: Agent Configuration  → How the agent behaves        (tool-specific adapter)
```

L1–L3 are for humans. L4–L5 are for agents.
The L3→L4 decomposition boundary is where most projects fail.

---

## Development Modes

**Rapid Prototyping Mode** — agent-driven, learning-optimized
- Vibe sub-mode: no spec, maximum agent autonomy, disposable output
- Scaffold sub-mode: light spec, working demonstration, expect to rewrite
- All proto output is disposable unless it passes the Graduation Eval Gate

**Project-Based Mode** — review-gated, production-intended
- Quick: single-file, bug fix, abbreviated L4, compressed R-G-F
- Standard: 2-5 files, established pattern, lightweight L3 + L4
- Full: new capability, complete L1–L4 pipeline, wave-based execution
- Architecture: system boundary change, L2 update + architect sign-off required

---

## Execution Model: Red-Green-Refactor

Every task follows a TDD cycle:
1. **Red** — agent writes failing tests from L4 spec. Must fail.
2. **Green** — agent writes minimum implementation to pass. No gold-plating.
3. **Refactor** — agent cleans up with green safety net. Tests must stay green.

Three focused agent calls. Each has narrow context and high success rate.
Even Quick Mode tasks follow R-G-F — only the upstream docs are abbreviated.

---

## Parallelism: Wave-Based Execution

Tasks are grouped by dependency depth. Tasks within a wave run simultaneously.
```
Wave 0 (Foundation)   → models, schemas, interfaces      [parallel]
Wave 1 (Domain)       → services, business logic         [parallel]
Wave 2 (API)          → endpoints, controllers           [parallel]
Wave 3 (Integration)  → MCP tools, REST clients          [parallel]
Wave 4 (Verification) → integration + E2E tests          [sequential]
```

Wave gates enforce composition correctness after each wave.

---

## Skill Architecture (3 Tiers, 14 Skills)

### Tier 1: Orchestration
| Skill | Persona | Purpose |
|---|---|---|
| 01 Project Orchestrator | Calm project lead | State, gates, wave dispatch, weight classification |
| 02 Init / Bootstrap | Efficient scaffolder | New project setup, directory structure, stubs |
| 03 Eval / QA Gate | Skeptical reviewer | Adversarial quality checks at every gate |
| 04 Token Cost Tracker | Meticulous accountant | Cost logging, analysis, cross-tool comparison |

### Tier 2: Phase Skills
| Skill | Persona | Phase | Output |
|---|---|---|---|
| 05 Scope | Strategic thinker | Phase 1 | L1 Charter + L2 Architecture Doc |
| 06 Spec | Relentless interrogator | Phase 2 | L3 Feature Specs |
| 07 Decompose | Atomic architect | Phase 3 | L4 Task Specs + Wave Plan |
| 08 Execute | Disciplined builder | Phase 4 | Code via R-G-F + adapters |
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
Heavy   → Full pipeline (L1–L4 + waves) — new features, integrations, agent logic
Standard → Abbreviated (light L3 + L4) — established patterns, 2-5 files
Quick   → Fast path (L4 only) — single file, bug fix, known pattern
```

When in doubt, classify heavier. First-time patterns are always Heavy.
Integration work is always Standard or Heavy. Agent decision logic is always Heavy.

---

## File Structure
```
.sddf/
├── README.md                       ← This file
├── skills/                         ← 14 skill files (vendor-neutral)
├── templates/                      ← L1–L5 + proto + graduation templates
├── adapters/                       ← Tool-specific L5 adapters
├── modes/                          ← Mode guides (proto + project)
├── examples/                       ← Worked examples
└── graduations/                    ← Archived graduation eval reports
```

---

## Changelog

| Version | Date | Changes |
|---|---|---|
| 0.1.0 | 2026-03-26 | Initial framework |
| 0.2.0 | 2026-03-26 | R-G-F execution model, wave parallelism, 14 skills |
| 0.3.0 | 2026-03-26 | Task weight classification, persona framing, competitive positioning |
| 0.4.0 | 2026-03-26 | Rapid Prototyping Mode, Graduation Eval Gate, all templates, adapters |
