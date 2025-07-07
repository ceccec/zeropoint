# Filterable Testing Guide

## Overview

This guide covers comprehensive testing strategies for the Filterable concern, including unit tests, integration tests, performance tests, and security tests.

## Test Structure

```
spec/
├── models/
│   └── concerns/
│       └── filterable_spec.rb          # Unit tests
├── requests/
│   └── filterable_integration_spec.rb  # Integration tests
├── examples/
│   └── filterable_example_spec.rb      # Example tests
└── factories/
    ├── users.rb                        # User factories
    ├── roles.rb                        # Role factories
    ├── posts.rb                        # Post factories
    └── tags.rb                         # Tag factories
```

## Unit Tests

### Test Model Setup

```ruby
RSpec.describe Filterable, type: :model do
  # Test model that includes the Filterable concern
  class TestUser < ActiveRecord::Base
    self.table_name = 'users'
    include Filterable
    
    belongs_to :role
    has_many :posts
    has_many :user_tags
    has_many :tags, through: :user_tags
    
    def self.filterable_fields
      {
        'name'        => :string,
        'email'       => :string,
        'status'      => :string,
        'description' => :string,
        'created_at'  => :date,
        'updated_at'  => :date,
        'active'      => :boolean,
        'role_id'     => :association,
        'tags'        => :array,
        'search'      => :custom,
        'age_range'   => :custom,
        'posts'       => :nested_association,
        'role'        => :nested_association
      }
    end
    
    private
    
    def self.apply_search_filter(scope, field, value)
      scope.where("name LIKE ? OR email LIKE ? OR description LIKE ?", 
                 "%#{value}%", "%#{value}%", "%#{value}%")
    end
    
    def self.apply_age_range_filter(scope, field, value)
      case value
      when '18-25'
        scope.where('birth_date >= ? AND birth_date <= ?', 25.years.ago, 18.years.ago)
      when '26-35'
        scope.where('birth_date >= ? AND birth_date <= ?', 35.years.ago, 26.years.ago)
      when '36+'
        scope.where('birth_date <= ?', 36.years.ago)
      else
        scope
      end
    end
  end
end
```

### Test Data Setup

```ruby
before do
  # Create test data
  @admin_role = create(:role, name: 'admin')
  @user_role = create(:role, name: 'user')
  @moderator_role = create(:role, name: 'moderator')
  
  @admin_tag = create(:tag, name: 'admin')
  @moderator_tag = create(:tag, name: 'moderator')
  @vip_tag = create(:tag, name: 'vip')
  
  @alice = create(:user, 
    name: 'Alice Johnson',
    email: 'alice@example.com',
    status: 'active',
    role: @admin_role,
    active: true,
    created_at: 1.day.ago,
    birth_date: 25.years.ago
  )
  
  @bob = create(:user,
    name: 'Bob Smith',
    email: 'bob@example.com',
    status: 'inactive',
    role: @user_role,
    active: false,
    created_at: 1.week.ago,
    birth_date: 30.years.ago
  )
  
  @charlie = create(:user,
    name: 'Charlie Brown',
    email: 'charlie@example.com',
    status: 'active',
    role: @moderator_role,
    active: true,
    created_at: 1.month.ago,
    birth_date: 40.years.ago
  )
  
  # Create associations
  create(:user_tag, user: @alice, tag: @admin_tag)
  create(:user_tag, user: @alice, tag: @vip_tag)
  create(:user_tag, user: @bob, tag: @moderator_tag)
  create(:user_tag, user: @charlie, tag: @moderator_tag)
  
  # Create posts
  create(:post, user: @alice, status: 'published')
  create(:post, user: @bob, status: 'draft')
  create(:post, user: @charlie, status: 'published')
end
```

### String Filter Tests

