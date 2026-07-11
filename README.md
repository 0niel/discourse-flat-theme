# Oniel's Flat Theme

A modern, responsive, full Discourse theme focused on clarity, density, and consistent interaction patterns. It provides a calm flat visual system for desktop, Android, and iOS layouts without decorative gradients, glass effects, or unnecessary separators.

## Features

- Responsive topic lists, categories, topic pages, profiles, groups, badges, notifications, composer, authentication, and administration screens.
- Compact discovery hero with search and popular category shortcuts.
- Optional information rail with activity metrics, popular tags, and custom links.
- Shared design tokens and reusable control primitives for tabs, fields, buttons, dialogs, and status banners.
- Light and dark color schemes based on native Discourse color variables.
- Accessible focus states, reduced-motion support, touch-friendly controls, and mobile-specific layout fixes.
- English and Russian translations.

## Installation

In Discourse, open **Admin → Customize → Themes**, select **Install**, and use:

```text
https://github.com/0niel/oniels-flat-theme
```

The theme can also be installed or updated with the official [`discourse_theme`](https://meta.discourse.org/t/install-the-discourse-theme-cli-console-app-to-help-you-build-themes/82950) CLI.

## Theme settings

| Setting             | Description                                            |
| ------------------- | ------------------------------------------------------ |
| `show_hero`         | Shows the compact discovery hero.                      |
| `show_info_rail`    | Shows the information rail on wide layouts.            |
| `rail_links`        | Defines custom links as `Label,/path \| Label,/path2`. |
| `hero_subtitle`     | Overrides the hero subtitle.                           |
| `accent_color`      | Overrides the theme accent color.                      |
| `content_max_width` | Controls the maximum content width.                    |
| `ui_radius`         | Scales interface corner radii.                         |

## Development

Requirements:

- Node.js 22 or newer
- pnpm 10
- A current installation of `discourse_theme`

```bash
pnpm install --frozen-lockfile
pnpm lint
discourse_theme watch .
```

To upload the theme to a configured Discourse instance:

```bash
discourse_theme upload .
```

Discourse API credentials must remain in the local `~/.discourse_theme` credential store and must never be committed.

## Project structure

```text
about.json
settings.yml
common/common.scss
mobile/mobile.scss
stylesheets/_*.scss
javascripts/discourse/
locales/
```

`common/common.scss` is the primary entry point. Responsive behavior that depends on viewport width belongs in the common stylesheets. `mobile/mobile.scss` is reserved for differences in Discourse's mobile-specific DOM.

## Validation

Before publishing a change:

1. Run `pnpm install --frozen-lockfile` and `pnpm lint`.
2. Preview `/latest`, `/categories`, `/resources`, a category, and a topic.
3. Test desktop and mobile layouts in both light and dark color schemes.
4. Test anonymous and authenticated states, keyboard navigation, and reduced motion.
5. Check the browser console and verify the `/safe-mode` fallback.

GitHub Actions uses Discourse's official reusable theme workflow.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for the development and pull request workflow. Security reports should follow [SECURITY.md](SECURITY.md).

## License

[MIT](LICENSE)
