import Component from "@glimmer/component";
import { concat } from "@ember/helper";
import { getOwner } from "@ember/owner";
import { themePrefix } from "virtual:theme";
import { block } from "discourse/blocks";
import dBoundAvatarTemplate from "discourse/ui-kit/helpers/d-bound-avatar-template";
import { i18n } from "discourse-i18n";

@block("theme:flat-theme:rail-online", {
  description: "Online users list fed by the whos-online plugin",
})
export default class BlockRailOnline extends Component {
  get onlineService() {
    return getOwner(this).lookup("service:whos-online");
  }

  get users() {
    return (this.onlineService?.users || []).slice(0, 14);
  }

  get count() {
    return this.onlineService?.count ?? this.users.length;
  }

  <template>
    {{#if this.users.length}}
      <div class="block-rail-online">
        <h4 class="block-rail-online__title">
          <span>{{i18n (themePrefix "rail.online_title")}}</span>
          <span class="block-rail-online__count">{{this.count}}</span>
        </h4>
        <div class="block-rail-online__avatars">
          {{#each this.users as |user|}}
            <a
              class="block-rail-online__user"
              href={{concat "/u/" user.username}}
              data-user-card={{user.username}}
              title={{user.username}}
            >
              {{dBoundAvatarTemplate user.avatar_template "small"}}
            </a>
          {{/each}}
        </div>
      </div>
    {{/if}}
  </template>
}
