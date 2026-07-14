import Component from "@glimmer/component";
import { themePrefix } from "virtual:theme";
import { block } from "discourse/blocks";
import { ajax } from "discourse/lib/ajax";
import { bind } from "discourse/lib/decorators";
import DAsyncContent from "discourse/ui-kit/d-async-content";
import dIcon from "discourse/ui-kit/helpers/d-icon";
import { i18n } from "discourse-i18n";

@block("theme:flat-theme:rail-stats", {
  description: "Recent activity stats from /about.json",
})
export default class BlockRailStats extends Component {
  @bind
  async fetchPulse() {
    let stats;
    try {
      const data = await ajax("/about.json");
      stats = data?.about?.stats;
    } catch {
      return [];
    }

    if (!stats) {
      return [];
    }

    return [
      {
        icon: "fire",
        value: stats.posts_last_day ?? 0,
        label: i18n(themePrefix("rail.posts_today")),
      },
      {
        icon: "plus",
        value: stats.topics_last_day ?? 0,
        label: i18n(themePrefix("rail.topics_today")),
      },
      {
        icon: "users",
        value: stats.active_users_7_days ?? 0,
        label: i18n(themePrefix("rail.active_week")),
      },
    ];
  }

  <template>
    <DAsyncContent @asyncData={{this.fetchPulse}}>
      <:content as |pulse|>
        {{#if pulse.length}}
          <div class="block-rail-stats">
            <h4 class="block-rail-stats__title">{{i18n
                (themePrefix "rail.pulse_title")
              }}</h4>
            <ul class="block-rail-stats__list">
              {{#each pulse as |p|}}
                <li>
                  <span class="block-rail-stats__icon">{{dIcon p.icon}}</span>
                  <span class="block-rail-stats__value">{{p.value}}</span>
                  <span class="block-rail-stats__label">{{p.label}}</span>
                </li>
              {{/each}}
            </ul>
          </div>
        {{/if}}
      </:content>
    </DAsyncContent>
  </template>
}
