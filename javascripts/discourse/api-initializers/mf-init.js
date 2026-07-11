import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  const root = document.documentElement;

  const accent = (settings.accent_color || "").trim();
  if (accent) {
    root.style.setProperty("--mf-accent", accent);
    root.style.setProperty(
      "--mf-accent-hover",
      `color-mix(in srgb, ${accent} 84%, var(--primary))`
    );
    root.style.setProperty(
      "--mf-accent-press",
      `color-mix(in srgb, ${accent} 72%, var(--primary))`
    );
  }

  if (settings.content_max_width) {
    root.style.setProperty(
      "--mf-content-width",
      `${settings.content_max_width}px`
    );
  }

  if (settings.ui_radius != null) {
    root.style.setProperty("--mf-radius-scale", `${settings.ui_radius}`);
  }
});
