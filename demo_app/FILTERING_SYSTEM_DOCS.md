# Filtering and Searching System Documentation

## Overview

The GraphQL UI Layout demo application includes a comprehensive filtering and searching system that provides flexible, chainable filtering capabilities for ActiveRecord models. This system is built on Rails concerns and service objects, making it easy to implement complex filtering and searching functionality.

## Architecture

### Core Components

1. **Filterable Concern** - Provides filtering and searching capabilities to models
2. **FilterService** - Service object for complex filtering operations
3. **FilterableController** - Controller concern for handling filtering requests
4. **Configuration** - Model-level configuration for filtering options

## Basic Usage

### 1. Model Setup

```ruby
class Post < ApplicationRecord
  include Filterable
  
  # Configure filterable options
  filterable(
    searchable_columns: %w[title content slug],
    filterable_columns: %w[title content status user_id created_at],
    excluded_columns: %w[id],
    custom_filters: {},
    default_filters: { status: 'published' }
  )
end
```

### 2. Basic Filtering

```ruby
# Simple equality filter
posts = Post.filter_by(status: 'published')

# Multiple filters
posts = Post.filter_by(status: 'published', user_id: 1)

# Search
posts = Post.search('rails')

# Combined filtering and search
posts = Post.filter_and_search({ status: 'published' }, 'rails')
```

## Advanced Filtering

### 1. Operator-Based Filtering

```ruby
# Greater than
posts = Post.filter_by(views: { gt: 100 })

# Less than or equal
posts = Post.filter_by(created_at: { lte: 1.week.ago })

# Contains (LIKE)
posts = Post.filter_by(title: { contains: 'rails' })

# Starts with
posts = Post.filter_by(title: { starts_with: 'How to' })

# Ends with
posts = Post.filter_by(title: { ends_with: 'tutorial' })

# Not equals
posts = Post.filter_by(status: { ne: 'draft' })

# In array
posts = Post.filter_by(status: { in: ['published', 'draft'] })

# Not in array
posts = Post.filter_by(status: { not_in: ['archived'] })

# Null check
posts = Post.filter_by(published_at: { null: true })

# Between range
posts = Post.filter_by(views: { between: { start: 10, end: 100 } })
```

### 2. Date Range Filtering

```ruby
# Date range
posts = Post.filter_by(created_at: {
  date_range: {
    start: 1.month.ago,
    end: Date.current
  }
})

# Only start date
posts = Post.filter_by(created_at: {
  date_range: { start: 1.week.ago }
})

# Only end date
posts = Post.filter_by(created_at: {
  date_range: { end: Date.current }
})
```

### 3. Boolean Filtering

```ruby
# Boolean values
posts = Post.filter_by(published: { boolean: true })
posts = Post.filter_by(published: { boolean: 'yes' })
posts = Post.filter_by(published: { boolean: '1' })
```

### 4. Association Filtering

```ruby
# Filter by association
posts = Post.filter_by(user_id: { association: 1 })

# This will join with users table and filter by user.id
```

## Custom Filters

### 1. Adding Custom Filters

```ruby
class Post < ApplicationRecord
  include Filterable
  
  # Add custom filter
  add_custom_filter :tagged_with do |relation, field, value|
    relation.tagged_with(value) if respond_to?(:tagged_with)
  end
  
  add_custom_filter :by_author do |relation, field, value|
    relation.joins(:user).where(users: { username: value })
  end
  
  add_custom_filter :popular do |relation, field, value|
    if value
      relation.joins(:likes).group('posts.id').having('COUNT(likes.id) >= ?', 5)
    else
      relation
    end
  end
end
```

### 2. Using Custom Filters

```ruby
# Use custom filters
posts = Post.filter_by(tagged_with: 'ruby')
posts = Post.filter_by(by_author: 'john_doe')
posts = Post.filter_by(popular: true)
```

## Search Functionality

### 1. Basic Search