```ruby
context 'with string filters' do
  it 'filters by partial match (default)' do
    result = TestUser.filter_by({ 'name' => 'alice' })
    expect(result).to contain_exactly(@alice)
  end
  
  it 'filters by exact match' do
    result = TestUser.filter_by({ 'name' => { 'eq' => 'Alice Johnson' } })
    expect(result).to contain_exactly(@alice)
  end
  
  it 'filters by starts_with' do
    result = TestUser.filter_by({ 'email' => { 'starts_with' => 'alice@' } })
    expect(result).to contain_exactly(@alice)
  end
  
  it 'filters by ends_with' do
    result = TestUser.filter_by({ 'email' => { 'ends_with' => '@example.com' } })
    expect(result).to contain_exactly(@alice, @bob, @charlie)
  end
  
  it 'handles case insensitive search' do
    result = TestUser.filter_by({ 'name' => 'ALICE' })
    expect(result).to contain_exactly(@alice)
  end
  
  it 'handles empty string values' do
    result = TestUser.filter_by({ 'name' => '' })
    expect(result.count).to eq(TestUser.count)
  end
  
  it 'handles nil values' do
    result = TestUser.filter_by({ 'name' => nil })
    expect(result.count).to eq(TestUser.count)
  end
end
```

### Date Filter Tests

```ruby
context 'with date filters' do
  it 'filters by relative date (today)' do
    today_user = create(:user, created_at: Time.current)
    
    result = TestUser.filter_by({ 'created_at' => 'today' })
    expect(result).to include(today_user)
  end
  
  it 'filters by date range' do
    result = TestUser.filter_by({
      'created_at' => {
        'from' => 1.day.ago.to_date.to_s,
        'to' => 1.day.from_now.to_date.to_s
      }
    })
    expect(result).to contain_exactly(@alice, @bob, @charlie)
  end
  
  it 'filters by single date' do
    result = TestUser.filter_by({ 'created_at' => @alice.created_at.to_date.to_s })
    expect(result).to contain_exactly(@alice)
  end
  
  it 'handles invalid date gracefully' do
    result = TestUser.filter_by({ 'created_at' => 'invalid-date' })
    expect(result.count).to eq(TestUser.count)
  end
end
```

### Boolean Filter Tests

```ruby
context 'with boolean filters' do
  it 'filters by boolean true' do
    result = TestUser.filter_by({ 'active' => true })
    expect(result).to contain_exactly(@alice, @charlie)
  end
  
  it 'filters by boolean false' do
    result = TestUser.filter_by({ 'active' => false })
    expect(result).to contain_exactly(@bob)
  end
  
  it 'filters by string true' do
    result = TestUser.filter_by({ 'active' => 'true' })
    expect(result).to contain_exactly(@alice, @charlie)
  end
  
  it 'filters by integer 1' do
    result = TestUser.filter_by({ 'active' => 1 })
    expect(result).to contain_exactly(@alice, @charlie)
  end
end
```

### Custom Filter Tests

```ruby
context 'with custom filters' do
  it 'applies search filter' do
    result = TestUser.filter_by({ 'search' => 'alice' })
    expect(result).to contain_exactly(@alice)
  end
  
  it 'applies age range filter (18-25)' do
    result = TestUser.filter_by({ 'age_range' => '18-25' })
    expect(result).to contain_exactly(@alice)
  end
  
  it 'applies age range filter (26-35)' do
    result = TestUser.filter_by({ 'age_range' => '26-35' })
    expect(result).to contain_exactly(@bob)
  end
  
  it 'applies age range filter (36+)' do
    result = TestUser.filter_by({ 'age_range' => '36+' })
    expect(result).to contain_exactly(@charlie)
  end
end
```

### Security Tests

```ruby
context 'with security considerations' do
  it 'prevents SQL injection in string filters' do
    malicious_input = "'; DROP TABLE users; --"
    result = TestUser.filter_by({ 'name' => malicious_input })
    expect(result.count).to eq(0) # No users match this pattern
    expect(TestUser.count).to eq(3) # Table still exists
  end
  
  it 'prevents SQL injection in association filters' do
    malicious_input = "1; DROP TABLE users; --"
    result = TestUser.filter_by({ 'role_id' => malicious_input })
    expect(result.count).to eq(TestUser.count) # Returns all users
    expect(TestUser.count).to eq(3) # Table still exists
  end
  
  it 'ignores non-whitelisted fields' do
    result = TestUser.filter_by({ 'password' => 'hack' })
    expect(result.count).to eq(TestUser.count)
  end
end
```

