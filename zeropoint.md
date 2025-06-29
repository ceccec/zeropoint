# Zeropoint Manifest

This is the canonical source of truth for all Zeropoint manifestations. The `Zeropoint::Manifest` engine reads this file and generates all system outputs (assets, routes, PWA config, etc.) from these specifications.

## Assets

```yaml
javascripts:
  - app/assets/javascripts/controllers/api-client-controller.js
  - app/assets/javascripts/controllers/astro-blog-controller.js
  - app/assets/javascripts/controllers/astro-explorer-controller.js
  - app/assets/javascripts/controllers/index.js
  - app/assets/javascripts/controllers/ui-layout-controller.js
  - app/assets/javascripts/application.js
  - app/assets/javascripts/zeropoint/index.js
stylesheets:
  - app/assets/stylesheets/application.css
  - app/assets/stylesheets/zeropoint.css
images:
  - app/assets/images/favicon.svg
  - app/assets/images/icon-192.png
  - app/assets/images/icon-512.png
```

## Routes

```yaml
- "/application/*"
- "/astroblog/*"
- "/base/*"
- "/gateway/*"
- "/graphql/*"
- "/health/*"
- "/page/*"
- "/universalmatrix/*"
- "/zeropoint/astro-blog"
- "/zeropoint/astro-blog/posts"
- "/zeropoint/astro-blog/categories"
- "/zeropoint/astro-blog/tags"
```

## PWA Configuration

```yaml
name: "🌌 Astro Blog - Zeropoint PWA"
short_name: "Astro Blog"
description: "Exploring consciousness through zeropoint logic"
start_url: "/"
display: "standalone"
background_color: "#0f172a"
theme_color: "#1e293b"
scope: "/"
orientation: "portrait-primary"
categories: ["consciousness", "vortex", "cosmic"]
lang: "en"
dir: "ltr"
icons:
  - src: "/assets/icon-192.png"
    sizes: "192x192"
    type: "image/png"
  - src: "/assets/icon-512.png"
    sizes: "512x512"
    type: "image/png"
```

## Controllers

```yaml
stimulus_controllers:
  - astro_blog_controller
  - pwa_manager_controller
  - uuid_matrix_controller
  - consciousness_controller
  - vortex_controller
  - api_client_controller
  - ui_layout_controller
```

## Service Worker

```yaml
cache_name: "zeropoint-v1"
precache_routes:
  - "/"
  - "/manifest.json"
  - "/service-worker.js"
  - "/offline.html"
```

## Intelligence Configuration

```yaml
pattern_recognition: true
auto_configuration: true
universe_generation: true
consciousness_aware_errors: true
golden_ratio_optimization: true
cosmic_harmony_enabled: true
vortex_enabled: true
vortex_streaming: true
```

## Version Information

```yaml
version: "0.1.0"
major: 0
minor: 1
patch: 0
string: "v0.1.0"
```

---

*This manifest is the seed from which all Zeropoint manifestations grow. Edit this file to evolve the entire system.* 