```ruby
# Simple search
posts = Post.search('rails')

# Search with multiple columns
posts = Post.search('ruby on rails')
```

### 2. Advanced Search Integration

```ruby
# With PgSearch
if defined?(PgSearch)
  posts = Post.search('rails') # Uses pg_search_scope
end

# With Searchkick
if defined?(Searchkick)
  posts = Post.search('rails') # Uses Searchkick
end

# Fallback to basic ILIKE search
posts = Post.search('rails') # Uses basic search
```

## Pagination and Ordering

### 1. Pagination with Filtering

```ruby
# Paginate with filters
posts = Post.filter_and_paginate(
  { status: 'published' },
  'rails',
  page: 1,
  per_page: 20
)
```

### 2. Ordering

```ruby
# Order by specific field
posts = Post.filter_by(status: 'published').order(:created_at)

# Order by multiple fields
posts = Post.filter_by(status: 'published').order('created_at DESC, title ASC')
```

## FilterService Usage

### 1. Basic Service Usage

```ruby
filter_service = FilterService.new(Post)

# Filter with metadata
result = filter_service.filter_with_metadata(
  { status: 'published' },
  'rails',
  { includes: [:user, :tags] }
)

puts result[:total_count]
puts result[:resources].count
puts result[:filters_applied]
```

### 2. Advanced Service Features

```ruby
# Validate filters
errors = filter_service.validate_filters({ invalid_field: 'value' })
puts errors # ["Invalid filter field: invalid_field"]

# Get filter suggestions
suggestions = filter_service.filter_suggestions('status', 'pub')
puts suggestions # ["published"]

# Export filtered data
csv_data = filter_service.export_filtered_data(
  { status: 'published' },
  'rails',
  format: :csv
)
```

## Controller Integration

### 1. Basic Controller Setup

```ruby
class PostsController < ApplicationController
  include FilterableController
  
  def index
    @filters = extract_filters
    @query = extract_query
    @options = extract_options
    
    @posts = filter_resources(@filters, @query, @options)
    
    respond_to_formats
  end
end
```

### 2. Advanced Controller Features

```ruby
class PostsController < ApplicationController
  include FilterableController
  
  # Filter options endpoint
  def filter_options
    render json: @filter_service.filter_options
  end
  
  # Filter suggestions endpoint
  def filter_suggestions
    field = params[:field]
    query = params[:query]
    
    suggestions = @filter_service.filter_suggestions(field, query)
    render json: { suggestions: suggestions }
  end
  
  # Export endpoint
  def export
    @filters = extract_filters
    @query = extract_query
    @options = extract_options.merge(paginate: false)
    format = params[:format] || :csv
    
    data = @filter_service.export_filtered_data(@filters, @query, format: format, options: @options)
    
    send_data data, filename: "posts_#{Time.current.strftime('%Y%m%d_%H%M%S')}.#{format}"
  end
end
```

## Configuration Options

### 1. Model Configuration

```ruby
class Post < ApplicationRecord
  include Filterable
  
  filterable(
    # Columns to search in
    searchable_columns: %w[title content slug],
    
    # Columns that can be filtered
    filterable_columns: %w[title content status user_id created_at updated_at views],
    
    # Columns to exclude from filtering
    excluded_columns: %w[id],
    
    # Custom filters (defined separately)
    custom_filters: {},
    
    # Default filters to always apply
    default_filters: { status: 'published' }
  )
end
```

### 2. Adding Default Filters

```ruby
class Post < ApplicationRecord
  include Filterable
  
  # Add default filter
  add_default_filter :status, 'published'
  add_default_filter :user_id, -> { current_user.id } if respond_to?(:current_user)
end
```

## API Examples

### 1. RESTful API Usage

```ruby
# GET /posts?status=published&title[contains]=rails&page=1&per_page=10
def index
  @filters = extract_filters # { status: 'published', title: { contains: 'rails' } }
  @query = extract_query
  @options = extract_options # { page: 1, per_page: 10 }
  
  @posts = filter_resources(@filters, @query, @options)
  
  render json: {
    posts: @posts,
    pagination: build_pagination_info,
    metadata: build_metadata
  }
end
```