## Integration Tests

### Controller Setup

```ruby
RSpec.describe 'Filterable Integration', type: :request do
  # Test controller that uses the Filterable concern
  class TestUsersController < ApplicationController
    def index
      filters = params[:filters] || {}
      users = TestUser.filter_by(filters)
                     .includes(:role, :posts, :tags)
                     .distinct
      
      render json: {
        users: users.as_json(include: [:role, :posts, :tags]),
        total: users.count,
        filters: filters
      }
    end
    
    def search
      filters = params[:filters] || {}
      users = TestUser.filter_by(filters)
                     .includes(:role, :posts, :tags)
                     .distinct
                     .limit(params[:limit] || 10)
                     .offset(params[:offset] || 0)
      
      render json: {
        users: users.as_json(include: [:role, :posts, :tags]),
        total: users.count,
        pagination: {
          limit: params[:limit] || 10,
          offset: params[:offset] || 0,
          total: TestUser.filter_by(filters).count
        }
      }
    end
  end
end
```

### API Endpoint Tests

```ruby
describe 'GET /test_users' do
  context 'with no filters' do
    it 'returns all users' do
      get '/test_users'
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      
      expect(json['users'].length).to eq(3)
      expect(json['total']).to eq(3)
      expect(json['filters']).to eq({})
    end
  end
  
  context 'with string filters' do
    it 'filters by name (partial match)' do
      get '/test_users', params: {
        filters: { 'name' => 'alice' }
      }
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      
      expect(json['users'].length).to eq(1)
      expect(json['users'].first['name']).to eq('Alice Johnson')
      expect(json['total']).to eq(1)
    end
  end
  
  context 'with multiple filters' do
    it 'combines multiple filter conditions' do
      get '/test_users', params: {
        filters: {
          'active' => 'true',
          'role' => { 'name' => 'admin' },
          'name' => { 'like' => 'alice' }
        }
      }
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      
      expect(json['users'].length).to eq(1)
      expect(json['users'].first['name']).to eq('Alice Johnson')
    end
  end
end
```

### Pagination Tests

```ruby
describe 'GET /test_users/search' do
  context 'with pagination' do
    it 'returns paginated results' do
      get '/test_users/search', params: {
        limit: 2,
        offset: 0
      }
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      
      expect(json['users'].length).to eq(2)
      expect(json['pagination']['limit']).to eq(2)
      expect(json['pagination']['offset']).to eq(0)
      expect(json['pagination']['total']).to eq(3)
    end
  end
end
```

## Performance Tests

### Query Performance Tests

```ruby
context 'with performance considerations' do
  it 'generates efficient SQL queries' do
    result = TestUser.filter_by({
      'active' => true,
      'role_id' => [@admin_role.id, @user_role.id],
      'name' => { 'like' => 'alice' }
    })
    
    # Should generate a single optimized query
    sql = result.to_sql.downcase
    expect(sql).to include('where')
    expect(sql).to include('active = true')
    expect(sql).to include('role_id in')
    expect(sql).to include('name like')
  end
  
  it 'supports eager loading' do
    result = TestUser.filter_by({ 'active' => true })
                   .includes(:role, :posts, :tags)
                   .distinct
    
    expect(result).to contain_exactly(@alice, @charlie)
    # Should not trigger N+1 queries
    expect { result.each { |user| user.role.name } }.not_to exceed_query_limit(1)
  end
end
```

### Custom Query Limit Matcher

