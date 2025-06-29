# Advanced Filterable Concern Documentation

## Overview

The `Filterable` concern provides a production-grade, DRY, efficient, and secure filtering system for Rails ActiveRecord models. It supports multiple filter types, nested associations, custom logic, and comprehensive security features.

## Features

- ✅ **DRY**: No repeated logic, reusable filter methods
- ✅ **Efficient**: Uses ActiveRecord scopes and eager loading
- ✅ **Secure**: Whitelisted fields, parameterized queries
- ✅ **Flexible**: Supports multiple filter types and operators
- ✅ **Extensible**: Easy to add custom filter logic
- ✅ **Production-ready**: Handles edge cases and error conditions

## Installation

Include the concern in your model:

```ruby
class User < ApplicationRecord
  include Filterable
  
  belongs_to :role
  has_many :posts
  has_many :user_tags
  has_many :tags, through: :user_tags
end
```

## Configuration

### Define Filterable Fields

Override the `filterable_fields` method to specify which fields can be filtered and their types:

```ruby
class User < ApplicationRecord
  include Filterable
  
  def self.filterable_fields
    {
      'name'        => :string,
      'email'       => :string,
      'status'      => :string,
      'created_at'  => :date,
      'active'      => :boolean,
      'role_id'     => :association,
      'tags'        => :array,
      'search'      => :custom,
      'age_range'   => :custom,
      'posts'       => :nested_association
    }
  end
end
```

## Filter Types

### 1. String Filters

Supports exact, partial, starts_with, and ends_with matching.

```ruby
# Partial match (default)
User.filter_by({ 'name' => 'alice' })
# SQL: WHERE name LIKE '%alice%'

# Exact match
User.filter_by({ 'name' => { 'eq' => 'Alice Johnson' } })
# SQL: WHERE name = 'Alice Johnson'

# Starts with
User.filter_by({ 'email' => { 'starts_with' => 'admin@' } })
# SQL: WHERE email LIKE 'admin@%'

# Ends with
User.filter_by({ 'email' => { 'ends_with' => '@example.com' } })
# SQL: WHERE email LIKE '%@example.com'

# Partial match with like operator
User.filter_by({ 'name' => { 'like' => 'john' } })
# SQL: WHERE name LIKE '%john%'
```

### 2. Date Filters

Supports relative dates, ranges, and single dates.

```ruby
# Relative dates
User.filter_by({ 'created_at' => 'today' })
User.filter_by({ 'created_at' => 'this_week' })
User.filter_by({ 'created_at' => 'this_month' })

# Date range
User.filter_by({
  'created_at' => {
    'from' => '2024-06-01',
    'to' => '2024-06-30'
  }
})
# SQL: WHERE created_at >= '2024-06-01 00:00:00' AND created_at <= '2024-06-30 23:59:59'

# Single date
User.filter_by({ 'created_at' => '2024-06-15' })
# SQL: WHERE created_at >= '2024-06-15 00:00:00' AND created_at <= '2024-06-15 23:59:59'
```

### 3. Boolean Filters

Supports various boolean representations.

```ruby
User.filter_by({ 'active' => 'true' })
User.filter_by({ 'active' => 'false' })
User.filter_by({ 'active' => true })
User.filter_by({ 'active' => 1 })
User.filter_by({ 'active' => '1' })
# All generate: WHERE active = true/false
```

### 4. Association Filters

Filter by foreign keys.

```ruby
User.filter_by({ 'role_id' => 1 })
# SQL: WHERE role_id = 1
```

### 5. Array Filters

Supports arrays, comma-separated strings, and single values.

```ruby
# Array of values
User.filter_by({ 'role_id' => [1, 2, 3] })
# SQL: WHERE role_id IN (1, 2, 3)

# Comma-separated string
User.filter_by({ 'role_id' => '1,2,3' })
# SQL: WHERE role_id IN (1, 2, 3)

# Single value
User.filter_by({ 'role_id' => 1 })
# SQL: WHERE role_id = 1
```

### 6. Custom Filters

Implement custom filtering logic.

