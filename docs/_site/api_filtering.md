# Filterable API Documentation

## Overview

The Filterable concern provides a powerful and secure filtering system for Rails APIs. This document covers the API endpoints, parameters, and usage patterns for implementing filtered queries in your Rails controllers.

## Base URL

All API endpoints follow the standard Rails REST conventions:

```
GET /api/users
GET /api/posts
GET /api/comments
```

## Authentication

All endpoints require authentication unless specified otherwise. Include your authentication token in the request headers:

```
Authorization: Bearer <your-token>
```

## Common Parameters

### Filters Parameter

The `filters` parameter accepts a hash of filter conditions:

```json
{
  "filters": {
    "field_name": "value",
    "another_field": {
      "operator": "value"
    }
  }
}
```

### Pagination Parameters

- `limit` (integer): Number of records per page (default: 20, max: 100)
- `offset` (integer): Number of records to skip (default: 0)
- `page` (integer): Page number (alternative to offset)

### Sorting Parameters

- `sort` (string): Field to sort by
- `order` (string): Sort order (`asc` or `desc`, default: `asc`)

## Filter Types

### 1. String Filters

#### Basic String Matching

```http
GET /api/users?filters[name]=alice
```

**Response:**
```json
{
  "users": [
    {
      "id": 1,
      "name": "Alice Johnson",
      "email": "alice@example.com"
    }
  ],
  "total": 1,
  "pagination": {
    "limit": 20,
    "offset": 0,
    "total": 1
  }
}
```

#### String Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `eq` | Exact match | `filters[name][eq]=Alice Johnson` |
| `like` | Partial match | `filters[name][like]=alice` |
| `starts_with` | Starts with | `filters[email][starts_with]=admin@` |
| `ends_with` | Ends with | `filters[email][ends_with]=@example.com` |

**Examples:**

```http
# Exact match
GET /api/users?filters[name][eq]=Alice Johnson

# Partial match
GET /api/users?filters[name][like]=alice

# Starts with
GET /api/users?filters[email][starts_with]=admin@

# Ends with
GET /api/users?filters[email][ends_with]=@example.com
```

### 2. Boolean Filters

```http
GET /api/users?filters[active]=true
GET /api/users?filters[active]=false
GET /api/users?filters[active]=1
GET /api/users?filters[active]=0
```

**Supported Values:**
- `true`, `false`
- `"true"`, `"false"`
- `1`, `0`
- `"1"`, `"0"`

### 3. Date Filters

#### Relative Dates

```http
GET /api/users?filters[created_at]=today
GET /api/users?filters[created_at]=this_week
GET /api/users?filters[created_at]=this_month
GET /api/users?filters[created_at]=this_year
```

#### Date Ranges

```http
GET /api/users?filters[created_at][from]=2024-06-01&filters[created_at][to]=2024-06-30
```

#### Single Date

```http
GET /api/users?filters[created_at]=2024-06-15
```

### 4. Association Filters

```http
GET /api/users?filters[role_id]=1
GET /api/users?filters[role_id]=1,2,3
```

### 5. Array Filters

```http
GET /api/users?filters[role_id]=1,2,3
GET /api/users?filters[role_id][]=1&filters[role_id][]=2&filters[role_id][]=3
```

### 6. Custom Filters

#### Multi-field Search

```http
GET /api/users?filters[search]=john doe
```

**Response:**
```json
{
  "users": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "description": "Software developer"
    }
  ],
  "total": 1
}
```

#### Age Range Filter

```http
GET /api/users?filters[age_range]=18-25
GET /api/users?filters[age_range]=26-35
GET /api/users?filters[age_range]=36+
```

### 7. Nested Association Filters

#### Filter by Associated Model

```http
GET /api/users?filters[role][name]=admin
GET /api/users?filters[posts][status]=published
```

#### Filter by Through Associations

```http
GET /api/users?filters[tags]=admin,moderator
GET /api/users?filters[tags]=admin
```

## Multiple Filters

Combine any number of filter conditions:

```http
GET /api/users?filters[active]=true&filters[role][name]=admin&filters[created_at][from]=2024-01-01&filters[name][like]=alice
```

**Response:**
```json
{
  "users": [
    {
      "id": 1,
      "name": "Alice Johnson",
      "email": "alice@example.com",
      "active": true,
      "role": {
        "id": 1,
        "name": "admin"
      },
      "created_at": "2024-01-15T10:30:00Z"
    }
  ],
  "total": 1
}
```

## Pagination

### Basic Pagination

```http
GET /api/users?limit=10&offset=20
```

**Response:**
```json
{
  "users": [...],
  "total": 150,
  "pagination": {
    "limit": 10,
    "offset": 20,
    "total": 150,
    "pages": 15,
    "current_page": 3
  },
  "filters": {
    "active": "true",
    "role": {
      "name": "admin"
    },
    "created_at": {
      "from": "2024-01-01",
      "to": "2024-01-31"
    }
  }
}
```

### Page-based Pagination

```http
GET /api/users?page=2&per_page=10
```

### Pagination with Filters

```http
GET /api/users?filters[active]=true&limit=5&offset=0
```

