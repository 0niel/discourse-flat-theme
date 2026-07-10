import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { service } from "@ember/service";
import { themePrefix } from "virtual:theme";
import { ajax } from "discourse/lib/ajax";
import icon from "discourse/ui-kit/helpers/d-icon";
import { i18n } from "discourse-i18n";

// A useful-info right rail shown beside the topic list on the homepage.
// Layout is handled in _right-rail.scss (CSS grid on #main-outlet).
export default class MfInfoRail extends Component {
  static shouldRender(args) {
    if (settings.show_info_rail === false) {
      return false;
    }
    return !args?.category && !args?.tag;
  }

  @service site;

  @tracked stats = null;

  constructor() {
    super(...arguments);
    this.#load();
  }

  async #load() {
    try {
      const data = await ajax("/about.json");
      this.stats = data?.about?.stats || null;
    } catch {
      /* non-critical */
    }
  }

  get pulse() {
    const s = this.stats;
    if (!s) {
      return [];
    }
    return [
      {
        icon: "fire",
        value: s.posts_last_day ?? 0,
        label: i18n(themePrefix("rail.posts_today")),
      },
      {
        icon: "plus",
        value: s.topics_last_day ?? 0,
        label: i18n(themePrefix("rail.topics_today")),
      },
      {
        icon: "users",
        value: s.active_users_7_days ?? 0,
        label: i18n(themePrefix("rail.active_week")),
      },
    ];
  }

  get topTags() {
    const tags =
      this.site.top_tags || this.site.navigation_menu_site_top_tags || [];
    return tags
      .map((t) => {
        const name = typeof t === "string" ? t : t?.name || t?.id || t?.text;
        return name
          ? { name: `${name}`, href: `/tag/${encodeURIComponent(name)}` }
          : null;
      })
      .filter(Boolean)
      .slice(0, 12);
  }

  get quickLinks() {
    const raw = (settings.rail_links || "").trim();
    if (raw) {
      return raw
        .split("|")
        .map((pair) => {
          const [label, href] = pair.split(",").map((x) => (x || "").trim());
          return label && this.#safeHref(href) ? { label, href } : null;
        })
        .filter(Boolean);
    }
    return [
      {
        label: i18n(themePrefix("rail.all_categories")),
        href: "/categories",
      },
      {
        label: i18n(themePrefix("rail.help")),
        href: "/c/emergency-help/10",
      },
      {
        label: i18n(themePrefix("rail.resources")),
        href: "/c/resourcers/5",
      },
      {
        label: i18n(themePrefix("rail.about")),
        href: "/c/site-feedback/2",
      },
    ];
  }

  #safeHref(href) {
    return (
      typeof href === "string" &&
      (href.startsWith("/") ||
        href.startsWith("https://") ||
        href.startsWith("http://"))
    );
  }

  <template>
    <aside class="mf-info-rail">
      <div class="mf-rail-card mf-rail-cta">
        <h4>{{i18n (themePrefix "rail.ask_title")}}</h4>
        <p>{{i18n (themePrefix "rail.ask_body")}}</p>
        <a class="btn btn-primary" href="/new-topic">
          {{icon "plus"}}<span>{{i18n (themePrefix "rail.create_topic")}}</span>
        </a>
      </div>

      {{#if this.pulse.length}}
        <div class="mf-rail-card">
          <h4 class="mf-rail-title">{{i18n
              (themePrefix "rail.pulse_title")
            }}</h4>
          <ul class="mf-rail-pulse">
            {{#each this.pulse as |p|}}
              <li>
                <span class="mf-rail-pulse__icon">{{icon p.icon}}</span>
                <span class="mf-rail-pulse__value">{{p.value}}</span>
                <span class="mf-rail-pulse__label">{{p.label}}</span>
              </li>
            {{/each}}
          </ul>
        </div>
      {{/if}}

      {{#if this.topTags.length}}
        <div class="mf-rail-card">
          <h4 class="mf-rail-title">{{i18n
              (themePrefix "rail.tags_title")
            }}</h4>
          <div class="mf-rail-tags">
            {{#each this.topTags as |tag|}}
              <a class="mf-rail-tag" href={{tag.href}}>{{tag.name}}</a>
            {{/each}}
          </div>
        </div>
      {{/if}}

      <div class="mf-rail-card">
        <h4 class="mf-rail-title">{{i18n (themePrefix "rail.links_title")}}</h4>
        <ul class="mf-rail-links">
          {{#each this.quickLinks as |link|}}
            <li>
              <a href={{link.href}}>
                {{icon "arrow-right"}}<span>{{link.label}}</span>
              </a>
            </li>
          {{/each}}
        </ul>
      </div>
    </aside>
  </template>
}
