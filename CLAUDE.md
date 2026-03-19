# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

CSA Recife's offering management system — allows farmers to post weekly product offerings and supporters (members) to select what they'll pick up. Supports multiple pickup locations and multi-tenant organizations.

## Development Commands

```bash
# Start development (runs server + Tailwind watcher)
foreman start -f Procfile.dev

# Or separately:
rails server
bin/rails tailwindcss:watch

# Run all tests
rails test

# Run a single test file
rails test test/models/user_test.rb

# Run a specific test by line number
rails test test/models/user_test.rb:42

# Run system tests (requires Chrome/Selenium)
rails test:system

# Reset test DB and run tests
rails test:db

# Linting
rubocop
```

## Architecture

**Stack:** Rails 7.1 · PostgreSQL · Hotwire (Stimulus + Turbo) · Tailwind CSS · Importmap (no Node build step)

**Multi-tenancy:** `acts_as_tenant :organization` — all models are scoped to an organization. Tenant is set via session in `ApplicationController`.

**Authentication:** Session-based with bcrypt. `require_login` before filter on protected controllers. No tokens/API auth.

**Authorization:** Pundit policies in `app/policies/`. `ApplicationPolicy` defaults to admin-only; individual policies override for supporter and producer roles.

**Three user roles:**
- `supporter` — selects products from open offerings at their assigned location
- `admin` — manages offerings, products, locations, and users
- `producer` — uploads/manages products

### Core Domain Model

```
Organization (tenant root)
└── Offering (weekly window with opens_at/closes_at)
    ├── OfferedProduct (product + available amount in that offering)
    └── Harvest (a supporter's selections for that offering)
        └── HarvestedProduct (item chosen: links OfferedProduct + amount)

Location → has one open Offering at a time (via current_offering)
User (supporter) → belongs to Location → sees that location's current Offering
```

`OfferedProduct#available_amount` = total amount minus already-harvested amounts.

### Frontend

Stimulus controllers live in `app/javascript/controllers/`:
- `counter_controller.js` — increment/decrement with availability checking (reads `data-available` attribute)
- `nested_form_controller.js` — wraps `@stimulus-components/rails-nested-form` for dynamic nested fields

### Testing

Framework: Minitest with SimpleCov coverage (enabled by default).

Fixtures use password `'secret'` for all users. Login helper in tests:
```ruby
post session_url, params: { session: { email: user.email, password: 'secret' } }
# or use the helper:
log_in_as(user)
```

Parallel testing is disabled due to SimpleCov conflicts (see `test_helper.rb`).