```ruby
# Multi-field search
User.filter_by({ 'search' => 'john doe' })
# SQL: WHERE (name LIKE '%john doe%' OR email LIKE '%john doe%' OR description LIKE '%john doe%')

# Age range
User.filter_by({ 'age_range' => '18-25' })
# SQL: WHERE birth_date >= 25.years.ago AND birth_date <= 18.years.ago

User.filter_by({ 'age_range' => '26-35' })
# SQL: WHERE birth_date >= 35.years.ago AND birth_date <= 26.years.ago

User.filter_by({ 'age_range' => '36+' })
# SQL: WHERE birth_date <= 36.years.ago
```

### 7. Nested Association Filters

Filter through associations.

```ruby
# Filter by posts status
User.filter_by({ 'posts' => { 'status' => 'published' } })
# SQL: JOIN posts WHERE posts.status = 'published'

# Filter by role name
User.filter_by({ 'role' => { 'name' => 'admin' } })
# SQL: JOIN roles WHERE roles.name = 'admin'

# Filter by tag names
User.filter_by({ 'tags' => ['admin', 'moderator'] })
# SQL: JOIN tags WHERE tags.name IN ('admin', 'moderator')

User.filter_by({ 'tags' => 'admin' })
# SQL: JOIN tags WHERE tags.name = 'admin'
```

## Multiple Filters

Combine any number of filter conditions:

```ruby
User.filter_by({
  'active' => 'true',
  'role' => { 'name' => 'admin' },
  'created_at' => { 'from' => '2024-01-01' },
  'name' => { 'like' => 'alice' }
})
# SQL: WHERE active = true AND roles.name = 'admin' AND created_at >= '2024-01-01' AND name LIKE '%alice%'
```

## Controller Usage

```ruby
class UsersController < ApplicationController
  def index
    filters = params[:filters] || {}
    users = User.filter_by(filters)
               .includes(:role, :posts, :tags)
               .distinct
    
    render json: { users: users.as_json }
  end
end
```

## API Examples

```bash
# String filtering
GET /api/users?filters[name][like]=alice
GET /api/users?filters[email][starts_with]=admin@
GET /api/users?filters[name][eq]=Alice Johnson

# Date filtering
GET /api/users?filters[created_at]=today
GET /api/users?filters[created_at][from]=2024-06-01&filters[created_at][to]=2024-06-30

# Boolean filtering
GET /api/users?filters[active]=true

# Array filtering
GET /api/users?filters[role_id]=1,2,3

# Custom filtering
GET /api/users?filters[search]=john doe
GET /api/users?filters[age_range]=18-25

# Nested association filtering
GET /api/users?filters[posts][status]=published
GET /api/users?filters[role][name]=admin
GET /api/users?filters[tags]=admin,moderator

# Multiple filters
GET /api/users?filters[active]=true&filters[role][name]=admin&filters[created_at][from]=2024-01-01
```

## Security Features

### Whitelisted Fields

Only fields defined in `filterable_fields` can be filtered:

```ruby
# This will be ignored (password is not in filterable_fields)
User.filter_by({ 'password' => 'hack' })
# Returns all users, ignores password field
```

### SQL Injection Prevention

All queries use parameterized statements:

```ruby
# Safe from SQL injection
User.filter_by({ 'name' => "'; DROP TABLE users; --" })
# SQL: WHERE name LIKE '%''; DROP TABLE users; --%'
```

### Input Validation

Handles malicious input gracefully:

```ruby
# Invalid dates are handled safely
User.filter_by({ 'created_at' => 'invalid-date' })
# Returns all users, doesn't crash
```

## Performance Optimization

### Eager Loading

Use `includes` to avoid N+1 queries:

```ruby
User.filter_by(filters)
    .includes(:role, :posts, :tags)
    .distinct
```

### Query Optimization

The concern generates efficient SQL:

```ruby
# Multiple filters are combined efficiently
User.filter_by({
  'active' => true,
  'role_id' => [1, 2],
  'created_at' => { 'from' => '2024-01-01' }
})
# Single optimized query with all conditions
```

## Customization

### Adding Custom Filter Types

Extend the filtering system by adding new filter types:

```ruby
class User < ApplicationRecord
  include Filterable
  
  def self.filterable_fields
    {
      'name' => :string,
      'location' => :geographic, # Custom type
      'preferences' => :json      # Custom type
    }
  end
  
  private
  
  def self.apply_geographic_filter(scope, field, value)
    # Custom geographic filtering logic
    scope.where("ST_Distance(#{field}, ST_Point(?, ?)) <= ?", 
               value[:longitude], value[:latitude], value[:radius])
  end
  
  def self.apply_json_filter(scope, field, value)
    # Custom JSON filtering logic
    scope.where("#{field} @> ?", value.to_json)
  end
end
```

