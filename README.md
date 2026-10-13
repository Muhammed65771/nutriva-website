# Nutriva AI Website

Marketing and legal site for [nutrivaai.com](https://nutrivaai.com). Static HTML, no build step, deployed on Vercel (`vercel.json`, clean URLs).

## Files
- `index.html` — home page (features, pricing, FAQ)
- `support.html` — support, subscription help, delete-account steps (`/support#delete-account`)
- `privacy.html` — Privacy Policy (`/privacy`, linked from the app and App Store Connect)
- `terms.html` — Terms of Use (`/terms`, linked from the app and App Store Connect)
- `site.css` — shared styles for all public pages: the app's light design tokens and Liquid Glass components. Bump the `?v=` query in the page `<link>` when you change it.
- `qa.html` — internal QA checklist (`/qa`, not indexed)
- `auth-confirm.html`, `confirm.html`, `reset-password.html` — account email flows (keep their scripts unchanged)
- `app-icon.png`, `favicon.png`, `apple-touch-icon.png` — current light app icon and icons generated from it (`app-icon-dark.png` is kept but not used)
