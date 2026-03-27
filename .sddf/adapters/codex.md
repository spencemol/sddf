# SDDF Adapter: Codex
**Tool:** OpenAI Codex (Codex CLI, OpenAI API with code execution)
**L5 source:** .sddf/agent-config.md
**Adapter version:** 0.5.0

## Overview
Codex is a first-class SDDF backend in v1 when used through runtime orchestration
(typically Conductor). This adapter covers Codex CLI execution behavior.

Key properties:
- no native `/project:` skill invocation equivalent
- SDDF skill behavior provided through curated skill-bundle context injection
- file-boundary controls require adapter/runtime guardrails outside Claude-native enforcement

This guide is for Codex CLI. Codex App is watchlist-only in v1.

## File Layout
```
project-root/
├── .sddf/
│   ├── agent-config.md              ← L5 source (vendor-neutral)
│   └── codex-system-prompt.md       ← Generated from agent-config.md
└── scripts/
    ├── codex-run-phase.sh
    ├── codex-execute.py
    ├── codex-writeback.py           ← MANDATORY file boundary enforcement
    ├── codex-skill.py
    └── codex-cost-log.py
```

## Runtime-Aware Usage (Conductor)
Codex-backed lanes should follow runtime ownership defaults:
- one owner thread per workspace
- advisor/reviewer threads may assist, but owner controls mutations
- cross-lane handoff happens through SDDF artifacts

Backend selection (Codex vs Claude) is lane-level policy in runtime manifest.

## System Instruction Generation
Generate .sddf/codex-system-prompt.md from agent-config.md.
Target: under 1,000 tokens. Include all Hard Rules verbatim.
Add session protocol:
```
## Session Protocol
Each session executes ONE phase of ONE task.
Phase (Red/Green/Refactor) is specified in task input.
Confirm phase completion and test results before ending session.
```

## Task Input Format

Red Phase:
```
## Task Input: Red Phase
Task: [name]  Phase: RED — Write failing tests only
---
[L4 Red Phase section verbatim]
---
Test framework reference: [Pattern Library test setup]
After writing: run `[test command] --run [test file]`
All tests MUST fail. Report failure output. If any pass: STOP.
```

Green Phase:
```
## Task Input: Green Phase
Task: [name]  Phase: GREEN — Minimum implementation
---
[L4 Green Phase section verbatim]
Tests to pass: [test file from Red phase]
Reference: [relevant pattern]
---
After implementing: run `[test command] --run [test file]`
All tests MUST pass. No test file modifications. Max 2 attempts. If failing: STOP.
```

Refactor Phase:
```
## Task Input: Refactor Phase
Task: [name]  Phase: REFACTOR — Clean up with green safety net
---
[L4 Refactor Phase section]
Current implementation: [paste from Green]
Patterns to align: [Pattern Library entries]
---
After refactoring: run `[test command]`. All tests MUST pass.
If any break: REVERT and report.
```

Quick Mode (single session):
```
## Task Input: Quick Mode (Compressed R-G-F)
[Quick Mode L4 spec verbatim]

Execute in sequence:
Phase 1 — Red: Write test. Run it. Confirm FAILS. Report.
Phase 2 — Green: Minimal change to pass. Do not modify test. Confirm PASS.
Phase 3 — Refactor: SKIP.
Final: run full suite. All existing tests must still pass.
```

## Writeback Filter (MANDATORY)
Codex file boundaries are prompt-level only. This script is the
Codex equivalent of Claude Code's `--allowedTools`. Must be present.
```python
# scripts/codex-writeback.py
def write_back(output_files, task_spec_path):
    allowed = parse_files_to_modify(task_spec_path)
    for file_path, content in output_files.items():
        if file_path not in allowed:
            print(f"BOUNDARY VIOLATION: {file_path} not in Files to Modify — skipping")
            continue
        with open(file_path, 'w') as f:
            f.write(content)
```

## Context Assembly Token Limits
```python
PHASE_TOKEN_LIMITS = {
    "red":     6_000,
    "green":  10_000,
    "refactor": 6_000,
    "quick":   4_000,
}
```

## Skill Invocation
Load skill-bundle content as curated context alongside task input:
```python
# scripts/codex-skill.py
messages = [
    {"role": "system",  "content": load(".sddf/codex-system-prompt.md")},
    {"role": "user",    "content": skill_bundle_content + "\n\n---\n\n" + context + "\n\n" + instruction}
]
```

Bundle schema reference:
- `.sddf/templates/skill-bundle.md`

## Proto Mode Override
Append to task input (do not modify system prompt — proto is session-specific):
```
## PROTO MODE ACTIVE
The following rules REPLACE Hard Rules for this session only:
- Create files in proto/[spike-name]/ freely
- Suggest new packages via comments: # NEEDS: package@version
- Pattern compliance optional — deviate with explicit comment
- Coverage not enforced
- Mark shortcuts: # PROTO-ONLY: [what production needs]
Confirm proto mode active before relaxing any constraint.
```

## Model Selection
| Phase / Skill | Model |
|---|---|
| Red phase | gpt-4o-mini |
| Green phase | gpt-4o or o4-mini |
| Refactor phase | gpt-4o-mini |
| Decompose Skill | o3 or gpt-4o |
| Spec Skill | gpt-4o-mini |
| Eval / Validate | gpt-4o |

Treat this as a conservative adapter default.
Teams may use newer Codex-class model families per runtime policy.

## Cost Logging
```python
# Parse response.usage after each call
entry = {
    "timestamp": datetime.utcnow().isoformat(),
    "task_id": task_id, "phase": phase, "model": model,
    "input_tokens": usage.prompt_tokens,
    "output_tokens": usage.completion_tokens,
}
# Append to .sddf/cost-log.jsonl
```

## vs. Claude Code: Key Differences
| Concern | Claude Code | Codex |
|---|---|---|
| Skill invocation | Native (/project:name) | Context file injection |
| File boundaries | API-enforced | Prompt-enforced + writeback filter |
| R-G-F phases | --no-continue flag | Separate API calls |
| Test execution | Agent runs tests | Orchestration layer runs tests |
| Boundary strength | Strong (API-level) | Moderate (requires writeback filter) |
| Subagents | Native support | No direct equivalent in SDDF v1 |

## Setup Checklist
- [ ] .sddf/codex-system-prompt.md generated from agent-config.md
- [ ] System prompt under 1,000 tokens
- [ ] scripts/codex-writeback.py implemented and tested
- [ ] scripts/codex-execute.py implemented
- [ ] scripts/codex-skill.py implemented
- [ ] scripts/codex-cost-log.py writing to .sddf/cost-log.jsonl
- [ ] PHASE_TOKEN_LIMITS set
- [ ] Proto mode override block tested
- [ ] .gitignore: proto/ added, /tmp/codex-output/ excluded
- [ ] runtime manifest includes Codex lane policy and ownership defaults
- [ ] skill-bundle mapping documented for Codex lanes
- [ ] dispatch packets record backend/model strategy for each Codex lane

---
*SDDF Codex Adapter | v0.5.0 — source: .sddf/agent-config.md*
