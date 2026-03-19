# Feature Gaps: MVP → oferta-recorrente

Comparison between the old MVP (`csa-recife`) and the current app (`oferta-recorrente`).
The goal is to bring all relevant features from the MVP into the current codebase.

> Architectural differences (multi-tenancy, Pundit, custom auth, Subscriptions model, Producer role)
> are intentional upgrades — they are not listed as gaps.
>
> **Offering publish workflow (gap #5 from initial analysis):** Intentionally replaced by
> `opens_at`. Admin either publishes immediately (sets `opens_at` to now) or schedules a
> future open time. The `opens_at` field is the publish mechanism — no separate draft/publish
> toggle needed.

---

## Critical Gaps (missing functionality)

### 1. Users cannot change their own password

**Old MVP:** `GET /edit_password` + `PATCH /users` allowed any logged-in user to update
their password via a dedicated form.

**Current:** No such action exists. Users are created with `email` as password and have
no self-service way to change it.

**Files to create/modify:**
- Add `edit_password` / `update_password` actions to `UsersController`
- Add route (e.g. `get :edit_password, on: :collection` + `patch :update_password`)
- Add view `app/views/users/edit_password.html.erb`
- Link from the home page or user profile

---

### 2. No way to re-activate a deactivated user

**Old MVP:** `POST /users/:id/toggle_active` toggled `active` bidirectionally — admin
could deactivate AND re-activate users.

**Current:** `destroy` action sets `active: false`. Once deactivated, there is no UI
or action to re-activate a user.

**Files to modify:**
- Add `toggle_active` action (or rename `destroy` to a proper deactivate + add activate)
  in `UsersController`
- Add route `post :toggle_active, on: :member`
- Add toggle button to `app/views/users/show.html.erb` (conditionally by `active?` state)
- Add Pundit authorization in `UserPolicy`

---

### 3. Harvest index for admins and producers is unimplemented

**Old MVP:** `GET /harvests` listed all harvests per offering, allowing managers to see
who selected what.

**Current:** `HarvestPolicy#index?` grants access to admin and producer, but
`HarvestsController` excludes the `index` action entirely (`except: [:index, :destroy]`).
The route does not exist.

**Files to modify:**
- Nest harvests under offerings: `GET /offerings/:offering_id/harvests`
- Add `index` action to `HarvestsController`, scoped to `@offering.harvests`
- Add route: `resources :offerings do; resources :harvests, only: [:index]; end`
- Add view `app/views/harvests/index.html.erb` — show supporter name, products chosen,
  total items per harvest, and a summary row with totals per product
- Link from `app/views/offerings/show.html.erb` ("Ver pedidos")

---

### 4. Supporters cannot cancel their harvest

**Old MVP:** `DELETE /harvests/:id` let supporters destroy their own harvest if the
offering was still open.

**Current:** `destroy` is excluded from `HarvestsController`. Once a supporter submits
their harvest, they cannot cancel it (only edit individual amounts).

**Files to modify:**
- Add `destroy` action to `HarvestsController`
- Add route
- Add Pundit rule: supporter can destroy their own harvest only while offering is open
- Add cancel button to `app/views/harvests/show.html.erb`

---

## UI / UX Gaps

### 6. Users index doesn't show subscription info for supporters

**Old MVP:** The supporters table showed: name, location, items_per_harvest, status.

**Current:** The users index renders `_user` partial which shows name/email/role/active
only. Subscription info (location, item limit) is only visible on the individual `show`
page.

**Files to modify:**
- Update `app/views/users/_user.html.erb` to conditionally show location and item limit
  when `user.supporter?` and `user.subscription` is present
- Or add a dedicated supporters filter/tab in the users index

---

### 7. Offering index has no status column

**Old MVP:** The offerings index showed a "Status" column with values:
`Encerrada` / `Publicada` / `Não publicada`.

**Current:** The offerings index does not display whether an offering is open, upcoming,
or closed.

**Files to modify:**
- Add a `status` or helper method on `Offering` (e.g. `open?`, `upcoming?`, `closed?`)
- Update `app/views/offerings/index.html.erb` to display status badge per offering

---

### 8. "Copy from previous offering" feature has no UI entry point

**Current:** `OfferingsController#new` already handles a `from_id` param — it
pre-populates the new offering with the source's location and products. This is fully
implemented server-side.

**Gap:** No link or button in the views exposes this. Users cannot discover or use
the copy feature.

**Files to modify:**
- Add a "Copiar oferenda" button to `app/views/offerings/show.html.erb` or
  `app/views/offerings/index.html.erb` that links to
  `new_offering_path(from_id: offering.id)`

---

## Checklist

| # | Feature | Priority | Status |
|---|---------|----------|--------|
| 1 | User password change | High | ⬜ To do |
| 2 | User re-activation (toggle_active) | High | ⬜ To do |
| 3 | Harvest index for admin/producer | High | ⬜ To do |
| 4 | Harvest cancellation by supporter | Medium | ⬜ To do |
| 5 | Users index shows subscription info | Low | ⬜ To do |
| 6 | Offering status in index | Low | ⬜ To do |
| 7 | Copy offering — UI entry point | Low | ✅ Already done |
