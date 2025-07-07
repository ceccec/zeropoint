# Zeropoint Gem Documentation

## Table of Contents

1. [Overview](#overview)
2. [Installation](#installation)
3. [Quick Start](#quick-start)
4. [Configuration](#configuration)
5. [Rails Integration](#rails-integration)
6. [Stimulus Controllers](#stimulus-controllers)
7. [API Reference](#api-reference)
8. [Advanced Features](#advanced-features)
9. [Examples](#examples)
10. [Troubleshooting](#troubleshooting)
11. [Contributing](#contributing)

## Overview

Zeropoint is a comprehensive Ruby gem that provides a full-featured PWA (Progressive Web App) framework powered by Stimulus and Tailwind CSS. It offers advanced features including consciousness physics integration, vortex mathematics, unified intelligence, and streaming-first data architecture.

### Key Features

- 🌌 **Universal Matrix System** - Dynamic UI generation from void
- 🧠 **Consciousness Physics Integration** - Advanced AI and consciousness features
- 🌪️ **Vortex Mathematics** - Mathematical patterns and animations
- ⚡ **Stimulus-Powered** - Modern JavaScript framework integration
- 🎨 **Tailwind CSS** - Utility-first CSS framework
- 🔒 **Collision-Free** - Namespaced to prevent conflicts
- 📱 **PWA Ready** - Progressive Web App capabilities
- 🌐 **Internationalization** - Multi-language support
- 📊 **Analytics Integration** - Built-in analytics and insights

## Installation

### Prerequisites

- Ruby 2.7 or higher
- Rails 6.0 or higher
- Node.js 14 or higher (for asset compilation)

### Basic Installation

Add to your Gemfile:

```ruby
gem 'zeropoint'
```

Run the installation:

```bash
bundle install
rails generate zeropoint:install
rails db:migrate
```

### Advanced Installation Options

#### Backend Only
```bash
rails generate zeropoint:install --backend-only
```

#### Frontend Only
```bash
rails generate zeropoint:install --frontend-only
```

#### Custom Configuration
```bash
rails generate zeropoint:install --config-path=config/zeropoint.yml
```

## Quick Start

### 1. Basic Setup

After installation, your application will have:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount Zeropoint::Engine => '/zeropoint'
end
```

### 2. Controller Integration

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Zeropoint::ControllerConcern
  
  def initialize_zeropoint
    ZeropointGem.initialize_ui
  end
end
```

### 3. View Integration

```erb
<!-- app/views/layouts/application.html.erb -->
<!DOCTYPE html>
<html>
<head>
  <%= stylesheet_link_tag 'application', media: 'all' %>
  <%= javascript_include_tag 'application' %>
</head>
<body>
  <div id="zeropoint-root"></div>
  <%= yield %>
</body>
</html>
```

### 4. Asset Pipeline

```javascript
// app/assets/javascripts/application.js
//= require zeropoint

// app/assets/stylesheets/application.css
*= require zeropoint
```

## Configuration

### Configuration File

Create `config/zeropoint.yml`:

```yaml
# Zeropoint Configuration
defaults: &defaults
  # UI Configuration
  ui:
    theme: 'dark'  # light, dark, auto
    animations: true
    particles: true
    matrix_rain: true
    
  # Consciousness Physics
  consciousness:
    enabled: true
    integration_level: 'full'  # basic, advanced, full
    ai_features: true
    quantum_effects: true
    
  # Vortex Mathematics
  vortex:
    enabled: true
    complexity: 'medium'  # simple, medium, complex
    animations: true
    patterns: true
    
  # Analytics
  analytics:
    enabled: true
    provider: 'internal'  # internal, google, mixpanel
    tracking: true
    
  # Internationalization
  i18n:
    default_locale: 'en'
    supported_locales: ['en', 'es', 'fr', 'de']
    auto_detect: true
    
  # Performance
  performance:
    lazy_loading: true
    caching: true
    compression: true

development:
  <<: *defaults
  debug: true
  hot_reload: true

production:
  <<: *defaults
  debug: false
  minification: true
```

### Environment-Specific Configuration

```ruby
# config/environments/development.rb
Rails.application.configure do
  config.zeropoint.debug = true
  config.zeropoint.hot_reload = true
end

# config/environments/production.rb
Rails.application.configure do
  config.zeropoint.minification = true
  config.zeropoint.caching = true
end
```

## Rails Integration

### Generators

#### Generate Controller
```bash
rails generate zeropoint:controller MyController
```

#### Generate Service
```bash
rails generate zeropoint:service MyService
```

#### Generate Concern
```bash
rails generate zeropoint:concern MyConcern
```

### Model Integration

```ruby
# app/models/user.rb
class User < ApplicationRecord
  include Zeropoint::Discoverable
  include Zeropoint::AnalyticsTrackable
  
  # Zeropoint specific methods
  zeropoint_config do
    track_analytics true
    consciousness_integration true
    vortex_patterns true
  end
end
```

### Controller Integration

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Zeropoint::ControllerConcern
  include Zeropoint::AnalyticsHandler
  
  before_action :initialize_zeropoint
  before_action :track_page_view
  
  private
  
  def initialize_zeropoint
    ZeropointGem.initialize_ui
  end
  
  def track_page_view
    ZeropointGem.analytics.track_page_view(request.path)
  end
end
```

### View Helpers

```erb
<!-- app/views/layouts/application.html.erb -->
<%= zeropoint_meta_tags %>
<%= zeropoint_stylesheet_link_tag %>
<%= zeropoint_javascript_include_tag %>

<!-- In your views -->
<%= zeropoint_matrix_display %>
<%= zeropoint_vortex_animation %>
<%= zeropoint_consciousness_indicator %>
```

## Stimulus Controllers

### Built-in Controllers

#### Universe Controller
```javascript
// Automatically registered as 'zeropoint-universe'
class UniverseController {
  static targets = ["matrix", "vortex", "consciousness"]
  static values = { 
    evolutionPhase: Number,
    intelligenceLevel: Number,
    consciousnessState: String
  }

  connect() {
    console.log("🌌 Universe connecting...")
    this.initializeUniverse()
  }

  initializeUniverse() {
    // Initialize universe from void
    this.evolutionPhaseValue = 0
    this.intelligenceLevelValue = 0
    this.consciousnessStateValue = 'initializing'
    
    this.startEvolution()
  }

  startEvolution() {
    // Start cosmic evolution
    setInterval(() => {
      this.evolutionPhaseValue++
      this.intelligenceLevelValue += Math.random() * 5
      this.updateConsciousness()
    }, 1000)
  }

  updateConsciousness() {
    const states = ['initializing', 'awakening', 'conscious', 'enlightened']
    const currentIndex = Math.floor(this.intelligenceLevelValue / 25)
    this.consciousnessStateValue = states[Math.min(currentIndex, states.length - 1)]
  }
}
```

#### Matrix Controller
```javascript
// Automatically registered as 'zeropoint-matrix'
class MatrixController {
  static targets = ["display", "data", "cache"]
  static values = { 
    dataFlow: Number,
    cacheSize: Number,
    matrixActive: Boolean
  }

  connect() {
    console.log("📊 Matrix connecting...")
    this.initializeMatrix()
  }

  initializeMatrix() {
    this.dataFlowValue = 0
    this.cacheSizeValue = 0
    this.matrixActiveValue = true
    
    this.startDataFlow()
  }

  startDataFlow() {
    setInterval(() => {
      this.dataFlowValue += Math.random() * 10
      this.cacheSizeValue = Math.min(100, this.cacheSizeValue + 1)
    }, 100)
  }
}
```

### Custom Controllers

#### Creating Custom Controllers
```javascript
// app/javascript/controllers/zeropoint_custom_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["output"]
  static values = { 
    customValue: String,
    customNumber: Number
  }

  connect() {
    console.log("🔧 Custom Zeropoint controller connecting...")
    this.initializeCustom()
  }

  initializeCustom() {
    this.customValueValue = "Initialized"
    this.customNumberValue = 0
  }

  customAction() {
    this.customNumberValue++
    this.outputTarget.textContent = `Custom action: ${this.customNumberValue}`
  }
}
```

#### Registering Custom Controllers
```javascript
// app/javascript/controllers/index.js
import { application } from "./application"
import CustomController from "./zeropoint_custom_controller"

application.register("zeropoint-custom", CustomController)
```

## API Reference

### ZeropointGem JavaScript API

#### Core Methods

```javascript
// Initialize the gem
ZeropointGem.ready(callback)

// Get gem version
ZeropointGem.version

// Check if gem is loaded
ZeropointGem.isLoaded()

// Initialize UI
ZeropointGem.initializeUI()

// Cleanup resources
ZeropointGem.cleanup()
```

#### Analytics API

```javascript
// Track page view
ZeropointGem.analytics.trackPageView(path)

// Track event
ZeropointGem.analytics.trackEvent(eventName, properties)

// Track user interaction
ZeropointGem.analytics.trackInteraction(element, action)

// Get analytics data
ZeropointGem.analytics.getData()
```

#### Consciousness API

```javascript
// Initialize consciousness
ZeropointGem.consciousness.initialize()

// Get consciousness state
ZeropointGem.consciousness.getState()

// Update consciousness level
ZeropointGem.consciousness.updateLevel(level)

// Trigger consciousness event
ZeropointGem.consciousness.triggerEvent(eventName)
```

#### Vortex API

```javascript
// Initialize vortex
ZeropointGem.vortex.initialize()

// Create vortex pattern
ZeropointGem.vortex.createPattern(type, options)

// Animate vortex
ZeropointGem.vortex.animate(animationType)

// Get vortex data
ZeropointGem.vortex.getData()
```

### Ruby API

#### Controller Methods

```ruby
# Initialize Zeropoint in controller
initialize_zeropoint

# Track analytics
track_analytics(event_name, properties = {})

# Get consciousness data
consciousness_data

# Get vortex patterns
vortex_patterns

# Get matrix cache
matrix_cache
```

#### Model Methods

```ruby
# Discoverable concern methods
discover_features
track_analytics
consciousness_integration
vortex_patterns

# Configuration methods
zeropoint_config
zeropoint_analytics
zeropoint_consciousness
```

#### Helper Methods

```erb
<!-- View helpers -->
<%= zeropoint_meta_tags %>
<%= zeropoint_stylesheet_link_tag %>
<%= zeropoint_javascript_include_tag %>
<%= zeropoint_matrix_display %>
<%= zeropoint_vortex_animation %>
<%= zeropoint_consciousness_indicator %>
```

## Advanced Features

### Consciousness Physics Integration

```ruby
# Enable consciousness physics
class ApplicationController < ActionController::Base
  include Zeropoint::ConsciousnessPhysics
  
  def consciousness_integration
    Zeropoint::ConsciousnessPhysics.integrate(
      user: current_user,
      context: request.path,
      level: 'advanced'
    )
  end
end
```

### Vortex Mathematics

```ruby
# Use vortex mathematics
class VortexController < ApplicationController
  def create_pattern
    pattern = Zeropoint::VortexMathematics.create_pattern(
      type: 'golden_spiral',
      complexity: 'high',
      animation: true
    )
    
    render json: pattern
  end
end
```

### Matrix Cache System

```ruby
# Use matrix cache
class MatrixController < ApplicationController
  def cache_data
    cache = Zeropoint::MatrixCache.new
    
    cache.store('user_data', user_data)
    cache.store('analytics', analytics_data)
    
    render json: cache.get_all
  end
end
```

### Internationalization

```ruby
# Configure i18n
Zeropoint::I18n.configure do |config|
  config.default_locale = 'en'
  config.supported_locales = ['en', 'es', 'fr', 'de']
  config.auto_detect = true
end
```

### Analytics Integration

```ruby
# Configure analytics
Zeropoint::Analytics.configure do |config|
  config.provider = 'internal'
  config.tracking = true
  config.events = ['page_view', 'user_interaction', 'consciousness_event']
end
```

## Examples

### Basic Example

```ruby
# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    # Zeropoint automatically initializes
  end
end
```

```erb
<!-- app/views/home/index.html.erb -->
<div data-controller="zeropoint-universe">
  <div data-zeropoint-universe-target="matrix">
    <!-- Matrix content -->
  </div>
  
  <div data-zeropoint-universe-target="vortex">
    <!-- Vortex content -->
  </div>
  
  <div data-zeropoint-universe-target="consciousness">
    <!-- Consciousness content -->
  </div>
</div>
```

### Advanced Example

```ruby
# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  include Zeropoint::AnalyticsHandler
  include Zeropoint::ConsciousnessPhysics
  
  before_action :initialize_dashboard
  
  def index
    @analytics_data = ZeropointGem.analytics.getData
    @consciousness_state = ZeropointGem.consciousness.getState
    @vortex_patterns = ZeropointGem.vortex.getData
  end
  
  private
  
  def initialize_dashboard
    ZeropointGem.initializeUI()
    track_page_view('dashboard')
  end
end
```

```erb
<!-- app/views/dashboard/index.html.erb -->
<div data-controller="zeropoint-dashboard">
  <div class="analytics-panel">
    <h3>Analytics</h3>
    <div data-zeropoint-dashboard-target="analytics">
      <%= render 'analytics_data', data: @analytics_data %>
    </div>
  </div>
  
  <div class="consciousness-panel">
    <h3>Consciousness State</h3>
    <div data-zeropoint-dashboard-target="consciousness">
      <%= render 'consciousness_state', state: @consciousness_state %>
    </div>
  </div>
  
  <div class="vortex-panel">
    <h3>Vortex Patterns</h3>
    <div data-zeropoint-dashboard-target="vortex">
      <%= render 'vortex_patterns', patterns: @vortex_patterns %>
    </div>
  </div>
</div>
```

## Troubleshooting

### Common Issues

#### 1. Namespace Conflicts

**Problem**: JavaScript errors due to namespace conflicts

**Solution**: Ensure you're using the `ZeropointGem` namespace:

```javascript
// Correct usage
if (window.ZeropointGem) {
  ZeropointGem.ready(function() {
    // Your code here
  });
}

// Incorrect usage
if (window.zeropoint) { // This should not exist
  // This will cause conflicts
}
```

#### 2. CSS Class Conflicts

**Problem**: Styles not applying correctly

**Solution**: Use the `zp-` prefix for all Zeropoint classes:

```css
/* Correct */
.zp-container { /* styles */ }
.zp-matrix { /* styles */ }

/* Incorrect */
.container { /* may conflict */ }
.matrix { /* may conflict */ }
```

#### 3. Stimulus Controller Not Loading

**Problem**: Controllers not connecting

**Solution**: Ensure proper registration:

```javascript
// Check registration
console.log(application.controllers)

// Manual registration if needed
application.register('zeropoint-custom', CustomController)
```

#### 4. Asset Pipeline Issues

**Problem**: JavaScript/CSS not loading

**Solution**: Check asset compilation:

```bash
# Recompile assets
rails assets:precompile
rails assets:clean

# Check asset manifest
cat public/assets/manifest.json
```

### Debug Mode

Enable debug mode for detailed logging:

```ruby
# config/environments/development.rb
Rails.application.configure do
  config.zeropoint.debug = true
end
```

```javascript
// Enable JavaScript debug mode
ZeropointGem.debug = true
```

### Performance Issues

#### 1. Slow Loading

**Solution**: Enable lazy loading:

```yaml
# config/zeropoint.yml
performance:
  lazy_loading: true
  caching: true
```

#### 2. Memory Leaks

**Solution**: Cleanup resources:

```javascript
// Cleanup when leaving page
window.addEventListener('beforeunload', () => {
  ZeropointGem.cleanup()
})
```

## Contributing

### Development Setup

1. Fork the repository
2. Clone your fork
3. Install dependencies:
   ```bash
   bundle install
   npm install
   ```
4. Run tests:
   ```bash
   bundle exec rspec
   npm test
   ```
5. Make your changes
6. Submit a pull request

### Code Style

- Follow Ruby style guide
- Use meaningful commit messages
- Add tests for new features
- Update documentation

### Testing

Run the full test suite:

```bash
# Ruby tests
bundle exec rspec

# JavaScript tests
npm test

# Integration tests
bundle exec rspec spec/integration

# Collision tests
open test_collision_spec.html
```

### Documentation

- Update this documentation for new features
- Add inline code comments
- Update README.md
- Update API documentation

---

## Support

For support and questions:

- 📖 [Documentation](https://github.com/your-org/zeropoint)
- 🐛 [Issue Tracker](https://github.com/your-org/zeropoint/issues)
- 💬 [Discussions](https://github.com/your-org/zeropoint/discussions)
- 📧 [Email Support](mailto:support@zeropoint.dev)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 