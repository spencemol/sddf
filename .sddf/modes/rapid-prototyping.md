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