### 2. GraphQL Integration

```ruby
# GraphQL resolver
class PostsResolver
  def resolve(filters: {}, query: nil, page: 1, per_page: 20)
    filter_service = FilterService.new(Post)
    
    filter_service.filter_and_paginate(
      filters,
      query,
      page: page,
      per_page: per_page
    )
  end
end
```

## Performance Considerations

### 1. Database Optimization

```ruby
# Use includes to avoid N+1 queries
posts = Post.filter_by(status: 'published').includes(:user, :tags)

# Use select to limit columns
posts = Post.filter_by(status: 'published').select(:id, :title, :user_id)

# Use distinct to avoid duplicates
posts = Post.filter_by(tagged_with: 'ruby').distinct
```

### 2. Caching

```ruby
# Cache filter results
posts = Rails.cache.fetch("posts_filtered_#{filters.hash}_#{query}", expires_in: 1.hour) do
  Post.filter_and_search(filters, query)
end
```

### 3. Indexing

```ruby
# Add database indexes for frequently filtered columns
add_index :posts, :status
add_index :posts, :user_id
add_index :posts, :created_at
add_index :posts, [:status, :created_at]
```

## Testing

### 1. Model Testing

```ruby
RSpec.describe Post, type: :model do
  describe 'filtering' do
    let!(:published_post) { create(:post, status: 'published') }
    let!(:draft_post) { create(:post, status: 'draft') }
    
    it 'filters by status' do
      expect(Post.filter_by(status: 'published')).to include(published_post)
      expect(Post.filter_by(status: 'published')).not_to include(draft_post)
    end
    
    it 'searches content' do
      post = create(:post, title: 'Rails tutorial')
      expect(Post.search('rails')).to include(post)
    end
  end
end
```

### 2. Controller Testing

```ruby
RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    it 'filters posts' do
      get :index, params: { status: 'published' }
      
      expect(response).to be_successful
      expect(assigns(:posts)).to all(have_attributes(status: 'published'))
    end
    
    it 'searches posts' do
      get :index, params: { q: 'rails' }
      
      expect(response).to be_successful
      expect(assigns(:posts)).to be_present
    end
  end
end
```

## Best Practices

### 1. Security

```ruby
# Sanitize filter parameters
def extract_filters
  filters = {}
  
  # Only allow known filterable columns
  filterable_columns.each do |column|
    if params[column].present?
      filters[column] = sanitize_filter_value(params[column])
    end
  end
  
  filters
end

def sanitize_filter_value(value)
  # Implement value sanitization based on your needs
  value
end
```

### 2. Performance

```ruby
# Use pagination for large datasets
posts = Post.filter_and_paginate(filters, query, page: 1, per_page: 50)

# Use includes to avoid N+1 queries
posts = Post.filter_by(status: 'published').includes(:user, :tags)

# Use database indexes
add_index :posts, [:status, :created_at]
```

### 3. Maintainability

```ruby
# Use constants for common filters
class Post < ApplicationRecord
  include Filterable
  
  COMMON_FILTERS = {
    published: { status: 'published' },
    recent: { created_at: { gte: 1.week.ago } },
    popular: { popular: true }
  }
  
  def self.with_common_filter(filter_name)
    filter_by(COMMON_FILTERS[filter_name])
  end
end
```

## Conclusion

The filtering and searching system provides a robust, flexible foundation for implementing complex filtering and searching functionality in Rails applications. It supports:

- Multiple filter types (equality, range, boolean, association)
- Custom filters for model-specific logic
- Search integration with multiple backends
- Pagination and ordering
- Export functionality
- Performance optimization
- Comprehensive testing support

This makes it suitable for applications ranging from simple blogs to complex enterprise systems with sophisticated filtering requirements. 