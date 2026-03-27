# SDDF Adapter: Cursor
**Tool:** Cursor (cursor.sh)
**L5 source:** .sddf/agent-config.md
**Status:** STUB — fill in during Cursor integration sprint
**Adapter version:** 0.4.0-stub

## Key Mapping
L5 agent-config.md → .cursorrules
L4 task spec → Cursor chat prompt
Files to Reference → @filename references in chat

## .cursorrules Generation
Generate from agent-config.md. Map Hard Boundaries to explicit rules.
Cursor respects .cursorrules as behavioral constraints.
```
# .cursorrules — generated from .sddf/agent-config.md
# Do not edit directly — edit agent-config.md and regenerate

[Agent Persona section]
[Code Style section]
[Naming Conventions section]
[Testing Standards section]

## Rules (Hard Boundaries)
- Never modify files not listed in the task spec's Files to Modify
- Never add packages to package.json unless explicitly approved in task spec
- Never refactor code outside the task spec's scope
- Never skip the Red phase
- Never modify test files during Green phase
[project-specific rule]
```

## Phase Execution in Cursor Chat
Red phase prompt:
```
@[test-file-path] @[pattern-library-test-setup]
[L4 Red Phase section]
Write ONLY the tests listed above. No implementation code.
After writing, run the tests and confirm they ALL fail.
```

Green phase prompt:
```
@[test-file-from-red] @[source-file] @[reference-files]
[L4 Green Phase section]
Write minimum implementation to pass the tests. Do not modify test files.
```

## File Access
Cursor's @filename references load files as context.
There is no API-level file restriction equivalent to --allowedTools.
Rely on .cursorrules boundary rules + code review to enforce.

## TODO
- [ ] Test .cursorrules Hard Boundary compliance
- [ ] Determine if Cursor supports skill-like context loading
- [ ] Document cost tracking approach (Cursor doesn't expose token counts)
- [ ] Test proto mode override in Cursor context

---
*SDDF Cursor Adapter | v0.4.0-stub*