### Custom Filter Methods

Add custom filter methods for complex logic:

```ruby
class User < ApplicationRecord
  include Filterable
  
  def self.custom_filters
    {
      'premium_users' => ->(scope) { scope.where(premium: true) },
      'recent_activity' => ->(scope) { scope.where('last_login_at > ?', 7.days.ago) },
      'high_value' => ->(scope) { scope.where('total_spent > ?', 1000) }
    }
  end
end
```

## Testing

### Unit Tests

```ruby
RSpec.describe User, type: :model do
  describe '.filter_by' do
    it 'filters by string' do
      user = create(:user, name: 'Alice Johnson')
      result = User.filter_by({ 'name' => 'alice' })
      expect(result).to contain_exactly(user)
    end
    
    it 'filters by date range' do
      user = create(:user, created_at: 1.day.ago)
      result = User.filter_by({
        'created_at' => { 'from' => 2.days.ago.to_date.to_s }
      })
      expect(result).to contain_exactly(user)
    end
    
    it 'ignores non-whitelisted fields' do
      result = User.filter_by({ 'password' => 'hack' })
      expect(result.count).to eq(User.count)
    end
  end
end
```

### Integration Tests

```ruby
RSpec.describe 'Users API', type: :request do
  it 'filters users by multiple criteria' do
    user = create(:user, name: 'Alice', active: true)
    
    get '/api/users', params: {
      filters: {
        'name' => { 'like' => 'alice' },
        'active' => 'true'
      }
    }
    
    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json['users'].length).to eq(1)
    expect(json['users'].first['name']).to eq('Alice')
  end
end
```

## Best Practices

### 1. Define Clear Filterable Fields

```ruby
def self.filterable_fields
  {
    # Only expose fields that should be filterable
    'name' => :string,
    'email' => :string,
    'status' => :string,
    # Don't include sensitive fields like 'password'
  }
end
```

### 2. Use Appropriate Filter Types

```ruby
# Use :string for text fields
'name' => :string

# Use :date for date/time fields
'created_at' => :date

# Use :boolean for boolean fields
'active' => :boolean

# Use :association for foreign keys
'role_id' => :association

# Use :array for multiple values
'tags' => :array

# Use :custom for complex logic
'search' => :custom
```

### 3. Optimize for Performance

```ruby
# Always use includes for nested associations
User.filter_by(filters).includes(:role, :posts, :tags)

# Use distinct to avoid duplicates from joins
User.filter_by(filters).includes(:tags).distinct

# Add database indexes for filtered fields
add_index :users, :name
add_index :users, :created_at
add_index :users, :active
```

### 4. Handle Edge Cases

```ruby
# The concern handles these automatically:
# - Empty filters
# - Nil values
# - Blank strings
# - Empty arrays
# - Invalid dates
# - Non-whitelisted fields
```

### 5. Security Considerations

```ruby
# Always whitelist fields
def self.filterable_fields
  # Only include fields that should be filterable
end

# Use parameterized queries (handled automatically)
# Never use string interpolation in filter methods

# Validate input types and formats
# The concern handles this automatically
```

## Troubleshooting

### Common Issues

1. **Filter not working**: Check if the field is in `filterable_fields`
2. **Performance issues**: Add database indexes and use `includes`
3. **Duplicate results**: Use `distinct` when filtering through associations
4. **SQL injection**: All queries are automatically parameterized

### Debugging

```ruby
# Enable SQL logging to see generated queries
ActiveRecord::Base.logger = Logger.new(STDOUT)

# Check generated SQL
User.filter_by(filters).to_sql
```

## Migration Guide

### From Simple Filtering

If you're migrating from simple filtering:

```ruby
# Before
User.where(name: params[:name]) if params[:name].present?

# After
User.filter_by({ 'name' => params[:name] })
```

### From Complex Filtering

If you have complex filtering logic:

```ruby
# Before
def self.complex_filter(params)
  scope = all
  scope = scope.where(name: params[:name]) if params[:name].present?
  scope = scope.where(active: params[:active]) if params[:active].present?
  # ... more conditions
  scope
end

# After
def self.filterable_fields
  {
    'name' => :string,
    'active' => :boolean,
    # ... define all filterable fields
  }
end

# Usage
User.filter_by(params[:filters])
```

