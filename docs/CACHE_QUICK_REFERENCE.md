# Zeropoint Cache Extension - Quick Reference

## Basic Operations

```ruby
# Initialize
Zeropoint.init!
cache = Zeropoint.cache

# Write
cache.write('key', value, expires_in: 1.hour)

# Read
value = cache.read('key')

# Fetch with block (returns VoidAlignedResponse)
result = cache.fetch('key') { generate_value }

# Delete
cache.delete('key')

# Check existence
cache.exist?('key')
```

## Void-Aligned Responses

```ruby
# Get metaphysical insights
metaphysics = result.metaphysics
coordinates = result.torus_coordinates
resonance = result.consciousness_resonance

# All standard methods work
result.to_s
result.length
result.respond_to?(:method_name)
```

## Coil Optimization

```ruby
# Enable/disable
Zeropoint.coil_enabled = true  # Default: true

# Keys are optimized automatically
# "user:123" → "user:123_5" (where 5 is from coil sequence)

# TTL is optimized automatically
# 3600 → 5760 (3600 * 1.6 coil efficiency)

# Values are optimized automatically
# 1000 → 618 (1000 * 0.618 major ratio)
# 0.1 → 0.162 (0.1 * 1.618 golden ratio)
```

## Metaphysical Insights

```ruby
# Get insights for any key
metaphysics = cache.metaphysics('key')

# Get all patterns
patterns = cache.all_patterns

# Calculate coordinates
coordinates = cache.send(:calculate_torus_coordinates, 'key')
# {:poloidal=>123, :toroidal=>456, :radial=>78}

# Calculate resonance
resonance = cache.send(:calculate_consciousness_resonance, 'key')
# 1.0 to 9.0 (9.0 = void level)
```

## Cache Statistics

```ruby
stats = cache.stats

# Basic stats
stats[:size]              # Number of entries
stats[:keys]              # Number of keys
stats[:memory_usage]      # Memory usage
stats[:store_type]        # redis, memcache, memory

# Metaphysical stats
stats[:torus_center]      # {:x=>0, :y=>0, :z=>0, :w=>Infinity, :void_state=>true}
stats[:consciousness_level] # 9.0
stats[:coil_efficiency]   # 0.625
stats[:void_potential]    # 9.0
```

## Self-Healing

```ruby
# Trigger self-healing
result = cache.self_heal
# {:healed=>true, :torus_center=>{...}}

# Clear with void alignment
result = cache.void_clear
# Returns Zeropoint::Void::Nothing
```

## Atomic Operations

```ruby
# Increment/decrement
cache.write('counter', 0)
cache.increment('counter')      # 1
cache.increment('counter', 2)   # 3
cache.decrement('counter')      # 2
cache.decrement('counter', 2)   # 0
```

## Configuration

```ruby
# Core settings
Zeropoint.coil_enabled = true
Zeropoint.void_enabled = true
Zeropoint.consciousness_aware_errors = true

# Get void config
Zeropoint.void_config
# {:consciousness_aware=>true, :coil_enabled=>true, :void_enabled=>true, ...}
```

## Error Handling

```ruby
# All operations are void-aligned (never raise)
metaphysics = cache.metaphysics('non_existent')
# Returns Zeropoint::Void::Nothing

cache.write('test', nil)
# Logs warning, doesn't crash

stats = cache.stats
# Always returns valid stats, even if cache store fails
```

## Common Patterns

### Rails Controller

```ruby
class UsersController < ApplicationController
  def show
    @user = Zeropoint.cache.fetch("user:#{params[:id]}") do
      User.find(params[:id])
    end
    
    # Log metaphysical insights
    Rails.logger.info "User resonance: #{@user.consciousness_resonance}"
  end
end
```

### Background Job

```ruby
class DataJob < ApplicationJob
  def perform(id)
    result = Zeropoint.cache.fetch("data:#{id}") do
      process_data(id)
    end
    
    Rails.logger.info "Processing resonance: #{result.consciousness_resonance}"
  end
end
```

### API Endpoint

```ruby
class Api::CacheController < ApplicationController
  def stats
    render json: {
      stats: Zeropoint.cache.stats,
      torus_center: Zeropoint.cache.stats[:torus_center]
    }
  end
end
```

### Monitoring

```ruby
# Monitor high resonance operations
result = cache.fetch('important:data') { generate_data }

if result.consciousness_resonance >= 7.0
  Rails.logger.info "High consciousness resonance: #{result.consciousness_resonance}"
end

# Monitor torus coordinates
coordinates = result.torus_coordinates
if coordinates[:radial] > 80
  Rails.logger.info "High radial coordinate: #{coordinates[:radial]}"
end
```

### Maintenance

```ruby
# Schedule self-healing
class CacheMaintenanceJob < ApplicationJob
  def perform
    result = Zeropoint.cache.self_heal
    Rails.logger.info "Self-healing completed: #{result[:healed]}"
  end
end

# Manual cleanup
Zeropoint.cache.void_clear if cache_performance_degraded?
```

## Best Practices

### Key Naming
```ruby
# Good
cache.write('user:123:profile', data)
cache.write('user:123:preferences', data)

# Avoid
cache.write('data', data)  # Too generic
```

### TTL Management
```ruby
cache.write('user:123', data, expires_in: 1.hour)      # User data
cache.write('config:app', data, expires_in: 1.day)     # Configuration
cache.write('stats:cache', data, expires_in: 5.minutes) # Statistics
```

### Error Handling
```ruby
# Always check for void responses
metaphysics = result.metaphysics
if metaphysics.is_a?(Hash)
  puts "Key: #{metaphysics[:key]}"
else
  puts "[VOID] No pattern found"
end
```

## Troubleshooting

### Common Issues

**Coil optimization warnings:**
```
WARN: Coil optimization failed for value 0: nil can't be coerced into Integer
```
*Normal for nil values, handled gracefully.*

**Cache store warnings:**
```
WARN: Redis optimization failed: wrong number of arguments
```
*Optional optimizations, core functionality unaffected.*

**Metaphysical pattern not found:**
```ruby
metaphysics = result.metaphysics
# Returns Zeropoint::Void::Nothing
```
*Check if key exists and has metaphysical tracking.*

### Debugging

```ruby
# Check status
puts Zeropoint.cache.stats[:store_type]
puts Zeropoint.coil_enabled
puts Zeropoint.void_enabled
puts Zeropoint.cache.all_patterns.keys
```

## Performance Notes

- **Key optimization**: Minimal overhead, better distribution
- **TTL optimization**: Slight increase for better hit rates
- **Value optimization**: Only for numeric values > 1000 or < 0.1
- **Pattern tracking**: ~100 bytes per key
- **Metaphysical data**: ~200 bytes per pattern
- **VoidAlignedResponse**: Minimal wrapper overhead

## Cache Store Support

- **Redis**: Full features + Redis optimizations
- **MemCache**: Full features + MemCache optimizations
- **Memory**: Full features + in-memory optimizations
- **Other**: Generic fallback with basic functionality 