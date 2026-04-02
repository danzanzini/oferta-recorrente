# Updates: Missing Use Cases

<!-- Append entries as the project progresses. Newest at the top.
     Each entry: date + short heading + the decision/caveat/finding. -->

## 2026-03-29 — Project opened

Scoped based on gap analysis against `docs/product/use_cases.md`.

Key decisions captured in brief:
- Kits deferred (MVP uses single combined products).
- Print will use browser CSS print, not a PDF gem — matches legacy app approach; avoids heavy dependency.
- Password recovery and admin "reset password" will share the same email token mechanism.
- Offering draft/publish: auto-publish at `opens_at`, with a manual override toggle for producers.
- Email provider: Gmail SMTP via Action Mailer. Credentials stored in Rails credentials/env vars.