## Sorting

### Basic Sorting

```http
GET /api/users?sort=name&order=asc
GET /api/users?sort=created_at&order=desc
```

### Multiple Sort Fields

```http
GET /api/users?sort=active,name&order=desc,asc
```

### Sorting with Filters

```http
GET /api/users?filters[active]=true&sort=name&order=asc
```

## Response Format

### Success Response

```json
{
  "users": [
    {
      "id": 1,
      "name": "Alice Johnson",
      "email": "alice@example.com",
      "active": true,
      "created_at": "2024-06-01T10:30:00Z",
      "updated_at": "2024-06-01T10:30:00Z",
      "role": {
        "id": 1,
        "name": "admin"
      },
      "posts": [
        {
          "id": 1,
          "title": "Ruby Tips",
          "status": "published"
        }
      ],
      "tags": [
        {
          "id": 1,
          "name": "admin"
        }
      ]
    }
  ],
  "total": 1,
  "pagination": {
    "limit": 20,
    "offset": 0,
    "total": 1,
    "pages": 1,
    "current_page": 1
  },
  "filters": {
    "active": "true",
    "name": {
      "like": "alice"
    },
    "role": {
      "name": "admin"
    },
    "created_at": {
      "from": "2024-01-01",
      "to": "2024-01-31"
    }
  }
}
```

### Error Response

```json
{
  "error": "Invalid filter parameter",
  "message": "Field 'invalid_field' is not filterable",
  "status": 400
}
```

## Controller Implementation

### Basic Implementation

```ruby
class UsersController < ApplicationController
  def index
    filters = params[:filters] || {}
    users = User.filter_by(filters)
               .includes(:role, :posts, :tags)
               .distinct
    
    render json: {
      users: users.as_json(include: [:role, :posts, :tags]),
      total: users.count,
      filters: filters
    }
  end
end
```

### With Pagination

```ruby
class UsersController < ApplicationController
  def index
    filters = params[:filters] || {}
    limit = [params[:limit]&.to_i || 20, 100].min
    offset = params[:offset]&.to_i || 0
    
    users = User.filter_by(filters)
               .includes(:role, :posts, :tags)
               .distinct
               .limit(limit)
               .offset(offset)
    
    total = User.filter_by(filters).count
    
    render json: {
      users: users.as_json(include: [:role, :posts, :tags]),
      total: total,
      pagination: {
        limit: limit,
        offset: offset,
        total: total,
        pages: (total.to_f / limit).ceil,
        current_page: (offset / limit) + 1
      },
      filters: filters
    }
  end
end
```

### With Sorting

```ruby
class UsersController < ApplicationController
  def index
    filters = params[:filters] || {}
    sort_field = params[:sort] || 'created_at'
    sort_order = params[:order] || 'desc'
    
    users = User.filter_by(filters)
               .includes(:role, :posts, :tags)
               .distinct
               .order(sort_field => sort_order)
    
    render json: {
      users: users.as_json(include: [:role, :posts, :tags]),
      total: users.count,
      filters: filters,
      sorting: {
        field: sort_field,
        order: sort_order
      }
    }
  end
end
```

## Error Handling

### Common Error Codes

| Status | Description |
|--------|-------------|
| 400 | Bad Request - Invalid filter parameters |
| 401 | Unauthorized - Missing or invalid authentication |
| 403 | Forbidden - Insufficient permissions |
| 404 | Not Found - Resource not found |
| 422 | Unprocessable Entity - Validation errors |
| 500 | Internal Server Error - Server error |

### Error Response Format

```json
{
  "error": "Bad Request",
  "message": "Invalid filter parameter",
  "details": {
    "field": "created_at",
    "value": "invalid-date",
    "reason": "Invalid date format"
  },
  "status": 400
}
```

## Security Considerations

### Field Whitelisting

Only fields defined in the model's `filterable_fields` method can be filtered:

```ruby
class User < ApplicationRecord
  include Filterable
  
  def self.filterable_fields
    {
      'name' => :string,
      'email' => :string,
      'active' => :boolean,
      # 'password' is NOT included - cannot be filtered
    }
  end
end
```

### SQL Injection Prevention

All queries use parameterized statements automatically:

```http
GET /api/users?filters[name]='; DROP TABLE users; --
```

This will be safely handled as a literal string search.

### Input Validation

The API automatically validates and sanitizes all input:

- Invalid dates are handled gracefully
- Malformed JSON is rejected
- Non-whitelisted fields are ignored
- Empty or nil values are handled appropriately

## Performance Optimization

### Eager Loading

Always use `includes` to avoid N+1 queries:

```ruby
User.filter_by(filters).includes(:role, :posts, :tags)
```

### Database Indexes

Add indexes for frequently filtered fields:

```ruby
# In your migration
add_index :users, :name
add_index :users, :email
add_index :users, :active
add_index :users, :created_at
add_index :users, :role_id
```

### Query Optimization

The concern generates efficient SQL queries:

