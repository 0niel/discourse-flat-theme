# Contributing

Thank you for helping improve Oniel's Flat Theme.

## Development workflow

1. Fork the repository and create a focused branch.
2. Install dependencies with `pnpm install --frozen-lockfile`.
3. Make a small, documented change that follows the existing design tokens and component patterns.
4. Run `pnpm lint`.
5. Test the affected Discourse pages on desktop and mobile in light and dark color schemes.
6. Open a pull request describing the behavior change and validation performed.

Avoid route-specific overrides when a reusable structural selector or design token can solve the same problem safely. Do not commit Discourse API keys, local credentials, screenshots containing private data, generated QA artifacts, or editor-specific files.

## Bug reports

Include the Discourse version, browser and device, theme commit, affected URL type, color scheme, authentication state, reproduction steps, and screenshots when appropriate.
