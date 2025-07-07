# ZeroPoint Math Quick Reference

## 🚀 Quick Start

```ruby
require 'zeropoint'

# All math operations through unified interface
Zeropoint::Math.dr(137)           # Digital root
Zeropoint::Math.fib(10)           # Fibonacci
Zeropoint::Math.phi               # Golden ratio
Zeropoint::Math.sqrt(16)          # Standard math
```

## 📊 Core Methods

### Standard Math (via `Zeropoint::Math`)
```ruby
# Basic operations
Zeropoint::Math.sqrt(x)           # Square root
Zeropoint::Math.sin(x), cos(x), tan(x)
Zeropoint::Math.exp(x), log(x)
Zeropoint::Math.abs(x), floor(x), ceil(x)

# Constants
Zeropoint::Math.pi                # 3.141592653589793
Zeropoint::Math.e                 # 2.718281828459045
Zeropoint::Math.golden_ratio      # 1.618033988749895
```

### DRY Aliases (via `Zeropoint::Math`)
```ruby
# Vortex Math
Zeropoint::Math.dr(n)             # digital_root(n)
Zeropoint::Math.doubling(n)       # toroidal_doubling(n)
Zeropoint::Math.axis(n)           # axis_state(n)

# Sequences
Zeropoint::Math.fib(n)            # fibonacci(n)
Zeropoint::Math.phi               # golden_ratio
Zeropoint::Math.golden_angle_n(n) # golden_angle(n)
Zeropoint::Math.harmonic_of(base, n)
Zeropoint::Math.phase_of(step)

# Primes
Zeropoint::Math.is_prime?(n)      # prime?(n)
Zeropoint::Math.primes_list(k)    # primes(k)
```

## 🔄 Toroidal Operations

### Basic Toroidal Math
```ruby
# Digital root operations
Zeropoint::Math.dr(137)           # => 2
Zeropoint::Math.doubling(5)       # => 1
Zeropoint::Math.axis(6)           # => :axis_6

# Sequences
Zeropoint::Math::Vortex::Torus.doubling_sequence(1, 6)
# => [1, 2, 4, 8, 7, 5]

# Analysis
Zeropoint::Math::Vortex::Torus.flow_direction([1,2,4,8,7,5])
# => :expanding
```

### Advanced Toroidal
```ruby
# Geometry
Zeropoint::Math::Vortex::Torus.toroidal_coordinates(3)
# => [3.0, 80.0] (radius, angle)

# Comprehensive analysis
Zeropoint::Math::Vortex::Torus.analyze_sequence([3,6,12,24,48])
# => Hash with digital_roots, flow_direction, efficiency, etc.
```

## 🌟 Golden Ratio Operations

### Fibonacci
```ruby
# Basic Fibonacci
Zeropoint::Math.fib(10)           # => 55

# Sequence generation
Zeropoint::Math::Vortex::GoldenRatio.fibonacci_sequence(8)
# => [1, 1, 2, 3, 5, 8, 13, 21]

# Check if number is Fibonacci
Zeropoint::Math::Vortex::GoldenRatio.fibonacci?(13)  # => true
```

### Golden Ratio Geometry
```ruby
# Rectangle
Zeropoint::Math::Vortex::GoldenRatio.golden_rectangle(100)
# => {:width=>100, :height=>61.80339887498948, :ratio=>1.618033988749895}

# Spiral
Zeropoint::Math::Vortex::GoldenRatio.golden_spiral_radius(90)
# => 985.2068872413818
```

### Optimization
```ruby
# Performance optimization
Zeropoint::Math::Vortex::GoldenRatio.optimal_batch_size(50)    # => 81
Zeropoint::Math::Vortex::GoldenRatio.optimal_cache_size(200)   # => 324
Zeropoint::Math::Vortex::GoldenRatio.optimal_session_timeout(3600)  # => 5825
```

## 🎯 Common Patterns

