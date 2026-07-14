import Component from "@glimmer/component";
import { service } from "@ember/service";
import { themePrefix } from "virtual:theme";
import { block } from "discourse/blocks";
import dIcon from "discourse/ui-kit/helpers/d-icon";
import { i18n } from "discourse-i18n";

@block("theme:flat-theme:rail-tags", {
  description: "Popular tags list",
})
export default class BlockRailTags extends Component {
  @service site;

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

  <template>
    {{#if this.topTags.length}}
      <div class="block-rail-tags">
        <h4 class="block-rail-tags__title">{{i18n
            (themePrefix "rail.tags_title")
          }}</h4>
        <div class="block-rail-tags__cloud">
          {{#each this.topTags as |tag|}}
            <a class="block-rail-tags__tag" href={{tag.href}}>{{tag.name}}</a>
          {{/each}}
        </div>
        <a class="block-rail-tags__all" href="/tags">
          <span>{{i18n (themePrefix "rail.all_tags")}}</span>
          {{dIcon "arrow-right"}}
        </a>
      </div>
    {{/if}}
  </template>
}
