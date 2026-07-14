import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  if (settings.show_topic_excerpts) {
    api.registerValueTransformer("topic-list-item-expand-pinned", () => true);
  }
});
