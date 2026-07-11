# Mirea Flat

Плоская адаптивная тема для [Mirea Ninja](https://mirea.ninja) на актуальном API Discourse. Визуальный язык основан на спокойных поверхностях, компактной типографике и ясных состояниях — без декоративных градиентов, стекла и лишних разделителей.

## Что меняет тема

- Компактный hero с поиском и быстрым переходом в популярные категории.
- Полезный sticky rail справа на широких экранах: создание темы, активность, теги и ссылки.
- Сканируемая лента тем, категории, топики, composer, профили, модальные окна и `/resources`.
- Светлая и тёмная палитры на основе стандартных CSS-переменных Discourse.
- Видимые `focus-visible` состояния, `prefers-reduced-motion` и адаптивность без уменьшения корневого размера шрифта.
- Русская и английская runtime-локализация.

## Структура

```text
about.json
settings.yml
common/common.scss
mobile/mobile.scss
stylesheets/_*.scss
javascripts/discourse/
  api-initializers/mf-init.js
  connectors/discovery-list-container-top/
locales/en.yml
locales/ru.yml
```

`common/common.scss` — основной entrypoint Discourse. В нём находятся общие стили и width-based responsive-композиции, поэтому узкое окно и webview получают тот же качественный UI, что и телефон.

`mobile/mobile.scss` загружается только для штатного `mobile-view` Discourse и содержит platform-only исправления для отличающегося мобильного DOM. Такой гибрид соответствует актуальной рекомендации Discourse: breakpoints держать в common CSS, а отдельный mobile entrypoint использовать только там, где разметка действительно различается.

## Настройки темы

| Настройка           | Назначение                                                   |
| ------------------- | ------------------------------------------------------------ |
| `show_hero`         | Показывает компактный hero на discovery-страницах            |
| `show_info_rail`    | Показывает правый rail на широких экранах                    |
| `rail_links`        | Задаёт ссылки в формате `Название,/path \| Название,/path2` |
| `hero_subtitle`     | Меняет подзаголовок hero                                     |
| `accent_color`      | Переопределяет акцентный CSS-цвет                            |
| `content_max_width` | Ограничивает ширину основного контента                       |
| `ui_radius`         | Масштабирует радиусы интерфейса                              |

## Разработка

Требуются Node.js 22+, pnpm 10+ и актуальный [`discourse_theme`](https://meta.discourse.org/t/install-the-discourse-theme-cli-console-app-to-help-you-build-themes/82950).

```powershell
pnpm install
pnpm lint
discourse_theme watch .
```

Для одноразовой синхронизации с уже настроенным форумом:

```powershell
discourse_theme upload .
```

API-ключи хранятся только в локальном credential store `~/.discourse_theme` и не должны попадать в репозиторий.

## Проверка перед публикацией

1. `pnpm install --frozen-lockfile` и `pnpm lint`.
2. Preview темы на `/latest`, `/categories`, `/resources`, в категории и топике.
3. Desktop и mobile, светлая и тёмная палитры, anonymous и authenticated состояния.
4. Клавиатурная навигация, browser console и `/safe-mode` fallback.
5. Только после preview-smoke обновление production remote theme.

CI использует официальный reusable workflow `discourse-theme.yml@v1`.

## Лицензия

MIT — см. [LICENSE](LICENSE).
