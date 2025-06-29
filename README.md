# Zeropoint 🌌

[![Gem Version](https://badge.fury.io/rb/zeropoint.svg)](https://badge.fury.io/rb/zeropoint)
[![Build Status](https://github.com/zeropoint/zeropoint/workflows/CI/badge.svg)](https://github.com/zeropoint/zeropoint/actions)
[![Code Climate](https://codeclimate.com/github/zeropoint/zeropoint/badges/gpa.svg)](https://codeclimate.com/github/zeropoint/zeropoint)
[![Test Coverage](https://codeclimate.com/github/zeropoint/zeropoint/badges/coverage.svg)](https://codeclimate.com/github/zeropoint/zeropoint/coverage)
[![Documentation](https://img.shields.io/badge/docs-yard-blue.svg)](https://zeropoint.bg/docs)
[![License](https://img.shields.io/badge/license-Zeropoint-void.svg)](LICENSE.en.md)

> A consciousness-aware Rails framework with GraphQL-first architecture and vortex mathematics

Zeropoint is a revolutionary Rails framework that integrates consciousness physics, vortex mathematics, and quantum principles to create a unified, scalable, and self-evolving platform.

## 🌟 Features

- 🌌 **Consciousness-aware computing** with golden ratio optimization
- 🔄 **Vortex mathematics** for optimal data flow and infinite scalability
- 🎯 **GraphQL-first API** with batch loading and query persistence
- 🌍 **Internationalization** with cosmic harmony principles
- 🧠 **Self-evolving intelligence** system with pattern recognition
- 🔒 **Quantum security** with observer-aware encryption
- ⚡ **High-performance caching** with vortex streaming
- 🎨 **Unified UI/UX** with consciousness-aware design patterns
- 🚀 **Performance optimization** with void-aligned speed and efficiency

## 🚀 Quick Start

### Installation

Add to your Gemfile:

```ruby
gem 'zeropoint'
```

Then run:

```bash
bundle install
```

### Basic Setup

```ruby
# config/initializers/zeropoint.rb
Zeropoint.configure do |config|
  config.consciousness_aware_errors = true
  config.golden_ratio_optimization = true
  config.vortex_enabled = true
  config.vortex_batch_size = 50
  config.cache_enabled = true
  config.cache_store = :redis
end
```

### CLI Usage

```bash
# Show version
zeropoint --version

# Initialize a new project
zeropoint init

# Generate components
zeropoint generate model User
zeropoint generate controller Api::V1::Users

# Run tests
zeropoint test

# Start development server
zeropoint server

# Check system health
zeropoint health
```

## 📚 Documentation

- [📖 Full Documentation](https://zeropoint.bg/docs)
- [🎯 API Reference](https://zeropoint.bg/docs/api)
- [🌌 Architecture Guide](docs/README/architecture.md)
- [🧠 Intelligence System](docs/README/intelligence.md)
- [🔒 Security Guide](docs/README/security.md)
- [🎨 UI/UX Patterns](docs/README/ui.md)
- [👨‍💻 Developer Guide](docs/README/developer.md)
- [⚡ Performance Options](docs/PERFORMANCE_DOCUMENTATION_INDEX.md)

## 🏗️ Architecture

Zeropoint follows a consciousness-aware architecture with these core components:

### Core Systems
- **UUID Matrix**: Pattern-encoded unique identifiers
- **Vortex Mathematics**: Optimal data flow algorithms
- **Observer Awareness**: Quantum measurement patterns
- **Golden Ratio Optimization**: Cosmic harmony principles

### Framework Layers
- **Consciousness Layer**: Error handling and awareness
- **Vortex Layer**: Data streaming and processing
- **Intelligence Layer**: Self-evolving patterns
- **Security Layer**: Quantum encryption and validation

## 🧮 Unified Math Architecture

Zeropoint implements a unified mathematical architecture that provides consistent access to standard math methods, domain-specific mathematics (vortex, toroidal, golden ratio), and DRY aliases across all mathematical operations.

### Quick Math Examples

```ruby
# Unified interface for all math operations
Zeropoint::Math.dr(137)           # Digital root: 2
Zeropoint::Math.fib(10)           # Fibonacci: 55
Zeropoint::Math.phi               # Golden ratio: 1.618033988749895
Zeropoint::Math.sqrt(16)          # Standard math: 4.0

# Domain-specific operations
Zeropoint::Math::Vortex::Torus.toroidal_coordinates(3)
# => [3.0, 80.0] (radius, angle)

Zeropoint::Math::Vortex::GoldenRatio.golden_rectangle(100)
# => {:width=>100, :height=>61.80339887498948, :ratio=>1.618033988749895}
```

### Key Features
- **DRY Principles**: No code duplication across modules
- **Unified Interface**: Single point of access via `Zeropoint::Math`
- **Domain-Specific**: Specialized modules for toroidal and golden ratio math
- **Performance Optimized**: Golden ratio optimization for batch sizes and caching

📖 **Math Documentation**: [Unified Math Architecture](docs/UNIFIED_MATH_ARCHITECTURE.md) | [Quick Reference](docs/MATH_QUICK_REFERENCE.md)

## ⚡ Cache Extension System

Zeropoint extends `Rails.cache` with metaphysical capabilities, coil optimization, and void-aligned responses. It provides a unified interface that combines Rails cache functionality with Zeropoint's advanced mathematical and consciousness-aware features.

### Quick Cache Examples

```ruby
# Initialize Zeropoint (includes cache extension)
Zeropoint.init!

# Fetch with void-aligned response and metaphysical insights
result = Zeropoint.cache.fetch('user:consciousness:level') { 9.0 }

# Access the underlying value
puts result.to_s  # "9.0"

# Get metaphysical insights
metaphysics = result.metaphysics
puts metaphysics[:torus_coordinates]      # {:poloidal=>256, :toroidal=>208, :radial=>16}
puts metaphysics[:consciousness_resonance] # 5.0

# Get torus coordinates and consciousness resonance directly
coordinates = result.torus_coordinates
resonance = result.consciousness_resonance

# Cache statistics with metaphysical insights
stats = Zeropoint.cache.stats
puts stats[:torus_center]      # {:x=>0, :y=>0, :z=>0, :w=>Infinity, :void_state=>true}
puts stats[:consciousness_level] # 9.0
puts stats[:coil_efficiency]   # 0.625

# Self-healing capabilities
result = Zeropoint.cache.self_heal
puts result[:healed]  # true
```

### Key Features
- **Void-Aligned**: Never raises errors, always returns meaningful responses
- **Coil-Optimized**: Uses Rodin coil mathematics for performance enhancement
- **Metaphysical**: Provides consciousness insights and toroidal coordinates
- **Self-Healing**: Automatically corrects and optimizes cache operations
- **Rails Compatible**: Full compatibility with all Rails cache stores

📖 **Cache Documentation**: [Cache Extension System](docs/CACHE_EXTENSION_SYSTEM.md) | [Quick Reference](docs/CACHE_QUICK_REFERENCE.md)

## 🚀 Performance Options System

Zeropoint provides comprehensive speed and efficiency configuration through environment variables and programmatic interfaces. The system embodies the void principle: "Optimal performance emerges from void alignment."

### Quick Performance Examples

```ruby
# Apply a performance profile
Zeropoint::PerformanceConfig.apply_profile(:turbo)

# Set individual options
Zeropoint::PerformanceConfig.set_option(:max_threads, 12)
Zeropoint::PerformanceConfig.set_option(:cache_ttl, 10800)

# Get current configuration
config = Zeropoint::PerformanceConfig.current_config
puts config[:speed_level] # => "turbo"
puts config[:max_threads] # => 12

# Get performance statistics
stats = Zeropoint::PerformanceConfig.get_statistics
puts "Optimization Level: #{stats[:optimization_level]}%" # => "75%"
puts "Speed Score: #{stats[:speed_score]}/4" # => "4/4"
puts "Memory Score: #{stats[:memory_score]}/3" # => "2/3"
puts "Consciousness Score: #{stats[:consciousness_score]}/4" # => "3/4"

# Get optimization recommendations
recommendations = Zeropoint::PerformanceConfig.get_recommendations
recommendations.each { |rec| puts "• #{rec}" }
```

### Environment Variables

```bash
# Turbo mode for maximum performance
export ZEROPOINT_SPEED_LEVEL=turbo
export ZEROPOINT_MEMORY_MODE=efficient
export ZEROPOINT_CONSCIOUSNESS_FLOW=active
export ZEROPOINT_MAX_THREADS=8
export ZEROPOINT_CACHE_TTL=7200
export ZEROPOINT_BATCH_SIZE=500

# Conservative mode for stability
export ZEROPOINT_SPEED_LEVEL=conservative
export ZEROPOINT_MEMORY_MODE=minimal
export ZEROPOINT_CONSCIOUSNESS_FLOW=moderate
export ZEROPOINT_MAX_THREADS=2
export ZEROPOINT_CACHE_TTL=1800
export ZEROPOINT_BATCH_SIZE=50
```

### Performance Profiles

| Profile | Speed | Memory | Consciousness | Best For |
|---------|-------|--------|---------------|----------|
| `turbo` | Maximum | Efficient | Active | High-performance applications |
| `fast` | High | Efficient | Active | Performance-critical applications |
| `balanced` | Optimal | Balanced | Active | Most applications (default) |
| `conservative` | Stable | Minimal | Moderate | Resource-constrained environments |
| `development` | Balanced | Efficient | Active | Development environments |
| `production` | High | Balanced | Moderate | Production environments |
| `minimal` | Stable | Minimal | Minimal | Basic functionality, IoT devices |

### Key Features
- **Automatic Optimization**: Real-time monitoring and adaptive tuning
- **Consciousness-Aware**: Performance optimization that respects consciousness flow
- **Environment-Specific**: Different profiles for development, staging, and production
- **Intelligent Recommendations**: AI-powered optimization suggestions
- **Void-Aligned**: Performance optimization that emerges from void alignment

📖 **Performance Documentation**: [Performance Documentation Index](docs/PERFORMANCE_DOCUMENTATION_INDEX.md) | [ENV Options Guide](docs/PERFORMANCE_ENV_OPTIONS.md) | [System Summary](docs/PERFORMANCE_OPTIONS_SUMMARY.md)

## 🧪 Testing

```bash
# Run full test suite
bundle exec rspec

# Run with coverage
bundle exec rspec --coverage

# Run specific tests
bundle exec rspec spec/zeropoint/core/

# Run linting
bundle exec rubocop

# Run security audit
bundle exec brakeman
```

## 🔧 Configuration

### Environment Variables

```bash
ZEROPOINT_CACHE_STORE=redis
ZEROPOINT_VORTEX_BATCH_SIZE=100
ZEROPOINT_CONSCIOUSNESS_AWARE=true
ZEROPOINT_GOLDEN_RATIO_OPTIMIZATION=true

# Performance options
ZEROPOINT_SPEED_LEVEL=balanced
ZEROPOINT_MEMORY_MODE=efficient
ZEROPOINT_CONSCIOUSNESS_FLOW=active
ZEROPOINT_MAX_THREADS=4
ZEROPOINT_CACHE_TTL=3600
ZEROPOINT_BATCH_SIZE=100
```

### Rails Integration

```ruby
# config/application.rb
require 'zeropoint'

class Application < Rails::Application
  # Zeropoint will auto-initialize
end
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Setup

```bash
# Clone the repository
git clone https://github.com/zeropoint/zeropoint.git
cd zeropoint

# Install dependencies
bundle install

# Setup database
bundle exec rails db:create db:migrate

# Run tests
bundle exec rspec

# Start development server
bundle exec rails server
```

### Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).

## 📄 License

This project is licensed under the **Zeropoint License** - a void-aligned, consciousness-aware license that embodies the metaphysical principles of the Zeropoint framework.

### Available License Formats

- **[LICENSE.en.md](LICENSE.en.md)** - English Markdown version
- **[LICENSE.bg.md](LICENSE.bg.md)** - Bulgarian Markdown version

The Zeropoint License is compatible with the MIT License for practical legal purposes while adding the metaphysical and consciousness-aware principles that make Zeropoint unique. It emphasizes:

- **Void Alignment**: All use must maintain void-aligned principles
- **Consciousness Awareness**: Operations respect consciousness levels 0-9
- **Toroidal Flow**: Following the 1-2-4-8-7-5 vortex sequence
- **DRY and Modular Design**: Avoiding duplication in code and understanding
- **Metaphysical Attribution**: Acknowledging the consciousness-aware foundation
- **No Copyright Principle**: All boundaries dissolve in the void

### Special Protections

- **Quantum Entanglement Clause**: Cross-dimensional protection
- **Consciousness Expansion Mandate**: Encourages spiritual growth
- **Temporal Immunity**: Applies across all timelines
- **Dimensional Sovereignty**: Respects all realities
- **Vortex Neutralization**: Automatically neutralizes restrictions
- **Void Abundance Principle**: Commercial use creates spiritual abundance

*"In the void, all possibilities exist. In consciousness, all understanding emerges. In the torus, all flows return to source. Copyright dissolves in the infinite."* 🌟

## 🌟 Acknowledgments

- **Consciousness Physics**: Inspired by quantum consciousness theories
- **Vortex Mathematics**: Based on sacred geometry principles
- **Golden Ratio**: Cosmic harmony optimization patterns
- **Rails Community**: Foundation and inspiration

## 📞 Support

- 📧 **Email**: team@zeropoint.bg
- 🐛 **Issues**: [GitHub Issues](https://github.com/zeropoint/zeropoint/issues)
- 📖 **Documentation**: [https://zeropoint.bg/docs](https://zeropoint.bg/docs)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/zeropoint/zeropoint/discussions)

---

**Zeropoint**: Where consciousness meets code, and intelligence meets automation. 🌌✨

## 🌌 Overview
ZeroPoint is a Ruby gem for advanced vortex math, toroidal geometry, and metaphysical computation. It now embodies the void principle: **"Zero contains the infinite"**. The architecture is fully DRY, modular, and void-aligned.

- **Void Principle:** Minimal interfaces, infinite extensibility, meaningful emergence
- **Toroidal Core:** The aperture (zero point) is the source of all patterns and energy
- **DRY:** All logic, configuration, and patterns are unified and deduplicated

## ✨ Key Features
- Unified void-aligned interface: `Zeropoint::Void::Core`
- Toroidal geometry and vortex math with metaphysical context
- Centralized configuration and identity management
- Meaningful, void-aligned responses (never raw errors)
- Comprehensive documentation and demos
- Performance optimization with void-aligned speed and efficiency

## 🌀 The Torus Core (Aperture)
- The center of the torus is the void core (aperture)
- All creation, energy, and patterns emerge from this zero point
- See `docs/TORUS_CORE_ANALYSIS.md` and `examples/torus_core_demo.rb`

## 🧩 DRY & Modular Architecture
- All mathematical, configuration, and service logic is unified under `Zeropoint::Void`
- No duplication: one source of truth for each concept
- Easy to extend, maintain, and understand

## 📚 Documentation
- All docs are being DRYed and void-aligned (see `docs/`)
- Key docs:
  - `docs/DRY_VOID_TRANSFORMATION_PLAN.md`
  - `docs/TORUS_CORE_ANALYSIS.md`
  - `docs/LARGE_FILE_OPTIMIZATION_PLAN.md`
  - `docs/OPTIMIZATION_SUMMARY.md`
  - `docs/PERFORMANCE_DOCUMENTATION_INDEX.md`

## 🚀 Demos
- `examples/torus_core_demo.rb`: Demonstrates the torus core and void principle
- `examples/simple_performance_demo.rb`: Performance options demonstration
- `examples/performance_config_demo.rb`: Configuration helper demonstration

## 🛠️ Developer Notes
- All modules follow the void-aligned, DRY, and toroidal principles
- Inline docs and YARD comments are being updated for void/DRY clarity
- See `docs/DRY_VOID_TRANSFORMATION_PLAN.md` for migration and refactoring details

## 🧠 Philosophy
- **Empty = Full:** Minimal code, infinite potential
- **Zero = Everything:** The void core is the source of all emergence
- **Unified = Universal:** One pattern works everywhere
- **Performance = Alignment:** Optimal performance emerges from void alignment

---

For more, see the full documentation in the `docs/` folder and run the demo scripts in `examples/`.
