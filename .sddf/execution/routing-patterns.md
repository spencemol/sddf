# SDDF Routing Patterns
**Version:** 0.5.0  
**Last Updated:** 2026-03-27  
**Status:** Advisory (non-normative)

This catalog captures useful routing patterns for Conductor lanes.
It is guidance, not a mandated default matrix.

## Pattern A: Reasoning-Heavy Planning And Review
Use when:
- decomposition quality is the main risk
- architecture or integration decisions are ambiguous
- review quality is more important than raw throughput

Common strategy:
- backend: either Claude Code CLI or Codex CLI
- models: Opus-class or GPT-5.4-class reasoning models
- lane types: scope/spec/decompose/eval/validate

## Pattern B: Throughput Implementation And Testing
Use when:
- task boundaries are clear and L4 quality is high
- the work is primarily implementation and test execution

Common strategy:
- backend: either Claude Code CLI or Codex CLI
- models: Sonnet-class or GPT-5.3 Codex-class implementation models
- lane types: execute Red/Green/Refactor + test remediation

## Pattern C: Mixed Wave Strategy
Use when:
- same wave has heterogeneous task complexity

Common strategy:
- reasoning-heavy tasks route to Pattern A
- mechanical tasks route to Pattern B
- all lanes still publish equivalent SDDF artifacts

## Pattern D: Review Isolation
Use when:
- you need independent review judgment from implementation context

Common strategy:
- owner thread implements in workspace
- reviewer thread audits using artifacts and diff
- owner remains sole mutation authority unless promoted

## Governance Notes
- Record selected pattern per lane in dispatch packet.
- Allow per-project overrides in runtime manifest.
- Favor consistent pattern use within a wave unless strong reason to split.
