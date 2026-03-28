# docs/ — PARA Structure Guide

This folder uses a PARA-like system adapted for a software project. Three folders,
one rule: if it's active work with a finish line, it's a **project**. If it's
knowledge that outlives any single project, it lives in **development** or **product**.

---

## Folders

### `projects/` — active, bounded work
One subfolder per active initiative. A project has a clear "done" state.
Each project folder contains at minimum a `brief.md`.

```
projects/
└── <slug>/
    ├── brief.md      # what, why, scope, success criteria (mostly static)
    └── updates.md    # running log: decisions, caveats, edge cases (append-only, newest first)
```

**A project is done when its PR is merged.** The PR itself is the archive —
no need to keep a closed-project folder. When closing:
1. Extract surviving knowledge into `development/` or `product/` (or both).
2. Delete the project folder.
3. Merge the PR — it becomes the permanent record.

### `development/` — evergreen technical knowledge
Architecture decisions, dev conventions, and patterns that any future contributor
(or Claude) needs to understand to work effectively on this codebase.

Good candidates:
- Non-obvious architectural choices and the reasoning behind them
- Testing patterns and helpers
- Authorization conventions (Pundit policies)
- Routing patterns

Not here: things already explained by CLAUDE.md or readable from the code.

### `product/` — evergreen product knowledge
What the system does and for whom. Use cases, roles, flows, design assets.

Good candidates:
- Use cases / user stories
- Role-based access descriptions
- UI screens and design assets
- Business rules that aren't obvious from the domain model

---

## Lifecycle of a project

```
Open a project        Work on it                Close it
──────────────────    ────────────────────────  ─────────────────────────────────
Create                Append to updates.md:     Extract durable knowledge →
projects/<slug>/      decisions, caveats,       development/ and/or product/
brief.md              edge cases, surprises.    Delete projects/<slug>/
updates.md            Don't edit past entries.  Merge PR → permanent archive.
```

---

## What NOT to put here

- Ephemeral notes or scratch pads — use the PR description or comments.
- Things derivable from reading the code — trust the code.
- Duplicate of CLAUDE.md content — CLAUDE.md is authoritative for setup/architecture overview.
