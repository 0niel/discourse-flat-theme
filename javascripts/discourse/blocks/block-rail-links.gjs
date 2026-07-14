import Component from "@glimmer/component";
import { themePrefix } from "virtual:theme";
import { block } from "discourse/blocks";
import dIcon from "discourse/ui-kit/helpers/d-icon";
import { i18n } from "discourse-i18n";

function safeHref(href) {
  return (
    typeof href === "string" &&
    (href.startsWith("/") ||
      href.startsWith("https://") ||
      href.startsWith("http://"))
  );
}

@block("theme:flat-theme:rail-links", {
  description: "Quick links list",
  args: {
    links: { type: "array" },
  },
})
export default class BlockRailLinks extends Component {
  get links() {
    const configured = (this.args.links || []).filter(
      (link) => link.label && safeHref(link.url)
    );
    if (configured.length) {
      return configured.map((link) => ({
        label: link.label,
        href: link.url,
      }));
    }

    return [
      {
        label: i18n(themePrefix("rail.all_categories")),
        href: "/categories",
      },
      {
        label: i18n(themePrefix("rail.about")),
        href: "/about",
      },
    ];
  }

  <template>
    <div class="block-rail-links">
      <h4 class="block-rail-links__title">{{i18n
          (themePrefix "rail.links_title")
        }}</h4>
      <ul class="block-rail-links__list">
        {{#each this.links as |link|}}
          <li>
            <a href={{link.href}}>
              {{dIcon "arrow-right"}}<span>{{link.label}}</span>
            </a>
          </li>
        {{/each}}
      </ul>
    </div>
  </template>
}
