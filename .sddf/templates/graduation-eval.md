# Graduation Eval Gate Template
**SDDF Mode:** Transitional (Proto → Project)
**Agent role:** Produces Parts 1-5
**Human role:** Makes graduation decision (Part 6) — never automated
**Template version:** 0.4.0

> This is the firewall between prototyping and production.
> Proto code NEVER directly becomes production code.
> L4 task specs for graduated work are written FRESH.
> The proto is reference material only — not a foundation.

---
## Graduation Eval: [Proto Name]
**Proto type:** [ ] Spike  [ ] Scaffold
**Proto directory:** `proto/[name]/`
**Date:** ___  **Evaluated by:** ___

---
## Part 1: Learning Capture (Agent-Produced)

### Learning Question
[Restate from proto spec]

### Was It Answered?
[ ] Yes — fully  [ ] Partially  [ ] No

### Core Findings
1. [Finding — specific, technical, honest]
2. [Finding]
3. [Finding]

### Architectural Revelations
[What did the proto reveal that wasn't anticipated, or "None — confirmed assumptions"]

### Approach Validation
| Approach / Decision | Validated? | Evidence | Recommendation |
|---|---|---|---|

---
## Part 2: Throwaway Conditions Check (Agent-Produced)

| Condition | Status | Evidence |
|---|---|---|
| [Condition from proto spec] | [Triggered / Not triggered] | [specific] |

**Verdict:** [ ] No conditions triggered — proceed  [ ] Condition(s) triggered — recommend DISCARD

---
## Part 3: Production Gap Assessment (Agent-Produced)

### Pattern Library Gaps
| Proto Approach | Required Pattern | Effort (S/M/L) | Files Affected |
|---|---|---|---|

### Missing Error Handling
| File:Line | Shortcut | Production Requirement |
|---|---|---|

### Missing Test Coverage
| Behavior | Proto Tests | Production Tests Required |
|---|---|---|

### Missing Resilience
| Integration Point | Proto Handling | Production Requirement |
|---|---|---|

### Type Safety Gaps
- [Location] — [gap]

### Security / Compliance Gaps
- [Gap or "None identified"]

### Hardcoded Values
| Value | Location | Should Become |
|---|---|---|

---
## Part 4: Code Salvage Assessment (Agent-Produced)

| Component | Location | Quality | Recommendation | Notes |
|---|---|---|---|---|
| [name] | [file(s)] | [proto-only/salvageable/solid] | [discard/rewrite/keep+tests/keep] | |

**Summary:** Keep with tests: [N]  |  Rewrite using proto as ref: [N]  |  Discard: [N]

---
## Part 5: Graduation Options (Agent-Produced, Human-Decided)

### Option A: DISCARD
Appropriate if: throwaway conditions triggered, acceptance not reached,
or code value doesn't justify productionizing.
What happens: proto archived, learning captured, no L4 tasks created.

### Option B: Quick Mode
Appropriate if: essentially single-file, mostly clean, minimal gaps.
Estimated: [N] tasks | [N] tokens | [N hours] gap closure

### Option C: Standard Pipeline
Appropriate if: 2-5 file changes, established patterns, moderate gaps.
Estimated: [N] tasks | [N] tokens | L3: [brief description]

### Option D: Full Pipeline
Appropriate if: significant capability, substantial gaps, proto is design reference.
Estimated: [N] tasks across [N] waves | [N] tokens | [N] L3 specs | L2 update: Y/N

### Option E: Architecture Review First
Appropriate if: proto revealed architectural implications requiring L2 update.
Architectural implications: [list]
Next step: Scope Skill session to update L2 before decomposition.

---
## Part 6: Human Decision

### Decision
[ ] DISCARD — reasoning: ___
[ ] GRADUATE — Quick Mode
[ ] GRADUATE — Standard Pipeline
[ ] GRADUATE — Full Pipeline
[ ] GRADUATE — Architecture Review First
[ ] RETURN TO PROTO — additional exploration needed: ___

### Decision Rationale
[2-3 sentences — captured for project history]

### Knowledge That Survives (even if discarding)
- [Learning that informs future decisions]
- [Learning 2]

### If Graduating: Fresh Spec Instructions
> L4 task specs are written FRESH. Proto is reference only.
> Invoke Decompose Skill (Skill 07) with this eval as input.

Reference material: `proto/[name]/REPORT.md`
Components worth keeping: [from Part 4]
Design decisions validated: [from Part 1]
Patterns to follow: [from Part 3]

---
## Part 7: Token Accounting (Auto-populated by Cost Tracker)

| Category | Tokens | Cost |
|---|---|---|
| Proto execution | [N] | $[N] |
| Graduation eval | [N] | $[N] |
| **Proto total** | **[N]** | **$[N]** |
| Est. project tokens (if graduating) | [N] | $[N] |
| **Proto ROI** | proto_cost / project_savings if right direction | [ratio] |

---
## Completion Checklist
- [ ] Part 1: findings specific and honest
- [ ] Part 2: all throwaway conditions checked with evidence
- [ ] Part 3: all gap categories addressed (N/A acceptable)
- [ ] Part 4: every proto component assessed
- [ ] Part 5: all applicable options estimated
- [ ] Part 6: human decision recorded with rationale
- [ ] Part 7: token accounting complete

---
*Graduation Eval Gate | SDDF v0.4.0*
*Archive to: .sddf/graduations/[name]-[date].md*
