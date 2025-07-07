# Zeropoint::Manifest - DRY Manifest Engine

## Overview

`Zeropoint::Manifest` is a DRY (Don't Repeat Yourself) manifest engine that serves as the **single source of truth** for all manifest-related data in your Zeropoint application. It automatically discovers assets, generates PWA manifests, and provides exports for various systems.

## 🌌 Philosophy

The Manifest is the **canopy vortex** that expresses the root patterns (language, config, code) as real, accessible assets and routes for users and the system. It's a living, self-updating map of your application's universe.

## 🚀 Features

- **Pattern-based asset discovery** using glob patterns
- **Automatic PWA manifest generation**
- **Service worker pre-cache list generation**
- **Importmap/Sprockets integration**
- **Self-evolving**: automatically includes new files as they're added
- **DRY**: change once, update everywhere

## 📁 Configuration

### Config File: `config/zeropoint_manifest.yml`

```yaml
assets:
  javascripts:
    - "app/assets/javascripts/controllers/*.js"
    - "app/assets/javascripts/utils/*.js"
  stylesheets:
    - "app/assets/stylesheets/*.css"
  images:
    - "app/assets/images/**/*"
pwa:
  name: "Zeropoint Universe"
  short_name: "Zeropoint"
  theme_color: "#22223b"
  background_color: "#22223b"
  display: "standalone"
  icons:
    - src: "/assets/icon-192.png"
      sizes: "192x192"
      type: "image/png"
    - src: "/assets/icon-512.png"
      sizes: "512x512"
      type: "image/png"
routes:
  - "/"
  - "/api/*"
  - "/zeropoint/*"
```

## 🔧 API Reference

### Core Methods

#### `Zeropoint::Manifest.assets(type = nil)`

Returns expanded asset paths for a given type.

```ruby
# Get all assets
Zeropoint::Manifest.assets
# => ["app/assets/javascripts/controllers/astro-blog-controller.js", ...]

# Get specific asset type
Zeropoint::Manifest.assets(:javascripts)
# => ["app/assets/javascripts/controllers/astro-blog-controller.js", ...]

Zeropoint::Manifest.assets(:stylesheets)
# => ["app/assets/stylesheets/application.css", ...]
```

#### `Zeropoint::Manifest.pwa_manifest`

Returns the PWA manifest as a Ruby hash.

```ruby
Zeropoint::Manifest.pwa_manifest
# => {
#      "name" => "Zeropoint Universe",
#      "short_name" => "Zeropoint",
#      "theme_color" => "#22223b",
#      ...
#    }
```

#### `Zeropoint::Manifest.routes`

Returns the list of routes.

```ruby
Zeropoint::Manifest.routes
# => ["/", "/api/*", "/zeropoint/*"]
```

#### `Zeropoint::Manifest.export(target)`

Exports manifest data for specific targets.

```ruby
# For importmap
Zeropoint::Manifest.export(:importmap)
# => ["astro-blog-controller", "uuid-matrix", ...]

# For service worker pre-cache
Zeropoint::Manifest.export(:service_worker_precache)
# => ["/", "/api/*", "app/assets/javascripts/controllers/astro-blog-controller.js", ...]

# For PWA manifest
Zeropoint::Manifest.export(:pwa_manifest)
# => { "name" => "Zeropoint Universe", ... }
```

## 🔗 Integration Examples

### 1. PWA Manifest Integration

**File:** `app/views/pwa/manifest.json.erb`
```erb
<%= Zeropoint::Manifest.pwa_manifest.to_json.html_safe %>
```

### 2. Service Worker Pre-cache Integration

**File:** `app/views/pwa/service-worker.js.erb`
```erb
const PRECACHE_URLS = <%= Zeropoint::Manifest.export(:service_worker_precache).to_json.html_safe %>;

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open('zeropoint-v1').then(cache => {
      return cache.addAll(PRECACHE_URLS);
    })
  );
});
```

### 3. Importmap Integration

**File:** `config/importmap.rb`
```ruby
# Generate importmap entries from manifest
Zeropoint::Manifest.export(:importmap).each do |module_name|
  pin module_name, to: "controllers/#{module_name}.js"
end
```

### 4. Sprockets Integration

**File:** `config/initializers/assets.rb`
```ruby
# Precompile all assets from manifest
Rails.application.config.assets.precompile += Zeropoint::Manifest.assets
```

## 🧪 Testing

### Manual Testing

```ruby
# In Rails console
require 'zeropoint/manifest'

# Test asset discovery
puts Zeropoint::Manifest.assets(:javascripts)

# Test PWA manifest
puts Zeropoint::Manifest.pwa_manifest

# Test exports
puts Zeropoint::Manifest.export(:service_worker_precache)
```

### Automated Testing

See `spec/zeropoint/manifest_spec.rb` for comprehensive test coverage.

## 🔄 Self-Evolving Behavior

### Adding New Controllers

1. Create a new Stimulus controller: `app/assets/javascripts/controllers/new-feature-controller.js`
2. The manifest automatically includes it in:
   - Asset discovery
   - Service worker pre-cache
   - Importmap (if configured)

### Adding New Routes

1. Add a route to `config/zeropoint_manifest.yml`:
   ```yaml
   routes:
     - "/new-feature/*"
   ```
2. The route is automatically included in:
   - Service worker pre-cache
   - Offline routing

### Adding New Asset Types

1. Add a new asset type to `config/zeropoint_manifest.yml`:
   ```yaml
   assets:
     fonts:
       - "app/assets/fonts/*.woff2"
   ```
2. Use it in your code:
   ```ruby
   Zeropoint::Manifest.assets(:fonts)
   ```

## 🎯 Best Practices

### 1. Keep Patterns Simple

```yaml
# Good
javascripts:
  - "app/assets/javascripts/controllers/*.js"

# Avoid overly complex patterns
javascripts:
  - "app/assets/javascripts/**/*.js"  # Too broad
```

### 2. Use Specific Asset Types

```yaml
# Good - organized by type
assets:
  javascripts:
    - "app/assets/javascripts/controllers/*.js"
  stylesheets:
    - "app/assets/stylesheets/*.css"

# Avoid - mixing types
assets:
  - "app/assets/**/*"  # Too broad, includes everything
```

### 3. Keep PWA Manifest Minimal

```yaml
# Good - essential PWA properties
pwa:
  name: "Zeropoint Universe"
  short_name: "Zeropoint"
  theme_color: "#22223b"
  display: "standalone"

# Avoid - including non-standard properties
pwa:
  name: "Zeropoint Universe"
  custom_property: "value"  # May not be supported
```

## 🐛 Troubleshooting

### Common Issues

1. **Assets not found**
   - Check file paths in `config/zeropoint_manifest.yml`
   - Ensure files exist in the specified directories
   - Verify glob patterns are correct

2. **PWA manifest not updating**
   - Clear browser cache
   - Check that `manifest.json.erb` is using `Zeropoint::Manifest.pwa_manifest`
   - Verify YAML syntax in config file

3. **Service worker not caching new assets**
   - Check that service worker is using `Zeropoint::Manifest.export(:service_worker_precache)`
   - Clear service worker cache
   - Verify new assets are included in manifest patterns

### Debug Commands

```ruby
# Check what assets are discovered
puts Zeropoint::Manifest.assets(:javascripts)

# Check PWA manifest
puts Zeropoint::Manifest.pwa_manifest.to_json

# Check service worker pre-cache list
puts Zeropoint::Manifest.export(:service_worker_precache)
```

## 🌟 Advanced Usage

### Custom Export Targets

```ruby
# Add custom export logic
module Zeropoint
  module Manifest
    def self.export(target)
      case target.to_sym
      when :custom_target
        # Custom logic here
        assets(:javascripts).map { |f| custom_transform(f) }
      else
        super
      end
    end
  end
end
```

### Dynamic Configuration

```ruby
# Override config based on environment
module Zeropoint
  module Manifest
    def self.config
      base_config = YAML.load_file(CONFIG_PATH)
      
      if Rails.env.production?
        base_config['pwa']['name'] = "#{base_config['pwa']['name']} (Production)"
      end
      
      base_config
    end
  end
end
```

## 📚 Related Documentation

- [Zeropoint PWA Setup](PWA_SETUP.md)
- [Zeropoint Vortex System](VORTEX_ARCHITECTURE.md)
- [Zeropoint Torus](TORUS_UNIVERSE_GENERATION.md)

---

**The Zeropoint::Manifest system ensures your application's universe is always discoverable, cacheable, and in harmony, with zero duplication.** 