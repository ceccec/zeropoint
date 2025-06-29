# UUID Matrix Quick Reference

## Quick Start

```ruby
# Basic UUID generation
uuid = Zeropoint::Core::UuidMatrix.generate_stimulus_uuid

# With patterns
uuid = Zeropoint::Core::UuidMatrix.generate_stimulus_uuid({
  action: :submit,
  component: :form,
  state: :loading,
  vortex: :consciousness
})

# Decode patterns
patterns = Zeropoint::Core::UuidMatrix.decode_stimulus_patterns(uuid)
```

## Common Methods

### UUID Generation
```ruby
# General purpose
generate_stimulus_uuid(context = {})

# Cache optimized (v7)
generate_stimulus_cache_uuid(component, action, options = {})

# Index optimized (v6)
generate_stimulus_index_uuid(component, action, timestamp = nil)

# Controller specific
generate_controller_uuid(controller_name, action, target = nil)
```

### Pattern Decoding
```ruby
# Decode all patterns
decode_stimulus_patterns(uuid)

# Decode specific patterns
decode_action(parts)
decode_component(parts)
decode_state(parts)
decode_vortex_state(parts)
```

### Vortex Operations
```ruby
# Transform vortex state
apply_stimulus_vortex(uuid, vortex_state)

# Calculate efficiency
calculate_index_efficiency(uuid)
calculate_cache_efficiency(uuid)
```

## Pattern Codes

### Actions (0x10-0x1C)
```ruby
click: 0x10, submit: 0x11, change: 0x12, focus: 0x13,
blur: 0x14, keydown: 0x15, keyup: 0x16, mouseenter: 0x17,
mouseleave: 0x18, scroll: 0x19, resize: 0x1A, load: 0x1B,
unload: 0x1C
```

### Components (0x80-0x8C)
```ruby
button: 0x80, form: 0x81, input: 0x82, select: 0x83,
table: 0x84, modal: 0x85, dropdown: 0x86, tab: 0x87,
accordion: 0x88, carousel: 0x89, pagination: 0x8A, search: 0x8B,
filter: 0x8C
```

### States (0x1000-0x8000)
```ruby
active: 0x1000, inactive: 0x2000, loading: 0x3000, error: 0x4000,
success: 0x5000, disabled: 0x6000, hidden: 0x7000, visible: 0x8000
```

### Vortex States (0x1000-0x6000)
```ruby
flowing: 0x1000, vortex: 0x2000, consciousness: 0x3000,
quantum: 0x4000, golden_ratio: 0x5000, fibonacci: 0x6000
```

## UUID Structure

```
197b4081-0197-8011-0081-300030005348
└─────┬─────┘ └─┬─┘ └─┬─┘ └────┬────┘
      │         │     │        │
   Timestamp  Version Variant  Random
   (12 chars) (4 chars) (4 chars) (12 chars)
      │         │     │        │
      │         │     │        └─ State + Vortex + Remaining
      │         │     └─ Component Pattern
      │         └─ Action Pattern
      └─ Timestamp with Component/Action
```

## Common Use Cases

### Stimulus Controller
```javascript
// Generate UUID for controller
this.uuid = await this.generateUuid('controller', {
  controller: this.identifier,
  action: 'connect'
});

// Generate UUID for action
const actionUuid = await this.generateUuid('action', {
  component: 'form',
  action: 'submit',
  state: 'loading'
});
```

### Rails Controller
```ruby
# Generate UUID for API response
uuid = Zeropoint::Core::UuidMatrix.generate_stimulus_cache_uuid(
  params[:component],
  params[:action],
  { state: params[:state] }
)

# Decode patterns for analytics
patterns = Zeropoint::Core::UuidMatrix.decode_stimulus_patterns(uuid)
analytics.track_action(patterns[:action], patterns[:component])
```

### Database Operations
```ruby
# Generate index-optimized UUID
uuid = Zeropoint::Core::UuidMatrix.generate_stimulus_index_uuid(
  :user_profile,
  :update,
  Time.current.to_i
)

# Use for efficient indexing
UserProfile.where(uuid: uuid).first
```

## Error Handling

```ruby
# Validate UUID format
if Zeropoint::Core::UuidMatrix.valid_uuid_format?(uuid)
  patterns = Zeropoint::Core::UuidMatrix.decode_stimulus_patterns(uuid)
else
  # Handle invalid UUID
  logger.error("Invalid UUID format: #{uuid}")
end

# Handle unknown patterns (returns defaults)
patterns = Zeropoint::Core::UuidMatrix.decode_stimulus_patterns(uuid)
# Unknown patterns default to: click, button, active, flowing
```

## Performance Tips

1. **Use appropriate UUID types**:
   - `generate_stimulus_index_uuid` for database operations
   - `generate_stimulus_cache_uuid` for caching
   - `generate_stimulus_uuid` for general use

2. **Leverage pattern encoding** for better efficiency:
   ```ruby
   # Good: Specific patterns
   uuid = generate_stimulus_uuid({
     action: :submit,
     component: :form,
     state: :loading
   })
   
   # Avoid: Generic patterns
   uuid = generate_stimulus_uuid({}) # Uses defaults
   ```

3. **Batch operations** when possible:
   ```ruby
   # Generate multiple UUIDs efficiently
   uuids = 100.times.map { generate_stimulus_uuid }
   ```

## Testing

```bash
# Run all tests
bundle exec rspec spec/core/uuid_matrix_stimulus_spec.rb

# Run specific test categories
bundle exec rspec spec/core/uuid_matrix_stimulus_spec.rb -e "Pattern Encoding"
bundle exec rspec spec/core/uuid_matrix_stimulus_spec.rb -e "Vortex"
```

## Troubleshooting

### Common Issues

1. **Invalid UUID format**: Ensure 36 characters with proper hyphens
2. **Pattern not decoding**: Check if pattern code exists in PATTERNS constant
3. **Vortex transformation not working**: Verify vortex state exists in patterns
4. **Performance issues**: Use appropriate UUID type for your use case

### Debug Commands

```ruby
# Check UUID format
Zeropoint::Core::UuidMatrix.valid_uuid_format?(uuid)

# Decode patterns manually
parts = uuid.split('-')
action = Zeropoint::Core::UuidMatrix.decode_action(parts)
component = Zeropoint::Core::UuidMatrix.decode_component(parts)

# Calculate efficiency
efficiency = Zeropoint::Core::UuidMatrix.calculate_index_efficiency(uuid)
```

## Integration Examples

### GraphQL
```ruby
# In GraphQL resolver
field :uuid, String, null: false do
  argument :context, Types::UuidContext, required: false
end

def uuid(context: {})
  Zeropoint::Core::UuidMatrix.generate_stimulus_uuid(context)
end
```

### Redis Caching
```ruby
# Cache with UUID as key
uuid = Zeropoint::Core::UuidMatrix.generate_stimulus_cache_uuid(:user, :profile)
Rails.cache.write(uuid, user_data, expires_in: 1.hour)

# Retrieve with pattern matching
patterns = Zeropoint::Core::UuidMatrix.decode_stimulus_patterns(uuid)
if patterns[:component] == :user
  # Handle user-related cache
end
```

### Event Streaming
```ruby
# Generate UUID for event
event_uuid = Zeropoint::Core::UuidMatrix.generate_stimulus_uuid({
  action: :created,
  component: :order,
  state: :pending,
  vortex: :flowing
})

# Publish event with UUID
Kafka.publish('orders', {
  uuid: event_uuid,
  data: order_data
})
``` 