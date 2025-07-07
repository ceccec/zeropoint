# Component-Specific Best Practices

## 🎯 **Training & Learning Approach**
This guide uses the **simplest, most efficient** approach for learning:
- **One rule per component** - Easy to remember and apply
- **Copy-paste ready** - Direct implementation examples
- **Context-specific** - Tailored to each component's purpose
- **Progressive complexity** - Start simple, add features as needed

---

## 📁 **Controllers**

### Gateway Controller (`app/controllers/zeropoint/gateway_controller.rb`)
```ruby
# RULE: Single gateway for all API operations
class GatewayController < ApplicationController
  # Always generate UUID for traceability
  def execute
    request_uuid = generate_request_uuid
    # Route to service, format response, handle errors
  end
end
```

### GraphQL Controller (`app/controllers/zeropoint/graphql_controller.rb`)
```ruby
# RULE: Use consciousness-aware context for all GraphQL operations
class GraphqlController < ApplicationController
  def execute
    context = build_consciousness_context(uuid)
    # Execute with caching, format with Uroboros extensions
  end
end
```

---

## 🔧 **Concerns**

### Consciousness Aware (`app/concerns/zeropoint/consciousness_aware.rb`)
```ruby
# RULE: Apply golden ratio optimization to all data
module ConsciousnessAware
  def apply_consciousness_optimization(data)
    return data unless consciousness_enabled?
    apply_golden_ratio_optimization(data)
  end
end
```

### Vortex Aware (`app/concerns/zeropoint/vortex_aware.rb`)
```ruby
# RULE: Transform UUIDs based on vortex state
module VortexAware
  def apply_vortex_transformation(uuid, state)
    case state
    when :consciousness then transform_to_consciousness_uuid(uuid)
    when :flowing then transform_to_flowing_uuid(uuid)
    else uuid
    end
  end
end
```

### Observer Aware (`app/concerns/zeropoint/observer_aware.rb`)
```ruby
# RULE: Track observer influence after every action
module ObserverAware
  after_action :track_observer_influence
  
  def track_observer_influence
    @observer_influence = {
      timestamp: Time.current,
      request_pattern: extract_request_pattern
    }
  end
end
```

---

## 🧠 **Core Components**

### UUID Matrix (`lib/zeropoint/core/uuid_matrix.rb`)
```ruby
# RULE: Generate pattern-encoded UUIDs for optimal caching
class UuidMatrix
  def self.generate_stimulus_uuid(context)
    # Generate UUID with pattern encoding for cache efficiency
  end
end
```

### Vortex System (`lib/zeropoint/vortex.rb`)
```ruby
# RULE: Use unified caching with pattern-encoded keys
class UUIDCache
  def generate_cached_uuid(pattern, context = {})
    cache_key = generate_cache_key(pattern, context)
    @cache.fetch_or_store(cache_key) { generate_quantum_uuid(pattern, context) }
  end
end
```

---

## 🎛️ **Configuration**

### Main Configuration (`lib/zeropoint/configuration.rb`)
```ruby
# RULE: Use environment variables for all configurable settings
class Configuration
  config_accessor :consciousness_aware_errors, default: true
  config_accessor :vortex_enabled, default: true
  config_accessor :golden_ratio_optimization, default: true
end
```

### Application Config (`config/application.rb`)
```ruby
# RULE: Auto-detect API-only mode based on routes
initializer "zeropoint.api_only_detection" do |app|
  root_defined = app.routes.routes.any? { |route| route.name == 'root' }
  app.config.api_only = !root_defined
end
```

---

## 🧪 **Services**

### Cache Service (`lib/zeropoint/cache/redis_cache.rb`)
```ruby
# RULE: Always use pattern-encoded keys with TTL
class RedisCache
  def set(key, value, ttl = 3600)
    @redis.setex(full_key(key), ttl, serialize_value(value))
  end
end
```

### Git Learning (`lib/zeropoint/intelligence/git_learning.rb`)
```ruby
# RULE: Use single gateway API for all operations
class GitLearning
  def analyze_commit_patterns
    # Use /zeropoint gateway for caching and unified access
  end
end
```

---

## 🎨 **Views & Templates**

### GraphQL Playground (`app/views/zeropoint/graphql/playground.html.erb`)
```erb
<!-- RULE: Include consciousness-aware context in all views -->
<script>
  window.consciousnessContext = {
    enabled: <%= Zeropoint.config.consciousness_aware_errors %>,
    goldenRatio: <%= Zeropoint.config.golden_ratio_optimization %>
  };
</script>
```

### Main Pages (`app/views/zeropoint/pages/index.html.erb`)
```erb
<!-- RULE: Use I18n for all user-facing strings -->
<h1><%= t('zeropoint.pages.title') %></h1>
<p><%= t('zeropoint.pages.description') %></p>
```

---

## 🔄 **Initializers**