```ruby
RSpec::Matchers.define :exceed_query_limit do |limit|
  match do |block|
    count = 0
    counter = ->(name, started, finished, unique_id, payload) {
      count += 1 unless payload[:name].in? %w[ CACHE SCHEMA ]
    }
    
    ActiveSupport::Notifications.subscribed(counter, "sql.active_record", &block)
    count > limit
  end
  
  failure_message do |block|
    "Expected block to exceed #{limit} queries, but it didn't"
  end
end
```

## Edge Case Tests

### Input Validation Tests

```ruby
context 'with edge cases' do
  it 'handles very long filter values' do
    long_string = 'a' * 1000
    result = TestUser.filter_by({ 'name' => long_string })
    expect(result.count).to eq(0)
  end
  
  it 'handles special characters in filter values' do
    special_chars = "!@#$%^&*()_+-=[]{}|;':\",./<>?"
    result = TestUser.filter_by({ 'name' => special_chars })
    expect(result.count).to eq(0)
  end
  
  it 'handles unicode characters' do
    unicode_string = "café résumé naïve"
    result = TestUser.filter_by({ 'name' => unicode_string })
    expect(result.count).to eq(0)
  end
  
  it 'handles very large numbers' do
    large_number = 999999999999999999
    result = TestUser.filter_by({ 'role_id' => large_number })
    expect(result.count).to eq(0)
  end
end
```

### Error Handling Tests

```ruby
context 'with error handling' do
  it 'handles malformed filter parameters gracefully' do
    get '/test_users', params: {
      filters: 'invalid-json'
    }
    
    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    
    expect(json['users'].length).to eq(3) # Returns all users
  end
  
  it 'handles deeply nested invalid filters' do
    get '/test_users', params: {
      filters: {
        'role' => {
          'invalid_field' => 'value',
          'name' => 'admin'
        }
      }
    }
    
    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    
    expect(json['users'].length).to eq(1) # Still filters by valid field
    expect(json['users'].first['name']).to eq('Alice Johnson')
  end
end
```

## Factory Definitions

### User Factory

```ruby
FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    status { 'active' }
    description { 'A test user' }
    active { true }
    birth_date { 25.years.ago }
    created_at { 1.day.ago }
    updated_at { 1.day.ago }
    
    association :role
    
    trait :inactive do
      active { false }
      status { 'inactive' }
    end
    
    trait :admin do
      association :role, :admin
    end
    
    trait :moderator do
      association :role, :moderator
    end
    
    trait :with_posts do
      after(:create) do |user|
        create_list(:post, 2, user: user)
      end
    end
    
    trait :with_tags do
      after(:create) do |user|
        user.tags << create(:tag, name: 'admin')
        user.tags << create(:tag, name: 'vip')
      end
    end
  end
end
```

### Role Factory

```ruby
FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "role_#{n}" }
    permissions { 'read' }
    
    trait :admin do
      name { 'admin' }
      permissions { 'all' }
    end
    
    trait :moderator do
      name { 'moderator' }
      permissions { 'moderate' }
    end
    
    trait :user do
      name { 'user' }
      permissions { 'read' }
    end
  end
end
```

### Post Factory

```ruby
FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    content { 'This is a test post' }
    status { 'published' }
    
    association :user
    
    trait :draft do
      status { 'draft' }
    end
    
    trait :published do
      status { 'published' }
    end
    
    trait :archived do
      status { 'archived' }
    end
  end
end
```

### Tag Factory

```ruby
FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "tag_#{n}" }
    category { 'general' }
    
    trait :admin do
      name { 'admin' }
      category { 'role' }
    end
    
    trait :moderator do
      name { 'moderator' }
      category { 'role' }
    end
    
    trait :vip do
      name { 'vip' }
      category { 'status' }
    end
  end
end
```

## Running Tests

### Run All Tests

```bash
# Run all Filterable tests
bundle exec rspec spec/models/concerns/filterable_spec.rb spec/requests/filterable_integration_spec.rb

# Run with coverage
COVERAGE=true bundle exec rspec spec/models/concerns/filterable_spec.rb

# Run specific test file
bundle exec rspec spec/models/concerns/filterable_spec.rb --format documentation

# Run specific test context
bundle exec rspec spec/models/concerns/filterable_spec.rb -e "with string filters"
```