## Contributing

When extending the Filterable concern:

1. Add new filter types to the main `filter_by` method
2. Implement corresponding `apply_*_filter` methods
3. Add comprehensive tests
4. Update documentation
5. Follow the existing patterns and conventions

## License

This concern is part of the GraphQL UI Layout gem and follows the same license terms.

## Customizing Full-Text Search

You can fully customize the full-text search system for your models, including ranking, language, and Elasticsearch mapping.

### Custom Ranking (PostgreSQL)

Override the default ranking expression and threshold per model:

```ruby
class User < ApplicationRecord
  include Zeropoint::ActiveRecord::FullTextSearch

  configure_full_text_search(
    postgresql: {
      language: 'english',
      rank_threshold: 0.2, # Only results with rank >= 0.2
      use_trigram: true,
      trigram_threshold: 0.3
    }
  )

  # Optional: Override the ranking expression
  def self.postgresql_full_text_search(query, options = {})
    config = full_text_search_config[:postgresql]
    search_fields = options[:fields] || full_text_search_config[:search_fields]
    language = options[:language] || config[:language]
    rank_threshold = options[:rank_threshold] || config[:rank_threshold]

    search_vector = build_search_vector(search_fields, language)
    search_query = build_postgresql_search_query(query, language)

    # Custom ranking: weight name higher than description
    rank_expr = "0.7 * ts_rank_cd(#{search_vector}, #{search_query}) + 0.3 * ts_rank(#{search_vector}, #{search_query})"

    select("#{table_name}.*, #{rank_expr} AS custom_rank")
      .where("#{search_vector} @@ ?", search_query)
      .where("#{rank_expr} >= ?", rank_threshold)
      .order("custom_rank DESC")
  end
end
```

### Custom Language (PostgreSQL)

Set the language for stemming and stopwords:

```ruby
class Article < ApplicationRecord
  include Zeropoint::ActiveRecord::FullTextSearch

  configure_full_text_search(
    postgresql: {
      language: 'french' # Use French stemming and stopwords
    }
  )
end
```

### Custom Elasticsearch Mapping

Provide a custom mapping and analyzer for your Elasticsearch index:

```ruby
class Post < ApplicationRecord
  include Zeropoint::ActiveRecord::FullTextSearch

  configure_full_text_search(
    elasticsearch: {
      index_name: 'custom_posts_index',
      search_type: 'multi_match',
      fields: {
        'title^5' => 5.0,
        'content^2' => 2.0,
        'summary' => 1.0
      },
      fuzziness: 2,
      minimum_should_match: '80%'
    }
  )

  # Custom mapping for Elasticsearch
  def self.elasticsearch_mapping
    {
      properties: {
        title: {
          type: 'text',
          analyzer: 'english',
          fields: {
            keyword: { type: 'keyword', ignore_above: 256 }
          }
        },
        content: { type: 'text', analyzer: 'english' },
        summary: { type: 'text', analyzer: 'english' }
      }
    }
  end

  # If using elasticsearch-rails, you can define the mapping like this:
  # settings index: { number_of_shards: 1 } do
  #   mappings dynamic: false do
  #     indexes :title,   type: :text, analyzer: :english
  #     indexes :content, type: :text, analyzer: :english
  #     indexes :summary, type: :text, analyzer: :english
  #   end
  # end
end
```

### Custom Analyzer (Elasticsearch)

Define a custom analyzer in your Elasticsearch settings:

```ruby
def self.elasticsearch_settings
  {
    analysis: {
      analyzer: {
        my_custom_analyzer: {
          type: 'custom',
          tokenizer: 'standard',
          filter: ['lowercase', 'asciifolding', 'porter_stem']
        }
      }
    }
  }
end
```

And reference it in your mapping:

```ruby
def self.elasticsearch_mapping
  {
    properties: {
      title: { type: 'text', analyzer: 'my_custom_analyzer' }
    }
  }
end
```

### Usage in Search

You can pass custom options at query time:

```ruby
# Use a different language for a specific search
User.full_text_search('bonjour', language: 'french')

# Use a different ranking threshold
User.full_text_search('rails', rank_threshold: 0.5)

# Use a custom set of fields
Post.full_text_search('design', fields: ['title', 'summary'])
```

---

See also: [API Filtering documentation](./api_filtering.md) for more advanced usage and examples. 