### Zeropoint Initializer (`config/initializers/zeropoint.rb`)
```ruby
# RULE: Load configuration from YAML with environment-specific settings
Zeropoint.configure do |config|
  config_file = Rails.root.join('config', 'zeropoint.yml')
  yaml_config = YAML.load_file(config_file)[Rails.env] || {}
  # Apply configuration
end
```

---

## 🧪 **Testing**

### RSpec Configuration (`spec/spec_helper.rb`)
```ruby
# RULE: Use custom matchers for domain-specific assertions
RSpec::Matchers.define :be_consciousness_aware do
  match { |actual| actual.respond_to?(:consciousness_context) }
end
```

### Vortex Tests (`spec/vortex/vortex_spec.rb`)
```ruby
# RULE: Test all vortex transformations and cache efficiency
RSpec.describe Vortex::UUIDCache do
  it 'transforms UUIDs based on vortex state' do
    uuid = cache.generate_cached_uuid(:test, { id: 1 })
    transformed = cache.apply_vortex_transformation(uuid, :consciousness)
    expect(transformed).to match(/^[0-9a-f]{8}-[0-9a-f]{4}-5[0-9a-f]{3}-[0-9a-f]{4}-[0-9a-f]{12}$/i)
  end
end
```

---

## 🚀 **Generators**

### Install Generator (`lib/generators/zeropoint/install_generator.rb`)
```ruby
# RULE: Generate all necessary files with proper Rails conventions
class InstallGenerator < Rails::Generators::Base
  def install
    copy_initializer
    copy_concerns
    copy_controllers
    copy_views
    copy_routes
  end
end
```

---

## 📊 **Helpers**

### Language Helper (`app/helpers/zeropoint/language_helper.rb`)
```ruby
# RULE: Use I18n with fallbacks for all language operations
module LanguageHelper
  def current_language
    I18n.locale
  end
  
  def switch_language_link(locale)
    link_to t("languages.#{locale}"), url_for(locale: locale)
  end
end
```

---

## 🔧 **Middleware**

### Language Detection (`app/middleware/zeropoint/language_detection_middleware.rb`)
```ruby
# RULE: Detect language from headers, params, or cookies
class LanguageDetectionMiddleware
  def call(env)
    locale = detect_locale(env)
    I18n.locale = locale
    @app.call(env)
  end
end
```

---

## 🎯 **Quick Reference Rules**

### **Controllers**
- ✅ Generate UUID for every request
- ✅ Use consciousness-aware context
- ✅ Apply vortex transformations
- ✅ Track observer influence

### **Concerns**
- ✅ Apply golden ratio optimization
- ✅ Transform UUIDs by vortex state
- ✅ Track observer influence after actions

### **Core Components**
- ✅ Use pattern-encoded UUIDs
- ✅ Implement unified caching
- ✅ Apply quantum encryption

### **Configuration**
- ✅ Use environment variables
- ✅ Auto-detect features
- ✅ Load from YAML files

### **Services**
- ✅ Use pattern-encoded cache keys
- ✅ Implement single gateway API
- ✅ Apply consciousness-aware logic

### **Testing**
- ✅ Test all transformations
- ✅ Use custom matchers
- ✅ Verify cache efficiency

### **Views**
- ✅ Include consciousness context
- ✅ Use I18n for all strings
- ✅ Apply golden ratio layout

---

## 🚀 **Implementation Checklist**

### **Phase 1: Core Setup**
- [ ] Configure Zeropoint with environment variables
- [ ] Set up API-only detection
- [ ] Implement consciousness-aware concerns
- [ ] Add vortex transformations

### **Phase 2: API Gateway**
- [ ] Create single gateway controller
- [ ] Implement UUID generation
- [ ] Add error handling
- [ ] Set up observer tracking

### **Phase 3: Caching & Performance**
- [ ] Configure Redis cache
- [ ] Implement pattern-encoded keys
- [ ] Add cache efficiency metrics
- [ ] Set up vortex caching

### **Phase 4: Testing & Documentation**
- [ ] Write RSpec tests
- [ ] Add custom matchers
- [ ] Document all components
- [ ] Create usage examples

---

## 🎓 **Learning Path**

### **Week 1: Foundation**
1. Understand the single gateway pattern
2. Learn UUID matrix system
3. Practice consciousness-aware programming
4. Master vortex transformations

### **Week 2: Implementation**
1. Set up configuration system
2. Implement caching strategies
3. Add observer tracking
4. Create test suites

### **Week 3: Advanced Features**
1. Integrate Git learning
2. Add quantum encryption
3. Implement golden ratio optimization
4. Master Uroboros patterns

### **Week 4: Production Ready**
1. Performance optimization
2. Security hardening
3. Documentation completion
4. Deployment preparation

---

**Remember**: Start simple, add complexity gradually, and always follow the one-rule-per-component principle for maximum learning efficiency. 