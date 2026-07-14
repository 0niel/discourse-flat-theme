import Component from "@glimmer/component";
import { service } from "@ember/service";
import { themePrefix } from "virtual:theme";
import { block } from "discourse/blocks";
import dIcon from "discourse/ui-kit/helpers/d-icon";
import { i18n } from "discourse-i18n";

@block("theme:flat-theme:hero", {
  description: "Discovery hero with title, search, and quick filters",
  args: {
    subtitle: { type: "string" },
  },
})
export default class BlockHero extends Component {
  @service currentUser;
  @service site;
  @service siteSettings;

  get title() {
    return this.siteSettings.title || this.site.title || "Community";
  }

  get description() {
    return this.args.subtitle || i18n(themePrefix("hero.default_subtitle"));
  }

  get quickFilters() {
    const filters = [
      {
        href: "/top?period=weekly",
        label: i18n(themePrefix("hero.top_week")),
      },
      {
        href: "/latest?max_posts=1",
        label: i18n(themePrefix("hero.unanswered")),
      },
    ];

    if (this.currentUser) {
      filters.unshift(
        { href: "/unread", label: i18n(themePrefix("hero.unread")) },
        { href: "/new", label: i18n(themePrefix("hero.new_topics")) }
      );
    }

    return filters;
  }

  <template>
    <section class="block-hero">
      <div class="block-hero__inner">
        <div class="block-hero__copy">
          <span class="block-hero__eyebrow">{{i18n
              (themePrefix "hero.eyebrow")
            }}</span>
          <h1 class="block-hero__title">{{this.title}}</h1>
          <p class="block-hero__subtitle">{{this.description}}</p>
        </div>

        <div class="block-hero__discovery">
          <form
            class="block-hero__search"
            action="/search"
            method="get"
            role="search"
          >
            {{dIcon "magnifying-glass"}}
            <input
              type="search"
              name="q"
              placeholder={{i18n (themePrefix "hero.search_placeholder")}}
              aria-label={{i18n (themePrefix "hero.search_label")}}
              autocomplete="off"
            />
            <button type="submit" class="btn btn-primary">{{i18n
                (themePrefix "hero.search_action")
              }}</button>
          </form>

          <nav
            class="block-hero__chips"
            aria-label={{i18n (themePrefix "hero.filters_label")}}
          >
            {{#each this.quickFilters as |filter|}}
              <a class="block-hero__chip" href={{filter.href}}>
                {{filter.label}}
              </a>
            {{/each}}
          </nav>
        </div>
      </div>
    </section>
  </template>
}
