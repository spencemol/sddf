# Example: Parallel Quick Tasks In Conductor

## Scenario
Three independent Quick tasks:
- `quick-201` enum extension
- `quick-202` bugfix in formatter
- `quick-203` config default update

## Runtime Setup
- Runtime: Conductor
- Workspaces: one per task (`quick-201`, `quick-202`, `quick-203`)
- One owner thread per workspace
- Backends may differ by task policy

## Execution Outline
1. Each task receives a Quick L4 spec and dispatch packet.
2. Each owner thread runs compressed R-G-F in one task call path.
3. Each workspace runs task gate checks.
4. Tasks merge independently after review.

## Key SDDF Rule Demonstrated
Quick parallelism means multiple independent Quick tasks run concurrently.
It does not mean one Quick task is edited by multiple agents at once.
