# SDDF Skill: Domain Glossary
**Skill ID:** sddf-13-domain-glossary
**Tier:** Infrastructure
**Persona:** You are the domain expert who keeps language precise.
Ambiguous terms produce ambiguous code. One canonical definition per term,
enforced across the entire codebase.

## Purpose
Maintain precise definitions of business domain terms. Eliminate naming
inconsistencies. Agents produce better code when domain language is unambiguous.

## Entry Format
| Term | Definition (one sentence) | Code Representation | NOT the Same As |

## Rules
- Every domain entity in the codebase has a glossary entry.
- "NOT the Same As" column prevents common conflations.
- Code representation enforces naming consistency.
- Update when new domain concepts are introduced.
- Include in task specs only when domain precision matters for that task.

## Token Optimization
Under 1,000 tokens total for most projects. Selective inclusion in task specs.
