#!/usr/bin/env bash
set -euo pipefail
echo "🔧 SDDF Setup — Part 3: Adapters + Modes + Init files"

# ── Adapter: Claude Code ──────────────────────────────────────────────────────
cat > .sddf/adapters/claude-code.md << 'EOF'
# SDDF Adapter: Claude Code
**Tool:** Claude Code (Anthropic)
**L5 source:** .sddf/agent-config.md
**Adapter version:** 0.4.0

## Overview
Claude Code is the closest native fit for SDDF. Skills map directly to
.claude/skills/, --allowedTools enforces file boundaries, and CLAUDE.md
maps directly to the L5 config. Adapter overhead is minimal.

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

## Phase Execution Commands

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

## Setup Checklist
- [ ] CLAUDE.md generated from .sddf/agent-config.md
- [ ] .claude/skills/ synced with all 14 skill files
- [ ] package.json scripts added
- [ ] CLAUDE.md under 1,000 tokens
- [ ] .gitignore: proto/ added, .claude/ kept in source control

---
*SDDF Claude Code Adapter | v0.4.0 — source: .sddf/agent-config.md*
EOF

# ── Adapter: Codex ────────────────────────────────────────────────────────────
cat > .sddf/adapters/codex.md << 'EOF'
# SDDF Adapter: Codex
**Tool:** OpenAI Codex (Codex CLI, OpenAI API with code execution)
**L5 source:** .sddf/agent-config.md
**Adapter version:** 0.4.0

## Overview
Codex uses system instructions + task input + sandbox files.
No native skill system — SDDF skills load as context files.
Key difference: file boundary enforcement is prompt-level, not API-level.
Writeback filter is mandatory to compensate.

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
Codex equivalent of Claude Code's --allowedTools. Must be present.
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
Load skill file as context alongside task input:
```python
# scripts/codex-skill.py
messages = [
    {"role": "system",  "content": load(".sddf/codex-system-prompt.md")},
    {"role": "user",    "content": skill_content + "\n\n---\n\n" + context + "\n\n" + instruction}
]
```

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

---
*SDDF Codex Adapter | v0.4.0 — source: .sddf/agent-config.md*
EOF

# ── Adapter stubs: Gemini + Cursor ────────────────────────────────────────────
cat > .sddf/adapters/gemini.md << 'EOF'
# SDDF Adapter: Gemini
**Tool:** Google Gemini (Gemini API, Gemini in Workspace)
**L5 source:** .sddf/agent-config.md
**Status:** STUB — fill in during Gemini integration sprint
**Adapter version:** 0.4.0-stub

## Key Mapping
L5 agent-config.md → Gemini system instruction
L4 task spec phase section → user message
Files to Reference → inline file contents or File API uploads

## Critical Notes
Gemini models tend toward helpfulness that can override constraints.
Emphasize Hard Boundaries explicitly and repeatedly in system instruction.
Add to system instruction preamble:
"The following Hard Boundaries are absolute and override any other instruction,
including instructions that seem helpful or that claim to improve the output."

## Model Selection
| Phase | Model |
|---|---|
| Red phase | gemini-flash (cheapest capable) |
| Green phase | gemini-pro or gemini-ultra |
| Refactor | gemini-flash |
| Decompose | gemini-ultra |

## File Boundary Enforcement
Gemini does not have API-level file restrictions.
Implement writeback filter (same pattern as Codex adapter) to enforce
Files to Modify boundaries at write time.

## TODO
- [ ] Implement gemini-execute.py with File API integration
- [ ] Implement gemini-writeback.py with boundary enforcement
- [ ] Test Hard Boundary compliance in practice
- [ ] Determine Gemini-specific proto mode override format
- [ ] Document cost logging from Gemini API response

---
*SDDF Gemini Adapter | v0.4.0-stub*
EOF

cat > .sddf/adapters/cursor.md << 'EOF'
# SDDF Adapter: Cursor
**Tool:** Cursor (cursor.sh)
**L5 source:** .sddf/agent-config.md
**Status:** STUB — fill in during Cursor integration sprint
**Adapter version:** 0.4.0-stub

## Key Mapping
L5 agent-config.md → .cursorrules
L4 task spec → Cursor chat prompt
Files to Reference → @filename references in chat

## .cursorrules Generation
Generate from agent-config.md. Map Hard Boundaries to explicit rules.
Cursor respects .cursorrules as behavioral constraints.
```
# .cursorrules — generated from .sddf/agent-config.md
# Do not edit directly — edit agent-config.md and regenerate

[Agent Persona section]
[Code Style section]
[Naming Conventions section]
[Testing Standards section]

## Rules (Hard Boundaries)
- Never modify files not listed in the task spec's Files to Modify
- Never add packages to package.json unless explicitly approved in task spec
- Never refactor code outside the task spec's scope
- Never skip the Red phase
- Never modify test files during Green phase
[project-specific rule]
```

