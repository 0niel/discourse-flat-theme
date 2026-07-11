import Component from "@glimmer/component";
import { concat } from "@ember/helper";
import { service } from "@ember/service";
import { trustHTML } from "@ember/template";
import { themePrefix } from "virtual:theme";
import icon from "discourse/ui-kit/helpers/d-icon";
import { i18n } from "discourse-i18n";

export default class MfHero extends Component {
  static shouldRender(args) {
    if (settings.show_hero === false) {
      return false;
    }
    return !args?.category && !args?.tag;
  }

  @service site;
  @service siteSettings;

  get title() {
    return this.siteSettings.title || this.site.title || "Community";
  }

  get description() {
    return settings.hero_subtitle || i18n(themePrefix("hero.default_subtitle"));
  }

  get topCategories() {
    const cats = this.site.categories || [];
    return cats
      .filter(
        (c) =>
          !c.parent_category_id &&
          !c.isUncategorizedCategory &&
          c.id !== this.site.uncategorized_category_id
      )
      .sort((a, b) => (b.topic_count || 0) - (a.topic_count || 0))
      .slice(0, 6);
  }

  <template>
    <section class="mf-hero">
      <div class="mf-hero__inner">
        <div class="mf-hero__copy">
          <span class="mf-hero__eyebrow">{{i18n
              (themePrefix "hero.eyebrow")
            }}</span>
          <h1 class="mf-hero__title">{{this.title}}</h1>
          <p class="mf-hero__subtitle">{{this.description}}</p>
        </div>

        <div class="mf-hero__discovery">
          <form
            class="mf-hero__search"
            action="/search"
            method="get"
            role="search"
          >
            {{icon "magnifying-glass"}}
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

          {{#if this.topCategories.length}}
            <nav
              class="mf-hero__chips"
              aria-label={{i18n (themePrefix "hero.categories_label")}}
            >
              {{#each this.topCategories as |cat|}}
                <a
                  class="mf-hero__chip"
                  href={{concat "/c/" cat.slug "/" cat.id}}
                  style={{trustHTML (concat "--mf-cat:#" cat.color)}}
                >
                  <span class="mf-hero__chip-dot"></span>
                  <span class="mf-hero__chip-name">{{cat.name}}</span>
                  {{#if cat.topic_count}}
                    <span class="mf-hero__chip-count">{{cat.topic_count}}</span>
                  {{/if}}
                </a>
              {{/each}}
            </nav>
          {{/if}}
        </div>
      </div>
    </section>
  </template>
}
