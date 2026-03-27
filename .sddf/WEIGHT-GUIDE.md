# SDDF Task Weight Classification Guide

## Decision Tree
```
Is this a new feature or architectural change? → YES → Heavy
Does it touch more than 3 files? → YES → Heavy
Does it introduce a new pattern or integration? → YES → Heavy
Does it involve agent decision logic or autonomous behavior? → YES → Heavy

Is it a well-understood change following existing patterns?
  → YES, 2-5 files → Standard
  → YES, 1 file → Quick

Is it a bug fix with known, verified root cause? → YES → Quick
Is it a config or documentation change? → YES → Quick
```

## Rules

- When in doubt, classify heavier
- First-time patterns = Heavy (even if one file)
- MCP/REST integration = Standard or Heavy (never Quick)
- Agent decision logic = Heavy always
- Engineer must justify any downgrade in classification

## Process per Weight

| Weight | L-Docs Required | R-G-F | Wave Plan | Review Gates |
|---|---|---|---|---|
| Heavy | L1 + L2 + L3 + L4 | Enforced (3 calls) | Required | 3 gates |
| Standard | Lightweight L3 + L4 | Enforced (3 calls) | Only if 3+ tasks | 2 gates |
| Quick | L4 only | Compressed (1 call) | Never | 1 gate |
| Proto Spike | Proto spec only | Not enforced | Never | Grad eval only |
| Proto Scaffold | Proto spec only | Encouraged | Never | Grad eval only |
