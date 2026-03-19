# Implementation Plan: Bring MVP gaps into oferta-recorrente

## Context

Comparing the old MVP (`csa-recife`) with the current app revealed 7 feature gaps.
Gap #7 (copy offering UI) was found to be already implemented (`offerings/index.html.erb:13`).
This plan implements the remaining 6 gaps, in a TDD-first order from simplest to most
complex, each on its own commit in a new branch.

**Branch:** `feature/mvp-gaps`

---

## Implementation order

### Step 0 — Branch + mark gap #7 done
```bash
git checkout -b feature/mvp-gaps
```
Update `docs/feature_gaps.md`: mark gap #7 (copy offering) as ✅ already done.

Commit: `docs: mark copy-offering gap as resolved`

---

### Step 1 — Gap #6: Offering status label in index

**Why first:** Pure model method + one view line. Good warm-up commit with tests.

**Model — `app/models/offering.rb`**
Add method:
```ruby
def status
  return 'Encerrada'  if Time.zone.now > closes_at
  return 'Agendada'   if Time.zone.now < opens_at
  'Aberta'
end
```

**Test — `test/models/offering_test.rb`**
Three cases using existing fixtures (`offerings(:open)`, `offerings(:closed_past)`,
`offerings(:not_open_yet)`):
```ruby
test 'open offering has status Aberta'
test 'past offering has status Encerrada'
test 'future offering has status Agendada'
```

**View — `app/views/offerings/index.html.erb`** (or the `_offering` partial if it exists)
Add status badge inside the offering card.

Commit: `feat: add status label to offering index (gap #6)`

---

### Step 2 — Gap #5: Users index shows subscription info

**Why here:** Single partial edit, no backend change, no authorization impact.

**View — `app/views/users/_user.html.erb`**
Add conditionally after the role/active lines:
```erb
<% if user.supporter? && user.subscription %>
  <p><strong>Local:</strong> <%= user.location&.name %></p>
  <p><strong>Limite:</strong> <%= user.item_limit %> itens</p>
<% end %>
```

**Test — `test/controllers/users_controller_test.rb`**
Assert the index page body contains the location name for a supporter fixture.

Commit: `feat: show subscription info on users index (gap #5)`

---

### Step 3 — Gap #2: User re-activation (toggle_active)

**Why here:** `User#toggle_active!` already exists in the model.
Only need route, controller action, policy permission, and view button.

**Route — `config/routes.rb`**
```ruby
resources :users do
  member { post :toggle_active }
  resources :subscriptions, only: %i[new create edit update]
end
```

**Policy — `app/policies/user_policy.rb`**
```ruby
def toggle_active?
  user.admin?
end
```

**Controller — `app/controllers/users_controller.rb`**
```ruby
before_action :set_user, only: %i[show edit update destroy toggle_active]

def toggle_active
  authorize @user
  @user.toggle_active!
  redirect_to user_url(@user), notice: @user.active? ? 'Usuário ativado.' : 'Usuário desativado.'
end
```

**View — `app/views/users/show.html.erb`**
Replace the static "Excluir" button with a policy-gated toggle button:
```erb
<% if policy(@user).toggle_active? %>
  <%= button_to @user.active? ? 'Desativar' : 'Ativar',
        toggle_active_user_path(@user),
        method: :post,
        class: @user.active? ? 'btn-danger' : 'btn-primary' %>
<% end %>
```

**Tests — `test/controllers/users_controller_test.rb`**
```ruby
test 'admin can activate a deactivated user'
test 'admin can deactivate an active user'
test 'non-admin cannot toggle active'
```

**Policy test — `test/policies/user_policy_test.rb`** (new file)
```ruby
test 'admin can toggle_active'
test 'supporter cannot toggle_active'
```

Commit: `feat: add toggle_active for users (gap #2)`

---

### Step 4 — Gap #1: User password self-management

**Why here:** Self-contained. No Pundit needed — action operates on `current_user` only.

**Route — `config/routes.rb`**
```ruby
resources :users do
  collection do
    get   :edit_password
    patch :update_password
  end
  member { post :toggle_active }
  resources :subscriptions, only: %i[new create edit update]
end
```

**Controller — `app/controllers/users_controller.rb`**
```ruby
def edit_password
  # renders form bound to current_user
end

def update_password
  if current_user.update(password_params)
    redirect_to root_path, notice: 'Senha alterada com sucesso.'
  else
    render :edit_password, status: :unprocessable_entity
  end
end

private

def password_params
  params.require(:user).permit(:password, :password_confirmation)
end
```

**View — `app/views/users/edit_password.html.erb`** (new file)
`form_with` bound to `current_user`, `url: update_password_users_path`, method PATCH.
Fields: `password_field` + `password_confirmation_field`.

**Home page — `app/views/pages/home.html.erb`**
Add a link to `edit_password_users_path` visible to all logged-in users.

**Tests — `test/controllers/users_controller_test.rb`**
```ruby
test 'should get edit_password'
test 'should update password successfully'
test 'should not update password when confirmation does not match'
test 'unauthenticated user cannot access edit_password'
```

Commit: `feat: allow users to change their own password (gap #1)`

---