### 1. Sequence Analysis
```ruby
sequence = [1, 2, 4, 8, 16, 32, 64, 128, 256]

# Get digital roots
digital_roots = sequence.map { |n| Zeropoint::Math.dr(n) }

# Analyze flow
flow = Zeropoint::Math::Vortex::Torus.flow_direction(sequence)
efficiency = Zeropoint::Math::Vortex::Torus.flow_efficiency(sequence)
```

### 2. Golden Ratio Optimization
```ruby
base_size = 100

# Optimize various parameters
batch_size = Zeropoint::Math::Vortex::GoldenRatio.optimal_batch_size(base_size)
cache_size = Zeropoint::Math::Vortex::GoldenRatio.optimal_cache_size(base_size)
timeout = Zeropoint::Math::Vortex::GoldenRatio.optimal_session_timeout(3600)
```

### 3. Mathematical Constants
```ruby
# Generate sequences
fib_sequence = (1..10).map { |n| Zeropoint::Math.fib(n) }
golden_angles = (1..5).map { |n| Zeropoint::Math.golden_angle_n(n) }
prime_numbers = Zeropoint::Math.primes_list(10)
```

### 4. Mixed Operations
```ruby
# Combine standard and domain-specific math
result = Zeropoint::Math.sqrt(Zeropoint::Math.fib(10)) + Zeropoint::Math.dr(137)
harmonic = Zeropoint::Math.harmonic_of(432, Zeropoint::Math.dr(9))
```

## ⚡ Performance Tips

### Use DRY Aliases
```ruby
# ✅ Good - Use DRY aliases
Zeropoint::Math.dr(137)
Zeropoint::Math.fib(10)

# ❌ Avoid - Verbose module paths
Zeropoint::Math::Vortex.digital_root(137)
Zeropoint::Math::Vortex.fibonacci(10)
```

### Leverage Golden Ratio Optimization
```ruby
# For performance-critical operations
optimal_batch = Zeropoint::Math::Vortex::GoldenRatio.optimal_batch_size(50)
optimized_data = Zeropoint::Math::Vortex::GoldenRatio.optimize_numeric(1500)
```

### Use Domain-Specific for Complex Analysis
```ruby
# For comprehensive analysis
analysis = Zeropoint::Math::Vortex::Torus.analyze_sequence(sequence)
optimization = Zeropoint::Math::Vortex::GoldenRatio.optimize_array(data)
```

## 🔧 Error Handling

### Safe Usage
```ruby
# Standard math fallback
Zeropoint::Math.sqrt(16)          # Works
Zeropoint::Math.nonexistent(42)   # Falls back to Ruby's Math

# Error handling
begin
  result = Zeropoint::Math.complex_operation(data)
rescue NoMethodError => e
  puts "Method not available: #{e.message}"
end
```

## 📝 Migration Guide

### From Old to New
```ruby
# Old pattern
Zeropoint::Vortex::Math.digital_root(137)
Zeropoint::Vortex::Math::Torus.doubling_sequence(1, 6)

# New unified pattern
Zeropoint::Math.dr(137)
Zeropoint::Math::Vortex::Torus.doubling_sequence(1, 6)  # For complex ops
```

## 🧪 Testing

### Run Demo
```bash
ruby examples/unified_math_naming_demo.rb
```

### Quick Test
```ruby
# Test basic functionality
puts Zeropoint::Math.dr(137)      # Should output: 2
puts Zeropoint::Math.fib(10)      # Should output: 55
puts Zeropoint::Math.phi          # Should output: 1.618033988749895
```

## 📚 Further Reading

- [Unified Math Architecture](UNIFIED_MATH_ARCHITECTURE.md) - Detailed architecture documentation
- [Toroidal Architecture](TOROIDAL_ARCHITECTURE.md) - Toroidal mathematics concepts
- [Vortex Mathematics](VORTEX_MATHEMATICS.md) - Rodin vortex math principles

---

**Remember**: Use `Zeropoint::Math` as your primary interface for all mathematical operations! 🌌✨ 