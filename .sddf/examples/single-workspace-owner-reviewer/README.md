# Example: Single Workspace Owner + Reviewer

## Scenario
One Standard task in one workspace where a reviewer thread provides extra quality checks.

## Runtime Setup
- Workspace: `orders-310`
- Owner thread: `claude-code-cli`
- Reviewer thread: read-focused lane in same workspace
- Optional Claude subagents allowed only inside owner thread

## Execution Outline
1. Owner thread performs Red/Green/Refactor.
2. Owner thread publishes task artifacts and gate evidence.
3. Reviewer thread audits diff and requirements trace.
4. Reviewer thread issues approve/request-changes decision artifact.
5. Owner thread applies fixes if needed and re-runs task gate.

## Key SDDF Rules Demonstrated
- Single mutation owner per workspace
- Advisor/reviewer threads are separation-of-concerns helpers
- Subagents are intra-thread helpers, not workspace parallelism replacement
