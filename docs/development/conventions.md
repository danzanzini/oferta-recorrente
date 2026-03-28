# Development Conventions

Patterns and habits this project uses. Follow these to stay consistent.

---

## TDD flow

Each feature commit follows this order:

1. Write a failing test that describes the expected behavior.
2. Implement the minimum code to make it pass.
3. Run the test — confirm green.
4. Commit.

Don't write tests after the fact. If you're implementing and realize you haven't
written the test yet, stop and write it first.

---

## Testing

**Login in tests:** Use the `log_in_as(user)` helper, or the equivalent POST:
```ruby
post session_url, params: { session: { email: user.email, password: 'secret' } }
```
All fixture users have password `'secret'`.

**Fixture naming:** Fixtures for a model live in `test/fixtures/<model>.yml`.
Use descriptive names (`offerings(:open)`, `offerings(:closed_past)`) not generic
ones (`offerings(:one)`).

**Coverage:** SimpleCov runs by default. Parallel testing is disabled (SimpleCov
conflict). Don't re-enable parallel tests without solving this first.

**Test scoping:** Controller tests cover the HTTP layer (status codes, redirects,
authorization). Policy tests cover the Pundit logic in isolation. Keep them separate.

---

## Pundit policies

- `ApplicationPolicy` denies all by default — new actions are secure until explicitly opened.
- Policy method names mirror controller action names: `index?`, `show?`, `create?`, `update?`, `destroy?`.
- Custom actions (e.g. `toggle_active`) get their own policy method: `toggle_active?`.
- Always call `authorize @record` at the top of the action, before any business logic.
- Use `policy(@record).action?` in views to conditionally show UI elements.

---

## Controller patterns

- `before_action :set_<model>` for member actions. Keep it DRY.
- Redirect after mutating actions (`create`, `update`, `destroy`, custom actions).
- Use `notice:` for success, `alert:` for failure flash messages (in Portuguese).
- Never skip `authorize` — Pundit's `verify_authorized` after-action will catch it in tests.
