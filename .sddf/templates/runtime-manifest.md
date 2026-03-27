# Runtime Manifest Template
**SDDF Layer:** Execution Runtime  
**Template version:** 0.5.0

> Fill this once per project/runtime setup.

---
## Runtime Identity
- Runtime: `[conductor]`
- Runtime version/policy baseline: `[version or date]`
- Source docs reviewed: `[links or internal refs]`

---
## Available Backends
- Primary backends:
  - `claude-code-cli`
  - `codex-cli`
- Optional backends (if enabled): `[none|list]`

---
## Workspace Strategy
- Workspace policy: `[one workspace per lane | custom]`
- Branch naming: `[pattern]`
- Workspace root convention: `[path pattern]`
- Cleanup/archive policy: `[when + how]`

---
## Thread Policy
- Owner thread policy: `[single owner required]`
- Advisor/reviewer policy: `[allowed roles and constraints]`
- Promotion policy: `[how non-owner can become owner]`
- Subagent policy (Claude-backed only): `[allowed scope + boundaries]`

---
## Script Policy
- Setup script: `[command or path]`
- Run script: `[command or path]`
- Archive script: `[command or path]`
- Script guardrails: `[what scripts must not do]`

---
## Auth / Provider Profile Notes
- Provider env strategy: `[how credentials and model providers are set per workspace/thread]`
- Cost/account ownership policy: `[which account pays for what]`
- Rotation policy: `[when to switch backend or model class]`

---
## Checkpoint Policy
- Runtime checkpoint usage: `[required|optional|disabled]`
- Checkpoint scope: `[before merge, before risky refactor, etc.]`
- Source of truth reminder: `git + SDDF artifacts`

---
## Artifact Paths
- Status manifest: `[path]`
- Task specs: `[path]`
- Dispatch packets: `[path]`
- Validation reports: `[path]`
- Handoff notes: `[path]`

---
*Runtime Manifest | SDDF v0.5.0*
