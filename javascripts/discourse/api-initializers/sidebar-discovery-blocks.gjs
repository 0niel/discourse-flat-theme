import BlockGroup from "discourse/blocks/builtin/block-group";
import { apiInitializer } from "discourse/lib/api";
import BlockRailCta from "../blocks/block-rail-cta";
import BlockRailLinks from "../blocks/block-rail-links";
import BlockRailOnline from "../blocks/block-rail-online";
import BlockRailStats from "../blocks/block-rail-stats";
import BlockRailTags from "../blocks/block-rail-tags";

export default apiInitializer((api) => {
  api.renderBlocks("sidebar-discovery", [
    {
      block: BlockGroup,
      id: "info-rail",
      conditions: [
        { type: "route", pages: ["HOMEPAGE", "TOP_MENU"] },
        { not: { type: "route", urls: ["/categories"] } },
        {
          type: "setting",
          source: settings,
          name: "show_info_rail",
          enabled: true,
        },
        { type: "viewport", min: "xl" },
      ],
      children: [
        { block: BlockRailCta },
        { block: BlockRailOnline },
        { block: BlockRailStats },
        { block: BlockRailTags },
        {
          block: BlockRailLinks,
          args: {
            links: settings.rail_links,
          },
        },
      ],
    },
  ]);
});
