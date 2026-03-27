# L3: Feature Spec
**SDDF Layer:** L3 — What exactly we are building
**Owner:** Product + Engineering
**Sent to agents:** Never directly. Decomposed into L4 task specs.
**Template version:** 0.4.0

> Fill every section before marking APPROVED.
> Use MUST / SHOULD / MAY (RFC 2119) throughout.
> Every MUST needs a corresponding acceptance criterion.
> Starred (*) sections required for Standard weight (lightweight L3).

**Status:** [ ] DRAFT  [ ] IN REVIEW  [ ] APPROVED
**Weight:** [ ] Standard (lightweight)  [ ] Full  [ ] Architecture

---
## Feature: [Name] *

---
## Context *
[Why this feature exists. Link to L1 charter goal.]
**Charter reference:** [project name] — [success metric this supports]

---
## User Stories *
- As a **[role]**, I want **[capability]**, so that **[outcome]**.

---
## Behavior Specification *

### Happy Path
1. [Step 1]
2. [Step 2]

### Edge Cases
| Condition | Expected Behavior |
|---|---|

### Error States
| Condition | Response | HTTP Status | User Message |
|---|---|---|---|

---
## Acceptance Criteria *
*(GIVEN/WHEN/THEN. Min 5 for Full, min 3 for Standard.)*

- [ ] GIVEN [state], WHEN [action], THEN [specific measurable result]
- [ ] GIVEN [state], WHEN [action], THEN [specific measurable result]
- [ ] GIVEN [state], WHEN [action], THEN [specific measurable result]
- [ ] GIVEN [state], WHEN [action], THEN [specific measurable result]
- [ ] GIVEN [state], WHEN [action], THEN [specific measurable result]

---
## Scope Boundary *
*(Min 3 explicit exclusions. This section is never optional.)*

This feature does NOT include:
- [ ] [Explicit exclusion 1]
- [ ] [Explicit exclusion 2]
- [ ] [Explicit exclusion 3]

---
## Integration Contract *(skip if no external calls)*

| External System | Tool / Endpoint | Direction | Auth | Rate Limit | Failure Handling | Freshness |
|---|---|---|---|---|---|---|

---
## Data Requirements
New entities: ___
| Entity | Field | Type | Default | Migration? |
|---|---|---|---|---|

---
## UI / UX Reference
[ ] No UI changes  [ ] Wireframes: [link]  [ ] Mockups: [link]

---
## Dependencies
| Dependency | Type | Status | Owner | Risk |
|---|---|---|---|---|

---
## Rollout Strategy
Feature flag required: [ ] Yes  [ ] No
Flag name: `[flag-name]`
1. Shadow mode — [duration]
2. [N]% — [gate condition]
3. 50% — [gate condition]
4. 100% — [final condition]
Rollback: [how to disable]

---
## Observability
Logs: ___
| Metric | Type | Alert Threshold |
|---|---|---|

---
## Open Questions
*(Must all be resolved before APPROVED)*

| Question | Owner | Resolution Date | Answer |
|---|---|---|---|

---
## Changelog
| Date | Change | Author |
|---|---|---|

---
*L3 Feature Spec | SDDF v0.4.0*
