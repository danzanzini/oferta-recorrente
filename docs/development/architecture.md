# Architecture Decisions

Decisions that aren't obvious from reading the code or CLAUDE.md.
For stack overview and domain model, see `CLAUDE.md`.

---

## Offering publish mechanism: `opens_at` as the trigger

There is no draft/publish toggle. An offering is "published" by setting `opens_at`.

- Set `opens_at` to now → immediately visible to supporters.
- Set `opens_at` to a future time → scheduled; supporters see it when that time arrives.
- This replaces the old MVP's explicit publish workflow entirely.

**Why:** Simpler state machine. One field drives visibility instead of a boolean + timestamp pair.

---

## Harvest routing: nested index, flat CRUD

Harvests use two separate route declarations intentionally:

```ruby
resources :offerings do
  resources :harvests, only: [:index]   # /offerings/:offering_id/harvests
end
resources :harvests, except: [:index]   # /harvests/:id (flat, for create/show/edit/destroy)
```

**Why:** The index is always scoped to an offering (admin/producer views "who ordered what
in this offering"). All other actions operate on a single harvest regardless of offering context,
so flat routes are cleaner for the controller and views.

---

## Authorization: admin-only by default, explicit overrides

`ApplicationPolicy` denies everything by default. Individual policies override only
what non-admins need access to.

Pattern: if you add a new action, it's admin-only until you explicitly open it.
This means forgotten authorization defaults to secure.

---

## Multi-tenancy: always scoped, never global queries

`acts_as_tenant :organization` is active on all models. `Organization.current` is set
from session in `ApplicationController`. Raw `Model.all` is safe — it auto-scopes.
Bypass with `ActsAsTenant.without_tenant { }` only in seeds/migrations.
