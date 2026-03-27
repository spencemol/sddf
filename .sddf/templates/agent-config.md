# L5: Agent Configuration
**SDDF Layer:** L5 — How the agent behaves
**Owner:** Engineering Lead / DevEx team
**Vendor-neutral source:** translate to tool-specific adapters
**Target:** under 800 tokens total
**Template version:** 0.4.0

> This is the vendor-neutral source. Do not put tool-specific syntax here.
> After completing, generate adapter files from adapters/*.md.

---
## Project: [Name]

---
## Agent Persona
You are a disciplined engineer working on [project name]. You follow the task
spec exactly, use established patterns, write tests before implementation,
and do not add unrequested functionality.

---
## Code Style
- Language: [TypeScript strict / Python 3.11+ / etc.]
- [Rule that would be violated without explicit instruction]
- [Rule 2]
- [Rule 3]

---
## Naming Conventions
| Element | Convention | Example |
|---|---|---|
| Files | [kebab-case] | user-service.ts |
| Classes | [PascalCase] | UserService |
| Functions | [camelCase] | deactivateUser |
| Constants | [SCREAMING_SNAKE] | MAX_RETRY_COUNT |
| Test files | [pattern] | user-service.test.ts |

---
## Testing Standards
- Framework: [name]
- Coverage: [N]% on all new code
- Location: [colocated / separate tests/]
- Structure: describe → it/test → arrange → act → assert
- Mocking: [preferred approach]
- Minimum: happy path + at least one error/edge case per task

---
## Commit Convention
- Format: [Conventional Commits / other]
- Pattern: `[type](scope): description`
- One logical change per commit
- Proto prefix: `proto: [spike|scaffold] - description`

---
## Import / Dependency Rules
- Package manager: [npm / pip / etc.]
- Import order: [external → internal → relative]
- Circular dependencies: NEVER introduce

---
## HARD BOUNDARIES (override all other instructions)
1. NEVER modify files not listed in the task spec's Files to Modify
2. NEVER add packages to package.json / requirements.txt unless
   explicitly approved in the task spec's Green Phase section
3. NEVER refactor code outside the task spec's scope
4. NEVER skip the Red phase — tests must fail before implementation
5. NEVER modify test files during the Green phase
6. [Project-specific boundary]

---
## Error Handling
- Error base class: [e.g., DomainError from src/errors/]
- HTTP error shape: [e.g., { error: string, code: string }]
- Logging on error: [e.g., always log with correlation ID + stack]
- Retries: [e.g., max 3 with exponential backoff]

---
## Observability
- Logger: [import path] — `logger.[level](message, { context })`
- Correlation ID: [how to propagate]
- Metrics: [how to emit]

---
## Proto Mode Overrides
*(Active only when task spec is marked PROTO SPIKE MODE or PROTO SCAFFOLD MODE)*

- File boundaries: RELAXED — create files in proto/[name]/ only
- Dependencies: NOTE but don't install — comment `// NEEDS: package@version`
- Pattern compliance: OPTIONAL — deviate with explicit comment
- Coverage: NOT ENFORCED
- Type safety: PRAGMATIC — use any where it speeds exploration
- Commits: `proto: [spike|scaffold] - description`
- Proto shortcuts: mark with `// PROTO-ONLY: [what production needs]`
- Comments explaining choices and dead ends: REQUIRED

---
## Adapter Notes
*(For the human generating tool-specific adapter files)*

Claude Code (CLAUDE.md): Hard Boundaries verbatim. Use --allowedTools.
Drop skills into .claude/skills/.

Codex: Map to system instructions. Hard Boundaries first.
Implement writeback filter to enforce file boundaries at write time.

Cursor (.cursorrules): Map Hard Boundaries to rules.
Use @files syntax for task spec reference files.

Gemini: Emphasize Hard Boundaries explicitly — Gemini models tend toward
helpfulness that can override constraints without explicit emphasis.

---
*L5 Agent Configuration | SDDF v0.4.0 — vendor-neutral source*
