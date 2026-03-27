# SDDF Runtime Watchlist
**Version:** 0.5.0  
**Last Updated:** 2026-03-27  
**Status:** Research-only

This file tracks platforms that are intentionally out of v1 implementation scope.

## Codex App (Watchlist)
Status:
- Not a first-class SDDF runtime target in v1.
- Codex support in v1 is via Codex CLI, typically orchestrated by Conductor.

Fit against runtime contract:
- Strong for isolated tasks and parallel operation.
- App-native orchestration differs from current SDDF runtime assumptions.

Promotion criteria:
1. Stable mapping from SDDF dispatch packets to app task model
2. Clear file-boundary and artifact handoff guarantees
3. Repeatable setup for mixed Claude/Codex organizational workflows
4. Validation that SDDF skill-bundle portability remains intact

## Google Antigravity (Watchlist)
Status:
- Not a first-class SDDF runtime target in v1.
- Tracked for future orchestration compatibility assessment.

Fit against runtime contract:
- Strong mission-control and parallel agent concepts.
- Contract-level mapping for ownership, artifacts, and gating remains unproven.

Promotion criteria:
1. Deterministic mapping for owner/advisor thread roles
2. Workspace and artifact controls compatible with SDDF gate discipline
3. Reliable backend policy controls for mixed-model governance
4. Pilot showing wave-gate and task-gate parity with SDDF requirements
