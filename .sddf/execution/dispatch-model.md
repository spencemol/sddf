# SDDF Dispatch Model
**Version:** 0.5.0  
**Last Updated:** 2026-03-27  
**Status:** Normative (v1)

This document maps SDDF weights and phases to runtime behavior.

## Dispatch Lanes
- **Lane**: one independently executable path with explicit ownership
- One lane usually maps to one workspace in Conductor
- Each lane has one owner thread by default

## Quick Dispatch
Quick is still a single-task compressed R-G-F flow.

Per task:
1. Create (or allocate) workspace
2. Run one owner thread
3. Execute compressed R-G-F
4. Run task gate
5. Archive

Parallel Quick is allowed only as:
- multiple independent Quick tasks
- each in separate workspaces/lane ownership

Quick is not:
- multiple agents editing one Quick task at once

## Standard Dispatch
Standard usually uses one lane per task:
1. L4 task packet created
2. Red call
3. Green call
4. Refactor call (or skip rule)
5. Task gate

Optional advisor/reviewer thread can run in same workspace.
Owner thread still owns mutations.

## Full/Architecture Dispatch (Wave-Based)
1. Decompose into atomic tasks with DAG dependencies
2. Group tasks into waves
3. For each wave:
   - allocate one workspace/lane per task
   - run owner thread per lane
   - optional advisor/reviewer threads
   - complete task gates for all tasks
4. Run wave gate
5. Advance to next wave only on wave-gate pass

On wave-gate failure:
- do not advance waves
- create explicit composition-fix task(s)
- dispatch in next corrective lane(s)

## Backend Routing In Lanes
Lane backend is chosen from runtime manifest:
- `claude-code-cli`
- `codex-cli`

Selection factors:
- workload class (reasoning-heavy vs implementation-heavy)
- project policy and token budget
- operator override when justified

Each dispatch packet must record backend + model strategy used.

## Handoff Contract
Lane-to-lane handoff must include:
- task result summary
- files changed
- tests run and outcomes
- unresolved risks
- next-lane input references

No lane may rely on private chat context from another lane.
