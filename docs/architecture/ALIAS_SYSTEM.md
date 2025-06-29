# Zeropoint Alias System

## Overview

The Zeropoint gem provides a comprehensive alias system that allows you to use multiple naming conventions to access the same `Zeropoint` module. This ensures maximum compatibility and flexibility for different coding styles and preferences.

## Available Naming Conventions

### Primary Module
- `Zeropoint` - The main module (recommended)

### Snake Case Variations
- `zeropoint` - Traditional snake_case
- `zeropoint` - Compact snake_case

### Kebab Case Variations (zero-point)
- `zeropoint_kebab` - Kebab case variation
- `zeropoint_dash` - Dash notation variation

### Dot Notation Variations (zero.point)
- `zeropoint_dot` - Dot notation variation
- `zeropoint_dotted` - Dotted notation variation

### Abbreviations
- `zp` - Short abbreviation
- `zero_p` - Medium abbreviation

## How to Use

### 1. Global Variables (Recommended)
All naming variations are available as global variables:

```ruby
# All of these work and point to the same Zeropoint module
$zeropoint.version
$zeropoint.version
$zeropoint_kebab.version
$zeropoint_dash.version
$zeropoint_dot.version
$zeropoint_dotted.version
$zp.version
$zero_p.version
```

### 2. Method Access via Aliases Module
You can access aliases through the `Zeropoint::Aliases` module:

```ruby
# Access via module methods
Zeropoint::Aliases.zeropoint.version
Zeropoint::Aliases.zeropoint.version
Zeropoint::Aliases.zp.version
```

### 3. Direct Module Access
The main module is always available as `Zeropoint`:

```ruby
# Direct access (recommended)
Zeropoint.version
Zeropoint.configuration
Zeropoint.health_check
```

## File Structure

The alias system is implemented through multiple files:

```
lib/
├── zeropoint.rb              # Main entry point
├── zeropoint.rb             # Snake case alias
├── zero-point.rb             # Kebab case alias
├── zero.point.rb             # Dot notation alias
└── zeropoint/
    └── aliases.rb            # Comprehensive alias system
```

## Usage Examples

### Basic Usage
```ruby
# Load the gem
require 'zeropoint'
# or
require 'zeropoint'
# or
require 'zero-point'
# or
require 'zero.point'

# All of these work:
Zeropoint.version
$zeropoint.version
$zeropoint.version
$zp.version
```

### Configuration
```ruby
# Configure using any alias
Zeropoint.configure do |config|
  config.features = [:graphql, :rails, :streaming]
end

# Or using global variables
$zeropoint.configure do |config|
  config.features = [:graphql, :rails, :streaming]
end
```

### Service Access
```ruby
# Access services through any alias
search_service = Zeropoint.search_service
# or
search_service = $zeropoint.search_service
# or
search_service = $zp.search_service
```

### Health Check
```ruby
# Check system health
health = Zeropoint.health_check
# or
health = $zeropoint.health_check
```

## Gem Installation

You can install the gem using any of these names in your Gemfile:

```ruby
# All of these work:
gem 'zeropoint', path: '.'
gem 'zeropoint', path: '.'
gem 'zero-point', path: '.'
gem 'zero.point', path: '.'
```

## Testing the Alias System

Run the test script to verify all aliases work:

```bash
ruby test_simple_aliases.rb
```

This will test:
- Local variable aliases
- Global constant aliases
- Global variable aliases
- Method calls on aliases

## Best Practices

1. **Use `Zeropoint` for primary code** - This is the most explicit and clear
2. **Use global variables for quick access** - `$zeropoint`, `$zp` for scripts
3. **Be consistent within a project** - Pick one convention and stick to it
4. **Document your choice** - Let your team know which convention you prefer

## Technical Details

### How It Works
1. The main `Zeropoint` module is defined in `lib/zeropoint.rb`
2. The alias system in `lib/zeropoint/aliases.rb` creates global variables
3. Multiple entry point files ensure different require paths work
4. All aliases point to the same underlying `Zeropoint` module

### Global Variables Available
- `$zeropoint` → `Zeropoint`
- `$zeropoint` → `Zeropoint`
- `$zeropoint_kebab` → `Zeropoint`
- `$zeropoint_dash` → `Zeropoint`
- `$zeropoint_dot` → `Zeropoint`
- `$zeropoint_dotted` → `Zeropoint`
- `$zp` → `Zeropoint`
- `$zero_p` → `Zeropoint`

### Constants Available
- `ZERO_POINT` → `Zeropoint`
- `ZEROPOINT` → `Zeropoint`
- `ZERO_POINT_DASH` → `Zeropoint`
- `ZERO_POINT_DOT` → `Zeropoint`
- `ZERO_POINT_KEBAB` → `Zeropoint`
- `ZERO_POINT_DOTTED` → `Zeropoint`
- `ZP` → `Zeropoint`
- `ZERO_P` → `Zeropoint`

## Compatibility

This alias system ensures that:
- ✅ All naming conventions work
- ✅ All method calls work on any alias
- ✅ All configuration works on any alias
- ✅ All service access works on any alias
- ✅ All file require paths work
- ✅ All gem installation names work

## Conclusion

The Zeropoint alias system provides maximum flexibility while maintaining a single source of truth. Whether you prefer `Zeropoint`, `zeropoint`, `zero-point`, `zero.point`, or any abbreviation, they all work seamlessly and point to the same powerful module. 