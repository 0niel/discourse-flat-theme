import Component from "@glimmer/component";
import { themePrefix } from "virtual:theme";
import { block } from "discourse/blocks";
import dIcon from "discourse/ui-kit/helpers/d-icon";
import { i18n } from "discourse-i18n";

@block("theme:flat-theme:rail-cta", {
  description: "Create-topic call to action card",
})
export default class BlockRailCta extends Component {
  <template>
    <div class="block-rail-cta">
      <h4 class="block-rail-cta__title">{{i18n
          (themePrefix "rail.ask_title")
        }}</h4>
      <p class="block-rail-cta__body">{{i18n (themePrefix "rail.ask_body")}}</p>
      <a class="btn btn-primary" href="/new-topic">
        {{dIcon "plus"}}<span>{{i18n (themePrefix "rail.create_topic")}}</span>
      </a>
    </div>
  </template>
}
