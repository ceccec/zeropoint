# DRY Testing Guide

## Overview

This guide explains the refactored DRY (Don't Repeat Yourself) testing approach for the Zeropoint gem. The new system eliminates code duplication, simplifies test setup, and provides reusable components for efficient testing.

## Key Improvements

### 1. Consolidated Test Helpers (`spec/support/test_helpers.rb`)

All common testing utilities are now centralized in a single module:

- **RailsMocks**: Complete Rails environment mocking
- **TimeMocks**: Time and date extensions for testing
- **ModelMocks**: Model classes with all concerns
- **ZeropointMocks**: Complete Zeropoint module mocking
- **TestData**: Sample data generators
- **SharedContexts**: Reusable test contexts
- **CustomMatchers**: Custom RSpec matchers
- **Utilities**: Test utility functions

### 2. Simplified Factory System (`spec/support/factories.rb`)

A lightweight factory system that replaces FactoryBot with:

- **BaseFactory**: Common factory functionality
- **UserFactory**: User model factories with traits
- **PostFactory**: Post model factories with traits
- **CacheDataFactory**: Cache data factories
- **VortexDataFactory**: Vortex data factories
- **SearchQueryFactory**: Search query factories
- **Registry**: Easy access to all factories

### 3. Streamlined Spec Helper (`spec/spec_helper.rb`)

Simplified configuration that:

- Loads all test helpers automatically
- Sets up mocks before each test
- Includes shared contexts globally
- Provides cleanup after tests

### 4. Test Runner (`bin/test`)

A simplified test runner with commands:

```bash
# Run all tests
bin/test

# Run specific test types
bin/test --type unit
bin/test --type integration
bin/test --type performance
bin/test --type quick
bin/test --type dry-example

# Run with different formats
bin/test --format documentation
bin/test --format json

# Run without coverage
bin/test --no-coverage

# Run with warnings
bin/test --warnings

# Run in parallel
bin/test --parallel
```

## Usage Examples

### Basic Test Structure

```ruby
require 'spec_helper'

RSpec.describe 'My Feature', type: :zeropoint do
  describe 'Service Layer', type: :search do
    it 'performs operations' do
      result = query_builder
        .add_filter(:active, true)
        .build

      expect(result).to be_present
    end
  end
end
```

### Using Factories

```ruby
# Simple factory usage
user = user(name: 'Test User', email: 'test@example.com')

# Factory with traits
admin_user = Registry.user.admin(name: 'Admin User')

# Factory lists
users = users(3, role: 'moderator')

# Factory with relationships
user_with_posts = Registry.user.with_posts(5, name: 'Author')
```

### Using Shared Contexts

```ruby
# Automatically includes cache setup
context 'with cache setup', type: :cache do
  it 'has cache available' do
    expect(cache).to be_present
    expect(cache_data).to be_present
  end
end

# Automatically includes vortex setup
context 'with vortex setup', type: :vortex do
  it 'has vortex available' do
    expect(vortex_stream).to be_present
    expect(vortex_data).to be_present
  end
end
```

### Using Custom Matchers

```ruby
# Built-in custom matchers
expect(User).to be_defined
expect('test').to be_present
expect(User).to respond_to_method(:searchable?)
expect({ key: 'value' }).to have_key(:key)
expect([1, 2, 3]).to contain_item(2)
expect({ 'key' => 'value' }).to be_optimized
```

### Using Test Utilities

```ruby
# Generate unique identifiers
uuid = TestHelpers::Utilities.generate_uuid
cache_key = TestHelpers::Utilities.generate_cache_key('test')

# Create and cleanup test files
filename = TestHelpers::Utilities.create_test_file('content')
TestHelpers::Utilities.cleanup_test_files
```

## Factory Traits

### User Factory Traits

```ruby
# Basic traits
Registry.user.admin(attributes)
Registry.user.moderator(attributes)
Registry.user.inactive(attributes)
Registry.user.with_posts(count, attributes)
```

### Post Factory Traits

```ruby
# Status traits
Registry.post.published(attributes)
Registry.post.draft(attributes)
Registry.post.archived(attributes)
Registry.post.with_comments(count, attributes)
```

### Cache Data Factory Traits

```ruby
# Cache traits
Registry.cache_data.expired(attributes)
Registry.cache_data.persistent(attributes)
Registry.cache_data.with_metadata(metadata, attributes)
```

### Vortex Data Factory Traits

```ruby
# State traits
Registry.vortex_data.stored(attributes)
Registry.vortex_data.flowing(attributes)
Registry.vortex_data.offline(attributes)
Registry.vortex_data.with_context(context, attributes)
```

## Test Types

### Unit Tests

```bash
bin/test --type unit
```

Tests individual components in isolation:
- Service classes
- Model concerns
- Utility functions
- Core modules

### Integration Tests

```bash
bin/test --type integration
```

Tests component interactions:
- Controller actions
- Service integrations
- API endpoints
- Database operations

### Performance Tests

```bash
bin/test --type performance
```

Tests performance characteristics:
- Caching efficiency
- Query optimization
- Memory usage
- Response times

### Quick Tests

```bash
bin/test --type quick
```

Fast feedback tests:
- DRY example tests
- Critical path tests
- Smoke tests

## Best Practices

### 1. Use Shared Contexts

Instead of duplicating setup code, use shared contexts:

```ruby
# Good
RSpec.describe 'Cache', type: :cache do
  it 'works' do
    expect(cache).to be_present
  end
end

# Avoid
RSpec.describe 'Cache' do
  let(:cache) { Zeropoint::Cache::RedisCache.new }
  let(:cache_data) { TestHelpers::TestData.sample_cache_data }
  
  it 'works' do
    expect(cache).to be_present
  end
end
```

### 2. Use Factories for Test Data

Instead of creating objects manually, use factories:

```ruby
# Good
user = user(name: 'Test User', role: 'admin')

# Avoid
user = OpenStruct.new(
  id: rand(1000),
  name: 'Test User',
  role: 'admin',
  # ... many more attributes
)
```

### 3. Use Custom Matchers

Instead of complex assertions, use custom matchers:

```ruby
# Good
expect(result).to be_optimized
expect(result).to have_key(:metadata)

# Avoid
expect(result.keys.all? { |k| k.is_a?(String) }).to be true
expect(result.key?(:metadata)).to be true
```

### 4. Use Test Utilities

Instead of duplicating utility code, use the provided utilities:

```ruby
# Good
uuid = TestHelpers::Utilities.generate_uuid
TestHelpers::Utilities.cleanup_test_files

# Avoid
uuid = SecureRandom.uuid
Dir.glob('test_*.txt').each { |f| File.delete(f) if File.exist?(f) }
```

## Migration Guide

### From Old Specs

1. **Remove duplicate mocks**: Delete individual mock definitions
2. **Use shared contexts**: Replace manual setup with `type: :context_name`
3. **Use factories**: Replace manual object creation with factories
4. **Use custom matchers**: Replace complex assertions with custom matchers
5. **Use test utilities**: Replace utility functions with provided utilities

### Example Migration

**Before:**
```ruby
require 'spec_helper'

# Duplicate mocks
module Rails
  def self.root
    Pathname.new(File.expand_path('..', __dir__))
  end
end

RSpec.describe 'Service' do
  let(:user) do
    OpenStruct.new(
      id: 1,
      name: 'Test User',
      email: 'test@example.com'
    )
  end

  it 'works' do
    expect(user.name).to eq('Test User')
  end
end
```

**After:**
```ruby
require 'spec_helper'

RSpec.describe 'Service', type: :zeropoint do
  it 'works' do
    user = user(name: 'Test User')
    expect(user.name).to eq('Test User')
  end
end
```

## Troubleshooting

### Common Issues

1. **Missing mocks**: Ensure you're using the correct `type:` in your describe block
2. **Factory errors**: Check that you're using the correct factory method names
3. **Matcher errors**: Ensure custom matchers are loaded (they should be automatic)
4. **Test runner errors**: Make sure `bin/test` is executable (`chmod +x bin/test`)

### Debug Mode

Run tests with verbose output:

```bash
bin/test --format documentation
```

### Coverage Issues

If coverage isn't working:

```bash
bin/test --coverage
```

## Performance Benefits

The DRY testing approach provides significant performance improvements:

- **Faster setup**: Mocks are loaded once and reused
- **Reduced memory usage**: Eliminates duplicate mock objects
- **Faster test execution**: Optimized factory creation
- **Parallel execution**: Support for parallel test running

## Conclusion

The DRY testing approach significantly reduces code duplication, improves maintainability, and provides a more efficient testing experience. By using the provided helpers, factories, and utilities, you can write cleaner, more maintainable tests with less boilerplate code. 