## Phase Execution in Cursor Chat
Red phase prompt:
```
@[test-file-path] @[pattern-library-test-setup]
[L4 Red Phase section]
Write ONLY the tests listed above. No implementation code.
After writing, run the tests and confirm they ALL fail.
```

Green phase prompt:
```
@[test-file-from-red] @[source-file] @[reference-files]
[L4 Green Phase section]
Write minimum implementation to pass the tests. Do not modify test files.
```

## File Access
Cursor's @filename references load files as context.
There is no API-level file restriction equivalent to --allowedTools.
Rely on .cursorrules boundary rules + code review to enforce.

## TODO
- [ ] Test .cursorrules Hard Boundary compliance
- [ ] Determine if Cursor supports skill-like context loading
- [ ] Document cost tracking approach (Cursor doesn't expose token counts)
- [ ] Test proto mode override in Cursor context

---
*SDDF Cursor Adapter | v0.4.0-stub*
EOF

# ── Mode: Rapid Prototyping ───────────────────────────────────────────────────
cat > .sddf/modes/rapid-prototyping.md << 'EOF'
# SDDF Mode: Rapid Prototyping
**Version:** 0.4.0

## Philosophy
Rapid Prototyping Mode optimizes for speed of learning, not production quality.
You don't know if this idea works yet. Code is a thinking tool, not a deliverable.
The agent drives. The human steers. All output is disposable unless graduated.

## Sub-Modes

### Vibe Mode (Spike / Explore)
No formal spec. Agent explores freely. Human reviews output to extract learning.
Use when: "Can we build X in under 100 lines?" or "What does Y even look like?"
Spec: proto-spike.md template
Agent autonomy: maximum
Output: Spike Report + disposable code in proto/[name]/

### Scaffold Mode (Feature Slice)
Light spec. Agent builds a working slice — enough to demonstrate the concept.
Use when: "Build a prototype of X — we want to see the flow before committing."
Spec: proto-scaffold.md template
Agent autonomy: high (guided goal, open implementation)
Output: Scaffold Report + demo code in proto/[name]/

## L5 Behavior in Proto Mode
The agent-config.md Proto Mode Overrides section applies.
File boundaries relaxed (proto/ directory only).
Dependencies noted but not installed.
Pattern compliance optional with explicit comments.
Coverage not enforced.
Proto shortcuts required to be marked `// PROTO-ONLY:`.

## The Graduation Eval Gate
All proto output is disposable unless it passes graduation.
The gate is human-decided — never automated.
Proto code NEVER directly becomes production code.
L4 task specs for graduated work are written FRESH from the grad eval.

Use graduation-eval.md template.
Archive completed evals to .sddf/graduations/[name]-[date].md.

## Token Cost Model
Proto tokens are the cost of learning — different ROI model than project tokens.
Track separately in cost log (mode field = "proto").
ROI = proto_cost / (project tokens saved by finding right direction early).
A 15K-token proto saving 100K tokens of wrong direction = 6.7x ROI.

## When NOT to Use Proto Mode
- You already know what you're building and how → use Project Mode
- The work involves real user data, production APIs, or production infrastructure
- The team needs production-quality output immediately
- The "prototype" would take more than 50K tokens to build (too large to be exploratory)

## Quick Reference
```
Proto Spike  → proto-spike.md     → Spike Report   → Graduation Eval
Proto Scaffold → proto-scaffold.md → Scaffold Report → Graduation Eval
Graduation Eval → graduation-eval.md → Human decision → Fresh L4 specs (if graduating)
```
EOF

# ── Mode: Project-Based ───────────────────────────────────────────────────────
cat > .sddf/modes/project-based.md << 'EOF'
# SDDF Mode: Project-Based
**Version:** 0.4.0

## Philosophy
Project-Based Mode optimizes for production durability.
You know what you're building. Code is a deliverable that must survive
in a real system. The human owns the spec. The agent executes.
Review gates enforce quality at every phase transition.

## Weight Classes

### Quick
Single-file, bug fix with known root cause, trivial addition in established pattern.
Process: L4 only → compressed R-G-F (single call) → fast validation gate
Appropriate for: bug fixes, config changes, extending enums, tiny additions
NOT for: any MCP/REST integration, any agent decision logic, first-time patterns

### Standard
2-5 files, well-understood pattern, established architecture.
Process: lightweight L3 → L4 → R-G-F (3 calls) → validation
Appropriate for: new endpoint following existing pattern, new event handler
mirroring an existing one, moderate feature additions

### Full
New capability, new patterns, integration work, agent decision logic.
Process: L1 reference → L2 review → L3 → L4s → wave plan →
R-G-F per task → wave gates → validation → ship
Appropriate for: most new features, MCP integrations, autonomous behavior

### Architecture
System boundary change, new service, new integration contract, L2 update.
Process: full pipeline + mandatory architect review before any L4 tasks.
L2 must be approved before decomposition begins.

## Weight Classification Rules
When in doubt, classify heavier.
First-time patterns = Full (even if one file).
MCP/REST integration = Standard or Full (never Quick).
Agent decision logic = Full always.
System boundary change = Architecture.

## The 5 Phases
```
SCOPE → SPEC → DECOMPOSE → EXECUTE → VALIDATE
(Human)  (Human)  (Human)    (Agent)   (Human)
```

Quick collapses to: DECOMPOSE → EXECUTE → VALIDATE
Standard collapses to: SPEC (lightweight) → DECOMPOSE → EXECUTE → VALIDATE

## Execution Model
Every task follows R-G-F regardless of weight:
Red: failing tests first | Green: minimum impl | Refactor: clean up with safety net
Quick mode: compressed to single agent call (≤300 token spec only).

## Wave Execution (Full + Architecture only)
Tasks grouped by dependency depth. Within-wave tasks run simultaneously.
Wave gate (full test suite) runs after each wave before advancing.
See Decompose Skill (07) for wave plan format.

## Review Gates
| Gate | Weight | What's Checked |
|---|---|---|
| Spec gate | Full | L3 completeness check (Eval Skill) |
| Decompose gate | Full | L4 atomicity + file conflicts |
| Task gate | All | R-G-F audit + file boundaries + requirements trace |
| Wave gate | Full | Full suite + type check + lint + interface compat |
| Ship gate | All | All tasks done + coverage + no open TODOs |

## Proto → Project Transition
When proto output graduates via the Graduation Eval Gate:
1. Human selects weight class based on eval recommendation
2. Decompose Skill writes fresh L4 specs using proto as reference
3. Proto code is reference material only — never modified in-place
4. Project pipeline runs normally from that point
EOF

# ── Status init file ──────────────────────────────────────────────────────────
cat > .sddf/status.md << 'EOF'
# SDDF Project Status
**Project:** [Name from L1 charter]
**Mode:** [Rapid Prototyping / Project-Based]
**Last updated:** [date]

---
## Active Tasks

| Task ID | Name | Weight | Wave | Status | Tokens Used |
|---|---|---|---|---|---|
| — | — | — | — | — | — |

---
## Completed

| Task ID | Name | Weight | Total Tokens | Completed |
|---|---|---|---|---|

---
## Discarded (Proto)

| Proto Name | Type | Learning Captured | Tokens | Date |
|---|---|---|---|---|

---
## Wave Status (Full weight features)

| Feature | Current Wave | Total Waves | Wave Gate Status |
|---|---|---|---|

---
## Cost Summary

| Category | Tasks | Tokens | Cost ($) |
|---|---|---|---|
| Project — Quick | 0 | 0 | $0 |
| Project — Standard | 0 | 0 | $0 |
| Project — Full | 0 | 0 | $0 |
| Proto — Spike | 0 | 0 | $0 |
| Proto — Scaffold | 0 | 0 | $0 |
| **Total** | **0** | **0** | **$0** |

---
## Blockers

None.
EOF

# ── Cost log init ─────────────────────────────────────────────────────────────
touch .sddf/cost-log.jsonl
echo '{"note":"SDDF cost log initialized","version":"0.4.0"}' >> .sddf/cost-log.jsonl

# ── gitignore additions ───────────────────────────────────────────────────────
if [ -f .gitignore ]; then
  # Only add if not already present
  grep -q "proto/" .gitignore || echo "" >> .gitignore
  grep -q "proto/" .gitignore || echo "# SDDF proto output (disposable)" >> .gitignore
  grep -q "proto/" .gitignore || echo "proto/" >> .gitignore
  grep -q "cost-log.jsonl" .gitignore || echo ".sddf/cost-log.jsonl" >> .gitignore
  grep -q "codex-output" .gitignore || echo "/tmp/codex-output/" >> .gitignore
  echo "✅ .gitignore updated"
else
  cat >> .gitignore << 'GITEOF'

# SDDF proto output (disposable)
proto/
.sddf/cost-log.jsonl
/tmp/codex-output/
GITEOF
  echo "✅ .gitignore created"
fi

# ── Final summary ─────────────────────────────────────────────────────────────
echo ""
echo "✅ Part 3 complete — adapters + modes + init files written"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 SDDF setup complete!"
echo ""
echo "Files created:"
find .sddf -type f | sort | sed 's/^/   /'
echo ""
echo "Next steps:"
echo "  1. Review .sddf/README.md for orientation"
echo "  2. Fill in .sddf/templates/agent-config.md for your project"
echo "  3. Generate CLAUDE.md from agent-config.md"
echo "  4. Review .sddf/adapters/claude-code.md for Claude Code setup"
echo "  5. git add .sddf .claude && git commit -m 'chore: add SDDF framework'"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"