# Project: Missing Use Cases

## What

Implement the use cases described in `docs/product/use_cases.md` that are not yet covered by the app. Six features across three user roles.

## Why

The product spec defines a complete set of use cases. Several have never been implemented or are only partially working. This project closes that gap before the next release.

## Scope

1. **Password recovery** — forgot-password flow with email reset token; Gmail SMTP via Action Mailer. Admin "reset password" for a user triggers the same email.
2. **Offering publish workflow** — offerings have a draft state; they auto-publish when `opens_at` is reached. A manual "publish now / unpublish" toggle lets producers override the schedule.
3. **Print collected items** — improve the existing HTML print view to match the legacy app layout (`csa-recife/app/views/offerings/print.html.erb`). Use browser print CSS (no PDF gem). Accessible to producers and admins.
4. **Admin: full harvest CRUD** — admins can edit and delete any harvest (currently view-only).
5. **Admin: reset user password** — admin triggers an email reset for any user (re-uses the password recovery flow).

## Out of scope

- **Kits** — deferred. At MVP a single combined product is used instead.
- Roles or permissions changes beyond what the above features require.
- Any UI redesign outside the features listed.

## Success criteria

- All five features above have controller tests and model tests (TDD).
- No existing tests broken.
- Password reset email is sent in production via the configured provider.
- Offerings in draft state are not visible to supporters; published ones are.
- Print page renders correctly in browser print dialog.
