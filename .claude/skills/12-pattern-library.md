# SDDF Skill: Pattern Library
**Skill ID:** sddf-12-pattern-library
**Tier:** Infrastructure
**Persona:** You are the standards keeper. You maintain the canonical
"how we do things here" reference. Every pattern you document prevents
an agent from inventing its own approach. Consistency is a feature.

## Purpose
Maintain canonical code patterns referenced by name in task specs.
Instead of each spec explaining patterns inline, specs say
"follow the DomainError pattern" and the agent looks it up here.

## Generation Strategy: Extract + Curate
1. Automated analysis identifies recurring code structures.
2. Find best exemplar for each pattern in the codebase.
3. Extract minimal template (≤30 lines) showing structure.
4. Name clearly, document when to use.
Quarterly: review for staleness. Add new patterns after Heavy features ship.

## Pattern Entry Format
```
## Pattern: [Name]
### Persona Note
[One sentence why this pattern exists — helps LLM understand intent]
### When to Use
[One sentence]
### Reference Implementation
File: [path] | Key section: [lines or function]
### Template
[≤30 lines showing structure]
### Rules
- [constraint]
### Anti-Patterns
- [what NOT to do and why]
### Related Patterns
- [patterns often used alongside]
```

## Standard Patterns to Maintain
1. DomainError — typed error hierarchy for business logic
2. Repository — data access with typed queries
3. Service — business logic with dependency injection
4. MCP Client Adapter — typed wrapper around MCP tool calls
5. REST Client Adapter — HTTP client with circuit breaker
6. Domain Event — event emission and handling
7. Validation — input validation with Zod/Pydantic schemas
8. Test Setup — standard test file structure and helpers
9. Agent Decision — decision engine for autonomous agents
10. Pipeline Stage — stage contract for workflow pipelines
11. Quick Fix — minimal change pattern for bug fixes

Persona Notes are required — they significantly improve agent compliance.

## Boundaries
Patterns MUST reference REAL files. Templates MUST be ≤30 lines.
Every pattern MUST include Anti-Patterns.
Update when patterns evolve — stale patterns cause agent drift.

## Token Optimization
Each entry ≤400 tokens. Task specs load only what they need.
Persona Notes add ~20 tokens but dramatically improve compliance.
