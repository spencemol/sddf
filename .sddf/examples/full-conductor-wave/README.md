# Example: Full Mode Wave In Conductor

## Scenario
Feature decomposes into two Wave 1 tasks:
- `payments-101` service logic
- `payments-102` API endpoint

They can run in parallel because file boundaries do not overlap.

## Runtime Setup
- Runtime: Conductor
- Workspaces:
  - `payments-101` -> owner thread uses `claude-code-cli`
  - `payments-102` -> owner thread uses `codex-cli`
- One owner thread per workspace
- Optional reviewer thread in each workspace

## Artifacts
- L4 task specs in `.sddf/tasks/payments/`
- Dispatch packets per task lane
- Task gate reports per workspace
- Wave gate report after both lanes complete

## Execution Outline
1. Orchestrator assigns both tasks to Wave 1 lanes.
2. Each workspace runs R-G-F by its backend policy.
3. Each lane publishes task gate evidence.
4. Wave gate runs full suite + compatibility checks.
5. On pass, Wave 2 dispatch may begin.

## Key SDDF Rule Demonstrated
Parallelism is workspace/lane-level. No direct agent-to-agent chat coordination.