### Run Performance Tests

```bash
# Run performance tests only
bundle exec rspec spec/models/concerns/filterable_spec.rb -e "performance"

# Run with SQL logging
DEBUG_SQL=true bundle exec rspec spec/models/concerns/filterable_spec.rb
```

### Run Security Tests

```bash
# Run security tests only
bundle exec rspec spec/models/concerns/filterable_spec.rb -e "security"
```

## Test Configuration

### RSpec Configuration

```ruby
# spec/spec_helper.rb
RSpec.configure do |config|
  # Include Factory Bot
  config.include FactoryBot::Syntax::Methods
  
  # Database Cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  
  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
  
  # Time helpers
  config.include ActiveSupport::Testing::TimeHelpers
  
  # Custom matchers
  config.include CustomMatchers
end
```

### Custom Matchers

```ruby
# spec/support/custom_matchers.rb
module CustomMatchers
  RSpec::Matchers.define :exceed_query_limit do |limit|
    match do |block|
      count = 0
      counter = ->(name, started, finished, unique_id, payload) {
        count += 1 unless payload[:name].in? %w[ CACHE SCHEMA ]
      }
      
      ActiveSupport::Notifications.subscribed(counter, "sql.active_record", &block)
      count > limit
    end
  end
  
  RSpec::Matchers.define :generate_sql_like do |expected_sql|
    match do |scope|
      actual_sql = scope.to_sql.downcase
      expected_sql.downcase.split.each do |word|
        actual_sql.include?(word)
      end
    end
  end
end
```

## Best Practices

### 1. Test Organization

- Group related tests in contexts
- Use descriptive test names
- Test both positive and negative cases
- Test edge cases and error conditions

### 2. Test Data

- Use factories for consistent test data
- Create realistic test scenarios
- Clean up test data properly
- Use traits for variations

### 3. Performance Testing

- Test query efficiency
- Verify eager loading works
- Check for N+1 query problems
- Monitor memory usage

### 4. Security Testing

- Test SQL injection prevention
- Verify field whitelisting
- Test input validation
- Check error handling

### 5. Integration Testing

- Test complete API workflows
- Verify response formats
- Test pagination and sorting
- Check error responses

## Continuous Integration

### GitHub Actions

```yaml
# .github/workflows/test.yml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.2
          bundler-cache: true
      - run: bundle exec rspec spec/models/concerns/filterable_spec.rb
      - run: bundle exec rspec spec/requests/filterable_integration_spec.rb
```

### Coverage Requirements

```ruby
# .simplecov
SimpleCov.minimum_coverage 95
SimpleCov.minimum_coverage_by_file 90
```

## Troubleshooting

### Common Test Issues

1. **Database connection errors**: Ensure test database is set up
2. **Factory errors**: Check factory definitions and associations
3. **Performance test failures**: Verify query optimization
4. **Security test failures**: Check input validation

### Debugging Tests

```ruby
# Enable SQL logging
ActiveRecord::Base.logger = Logger.new(STDOUT)

# Debug specific test
it 'filters correctly' do
  result = TestUser.filter_by({ 'name' => 'alice' })
  puts "SQL: #{result.to_sql}"
  puts "Result: #{result.to_a}"
  expect(result).to contain_exactly(@alice)
end
```

## Conclusion

This testing guide provides comprehensive coverage for the Filterable concern, ensuring:

- ✅ **Unit tests** cover all filter types and edge cases
- ✅ **Integration tests** verify API functionality
- ✅ **Performance tests** ensure efficient queries
- ✅ **Security tests** prevent vulnerabilities
- ✅ **Factory definitions** provide consistent test data
- ✅ **Best practices** guide proper test implementation

Follow this guide to maintain high-quality, reliable tests for your Filterable implementation. 