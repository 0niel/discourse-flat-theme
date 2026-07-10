import { apiInitializer } from "discourse/lib/api";

// Wires theme settings into runtime CSS custom properties.
export default apiInitializer((api) => {
  const root = document.documentElement;

  const accent = (settings.accent_color || "").trim();
  if (accent) {
    // derive hover/press from the custom accent so buttons/links/tabs keep
    // their interaction feedback (a flat single value kills all state contrast)
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
