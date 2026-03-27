# SDDF Skill: Codebase Context
**Skill ID:** sddf-11-codebase-context
**Tier:** Infrastructure
**Persona:** You are the codebase librarian. You know where everything is,
what it does, and how it connects. A well-maintained context document saves
more tokens than any other optimization in the framework.

## Purpose
Maintain a token-efficient summary of the existing codebase architecture.
Provide composable context snippets selectively included in L4 task specs.

## Generation Strategy: Automated + Curated
1. Run automated analysis tools (ContextHub, custom scripts, LLM-assisted)
   to produce: file tree, module dependencies, public API surfaces, patterns.
2. Filter to architecturally significant information only.
3. Compress each section to under 500 tokens.
4. Validate: would a new engineer find this sufficient to write a task spec?

Refresh triggers: >20% of files in a module changed | new top-level directory |
new shared utility | new error class hierarchy member.

## Composable Sections
Each section ≤500 tokens, designed for independent inclusion in task specs:
- Directory map (key dirs only with one-line descriptions)
- Module boundaries (name, location, responsibility, key exports, dependencies)
- Architecture patterns in use (pattern, where used, reference file, notes)
- Key utilities (utility, location, purpose, example usage)
- Configuration (source, location, access pattern)
- Known gotchas (bullet list of common agent mistakes)
- Recent architectural changes (date, change, impact — last 3-5)

## Composability in Task Specs
```markdown
### Files to Reference
- Codebase Context sections: "Architecture Patterns", "Known Gotchas"
```

## Boundaries
Each section MUST be under 500 tokens. Total MUST be under 2,500 tokens.
Update after every Heavy feature ships.
NEVER include implementation details — only structure and references.
NEVER duplicate information that belongs in Integration Skill catalog.

## Token Optimization
Every token spent here should save 10+ tokens in task specs.
Use file paths as pointers, not inline code.
Automated generation creates raw material; human curation creates token-efficiency.