### Step 5 — Gap #4: Harvest cancellation by supporter

**Why here:** Small change. The show view already has the delete button
(`harvests/show.html.erb:10`) — just needs the route and controller action to exist.
Also fixes the broken "Voltar" link that points to the non-existent `harvests_path`.

**Route — `config/routes.rb`**
```ruby
# remove :destroy from the except list
resources :harvests, except: %i[index]
```

**Policy — `app/policies/harvest_policy.rb`**
```ruby
def destroy?
  user.supporter? &&
    record.user_id == user.id &&
    record.offering.open?(Time.zone.now)
end
```

**Controller — `app/controllers/harvests_controller.rb`**
```ruby
before_action :set_harvest, only: %i[show edit update destroy]

def destroy
  authorize @harvest
  @harvest.destroy
  redirect_to root_path, notice: 'Pedido cancelado com sucesso.'
end
```

**View — `app/views/harvests/show.html.erb`**
- Fix back link: `harvests_path` → `root_path`
- Wrap the delete button in a policy check and add a confirmation:
```erb
<% if policy(@harvest).destroy? %>
  <%= button_to "Cancelar pedido", @harvest, method: :delete, class: "btn-danger",
        data: { turbo_confirm: "Tem certeza que deseja cancelar seu pedido?" } %>
<% end %>
```

**Tests — `test/controllers/harvests_controller_test.rb`**
```ruby
test 'supporter can cancel own harvest while offering is open'
test 'supporter cannot cancel harvest when offering is closed'
test 'supporter cannot cancel another user harvest'
test 'admin cannot cancel a supporter harvest'
```

**Policy test — `test/policies/harvest_policy_test.rb`** (extend existing file)
```ruby
test 'destroy?: supporter can destroy own open harvest'
test 'destroy?: supporter cannot destroy when offering is closed'
test 'destroy?: admin cannot destroy'
```

Commit: `feat: allow supporters to cancel their harvest (gap #4)`

---

### Step 6 — Gap #3: Harvest index for admin/producer (nested under offering)

**Why last:** Most complex. New route nesting, new controller action, new view.

**Route — `config/routes.rb`**
```ruby
resources :offerings do
  member { get :print }
  resources :harvests, only: %i[index]   # nested: /offerings/:offering_id/harvests
end
resources :harvests, except: %i[index]   # flat: all other CRUD actions
```

**Controller — `app/controllers/harvests_controller.rb`**
```ruby
before_action :set_offering, only: %i[index]

def index
  @harvests = @offering.harvests.includes(harvested_products: :offered_product)
  authorize @harvests
end

private

def set_offering
  @offering = Offering.find(params[:offering_id])
end
```

**View — `app/views/harvests/index.html.erb`** (new file)
- Offering header: location name + open/close window
- Table: one row per harvest — supporter name | items (product + amount) | row total
- Summary footer: totals per product (reuse `total_harvested` from `OfferingsHelper`)

**Offering show — `app/views/offerings/show.html.erb`**
Add a policy-gated link:
```erb
<% if policy(Harvest).index? %>
  <%= link_to "Ver pedidos", offering_harvests_path(@offering), class: "btn-secondary" %>
<% end %>
```

**Tests — `test/controllers/harvests_controller_test.rb`**
```ruby
test 'admin can see harvest index for offering'
test 'producer can see harvest index for managed location'
test 'supporter cannot see harvest index'
test 'harvest index is scoped to the offering'
```

**Policy:** `HarvestPolicy#index?` already returns `admin? || producer?`. No change needed.

Commit: `feat: harvest index nested under offerings for admin/producer (gap #3)`

---

## Files touched (summary)

| File | Steps |
|------|-------|
| `config/routes.rb` | 3, 4, 5, 6 |
| `app/models/offering.rb` | 1 |
| `app/policies/user_policy.rb` | 3 |
| `app/policies/harvest_policy.rb` | 5 |
| `app/controllers/users_controller.rb` | 3, 4 |
| `app/controllers/harvests_controller.rb` | 5, 6 |
| `app/views/offerings/index.html.erb` | 1 |
| `app/views/offerings/show.html.erb` | 6 |
| `app/views/users/_user.html.erb` | 2 |
| `app/views/users/show.html.erb` | 3 |
| `app/views/users/edit_password.html.erb` | 4 (new) |
| `app/views/pages/home.html.erb` | 4 |
| `app/views/harvests/show.html.erb` | 5 |
| `app/views/harvests/index.html.erb` | 6 (new) |
| `test/models/offering_test.rb` | 1 |
| `test/controllers/users_controller_test.rb` | 2, 3, 4 |
| `test/controllers/harvests_controller_test.rb` | 5, 6 |
| `test/policies/user_policy_test.rb` | 3 (new) |
| `test/policies/harvest_policy_test.rb` | 5 |
| `docs/feature_gaps.md` | 0 |

## TDD approach per step

Each step follows: **write failing test → implement → run test → commit.**

## Verification

After all steps:
```bash
rails test                    # full suite must pass
rails test test/models/       # model unit coverage
rails test test/controllers/  # controller integration coverage
rails test test/policies/     # policy unit coverage
```
SimpleCov will report coverage on all new code paths.