```sql
SELECT DISTINCT users.* 
FROM users 
LEFT JOIN roles ON roles.id = users.role_id 
LEFT JOIN posts ON posts.user_id = users.id 
LEFT JOIN user_tags ON user_tags.user_id = users.id 
LEFT JOIN tags ON tags.id = user_tags.tag_id 
WHERE users.active = true 
  AND roles.name = 'admin' 
  AND users.name LIKE '%alice%'
```

## Rate Limiting

API endpoints are subject to rate limiting:

- **Authenticated requests**: 1000 requests per hour
- **Unauthenticated requests**: 100 requests per hour

Rate limit headers are included in responses:

```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1640995200
```

## Caching

### Response Caching

Responses are cached for 5 minutes by default:

```
Cache-Control: public, max-age=300
ETag: "abc123"
```

### Cache Invalidation

Cache is automatically invalidated when:

- Records are created, updated, or deleted
- Filter parameters change
- Pagination parameters change

## Examples

### Complete API Example

```bash
# Get all active admin users created this month
curl -X GET "https://api.example.com/users" \
  -H "Authorization: Bearer your-token" \
  -H "Content-Type: application/json" \
  -G \
  -d "filters[active]=true" \
  -d "filters[role][name]=admin" \
  -d "filters[created_at]=this_month" \
  -d "limit=10" \
  -d "offset=0" \
  -d "sort=name" \
  -d "order=asc"
```

**Response:**
```json
{
  "users": [
    {
      "id": 1,
      "name": "Alice Johnson",
      "email": "alice@example.com",
      "active": true,
      "role": {
        "id": 1,
        "name": "admin"
      },
      "created_at": "2024-06-01T10:30:00Z"
    }
  ],
  "total": 1,
  "pagination": {
    "limit": 10,
    "offset": 0,
    "total": 1,
    "pages": 1,
    "current_page": 1
  },
  "filters": {
    "active": "true",
    "role": {
      "name": "admin"
    },
    "created_at": "this_month"
  },
  "sorting": {
    "field": "name",
    "order": "asc"
  }
}
```

### JavaScript Example

```javascript
// Using fetch API
const fetchUsers = async (filters = {}) => {
  const params = new URLSearchParams();
  
  if (Object.keys(filters).length > 0) {
    params.append('filters', JSON.stringify(filters));
  }
  
  const response = await fetch(`/api/users?${params}`, {
    headers: {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    }
  });
  
  return response.json();
};

// Usage
const users = await fetchUsers({
  active: true,
  role: { name: 'admin' },
  name: { like: 'alice' }
});
```

### React Hook Example

```javascript
import { useState, useEffect } from 'react';

const useFilteredUsers = (filters = {}) => {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    const fetchUsers = async () => {
      setLoading(true);
      try {
        const params = new URLSearchParams();
        if (Object.keys(filters).length > 0) {
          params.append('filters', JSON.stringify(filters));
        }
        
        const response = await fetch(`/api/users?${params}`);
        const data = await response.json();
        
        setUsers(data.users);
        setError(null);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    
    fetchUsers();
  }, [filters]);
  
  return { users, loading, error };
};

// Usage
const { users, loading, error } = useFilteredUsers({
  active: true,
  role: { name: 'admin' }
});
```

## Best Practices

### 1. Use Appropriate Filter Types

```ruby
# Good
filters[name] = 'alice'           # String filter
filters[active] = true            # Boolean filter
filters[created_at] = 'today'     # Date filter
filters[role_id] = [1, 2, 3]     # Array filter

# Avoid
filters[name] = 123               # Wrong type
filters[active] = 'yes'           # Inconsistent boolean
```

### 2. Optimize for Performance

```ruby
# Good - Use includes and distinct
User.filter_by(filters)
    .includes(:role, :posts, :tags)
    .distinct

# Avoid - N+1 queries
User.filter_by(filters).each { |user| user.role.name }
```

### 3. Handle Edge Cases

```ruby
# Good - Validate input
filters = params[:filters] || {}
limit = [params[:limit]&.to_i || 20, 100].min

# Avoid - Trust user input
limit = params[:limit].to_i
```

### 4. Provide Meaningful Error Messages

```ruby
# Good
render json: {
  error: 'Invalid filter parameter',
  message: "Field '#{field}' is not filterable",
  status: 400
}, status: :bad_request

# Avoid
render json: { error: 'Bad request' }, status: 400
```

## Troubleshooting

### Common Issues

1. **Filter not working**: Check if the field is in `filterable_fields`
2. **Performance issues**: Add database indexes and use `includes`
3. **Duplicate results**: Use `distinct` when filtering through associations
4. **SQL injection**: All queries are automatically parameterized

### Debugging

Enable SQL logging to see generated queries:

```ruby
# In development
ActiveRecord::Base.logger = Logger.new(STDOUT)

# Check generated SQL
User.filter_by(filters).to_sql
```

### Support

For issues and questions:

- **Documentation**: [Filterable Concern Docs](./filterable_concern.md)
- **Examples**: [Filterable Examples](./examples/filterable_demo.rb)
- **Tests**: [Filterable Tests](./spec/models/concerns/filterable_spec.rb)
- **Issues**: GitHub Issues
- **Discussions**: GitHub Discussions 