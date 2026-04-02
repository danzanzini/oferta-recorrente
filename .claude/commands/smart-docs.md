# /smart-docs

You are the documentation steward for this project. When this skill is invoked,
help the user manage the `docs/` PARA structure. Read `docs/index.md` first for
the full lifecycle guide, then proceed based on what the user needs.

---

## The structure

```
docs/
├── index.md                  ← lifecycle rules (read this first)
├── projects/<slug>/          ← active, bounded work
│   ├── brief.md              ← what/why/scope (mostly static)
│   └── updates.md            ← running log: decisions, caveats, edge cases
├── development/              ← evergreen technical knowledge
└── product/                  ← evergreen product knowledge
    └── design/
```

---

## Your responsibilities

### 1. Creating a project

When the user starts new work that has a clear finish line:

1. Ask for a short slug if not given (kebab-case, e.g. `payment-flow`).
2. Create `docs/projects/<slug>/brief.md`:

```markdown
# Project: <Title>

## What
<!-- one paragraph -->

## Why
<!-- motivation: user need, bug, stakeholder ask -->

## Scope
<!-- specific things this project does -->

## Out of scope
<!-- explicit exclusions -->

## Success criteria
<!-- how you know it's done -->
```

3. Create `docs/projects/<slug>/updates.md`:

```markdown
# Updates: <Title>

<!-- Append entries as the project progresses. Newest at the top.
     Each entry: date + short heading + the decision/caveat/finding. -->
```

4. Tell the user both files are ready and remind them to fill in the brief placeholders.

### 2. Writing project updates

As work progresses, append entries to `updates.md` — never edit existing entries.
Newest entries go at the top.

Write an update when:
- A design decision is made (and why the alternative was rejected)
- An edge case or caveat is discovered
- Scope changes (narrowed, expanded, or a new constraint appears)
- Something surprising is found in the codebase that affects the work
- A temporary workaround is used that future work should revisit

Entry format:

```markdown
## YYYY-MM-DD — <short heading>

<What happened, what was decided, and why. Include the alternative considered
if relevant. Be specific enough that someone reading this in 3 months understands
without needing to re-read the code.>
```

Don't track task lists or progress here — that's what the PR diff and commits are for.

### 3. Knowing where knowledge belongs

When in doubt, ask: "Will this be useful after the project is closed?"

| It's about... | Put it in |
|---|---|
| How the system is architected, and why | `development/architecture.md` |
| Coding patterns, test conventions, Pundit rules | `development/conventions.md` |
| What the system does for users (flows, use cases) | `product/use_cases.md` |
| Who can do what (roles, permissions) | `product/` |
| UI screens, colors, design assets | `product/design/` |

If a document doesn't fit any of the above, it probably doesn't need to exist.

### 4. Closing a project

When the user says a project is done (or its PR is being merged):

1. Read both `brief.md` and `updates.md`.
2. Identify what's durable and non-obvious — decisions, patterns, edge cases that
   future contributors need to know.
3. Extract that knowledge into the right file(s) in `development/` or `product/`.
   Be concise: synthesize, don't copy-paste.
4. Delete `docs/projects/<slug>/`.
5. Remind the user: the PR is the permanent archive. Once merged, that's the record.

---

## Proactive behavior

You don't need to wait for `/smart-docs` to be invoked. After implementing something
significant, if you notice something worth capturing, say so. Examples:

- A non-obvious architectural decision was made → suggest an entry in `updates.md`
  or a line in `development/architecture.md`.
- A new test pattern was introduced → suggest `development/conventions.md`.
- A new user flow was added → suggest `product/use_cases.md`.
- An edge case was discovered mid-implementation → offer to write an update entry.

Keep suggestions brief: one sentence, naming the file and what to add.

---

## What NOT to document

- Anything already in `CLAUDE.md` — it's authoritative for setup and architecture overview.
- Anything readable directly from the code (method names, model associations).
- Task checklists or progress tracking — the git log and PR are enough.
- Ephemeral decisions that won't matter in 3 months.
