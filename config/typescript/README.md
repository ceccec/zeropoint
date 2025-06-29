# GraphQL UI Layout API Client - TypeScript

A comprehensive TypeScript client library for the GraphQL UI Layout API, providing type-safe access to all API endpoints with React hooks, utilities, and offline support.

## Features

- 🚀 **Type-Safe API Client** - Full TypeScript support with comprehensive type definitions
- ⚛️ **React Hooks** - Custom hooks for easy integration with React applications
- 🔄 **Offline Support** - Built-in caching and offline data synchronization
- 🛠️ **Utility Functions** - Helper functions for common operations
- 🔒 **Authentication** - Support for token and basic authentication
- 📊 **Pagination** - Built-in pagination support with hooks
- 🎯 **Error Handling** - Comprehensive error handling and retry logic
- 🎨 **Theme Management** - Dynamic theme updates and caching
- 📱 **File Management** - Upload, download, and file operations
- 📈 **Analytics** - Built-in analytics tracking
- 🔔 **Notifications** - Real-time notification management
- 💾 **Cache Management** - Advanced caching with TTL and patterns

## Installation

```bash
npm install @graphql-ui-layout/api-client
```

## Quick Start

### Basic Usage

```typescript
import { createClient } from '@graphql-ui-layout/api-client';

// Create API client
const client = createClient({
  baseURL: 'https://api.example.com/api/v1',
  timeout: 30000,
}, {
  token: 'your-auth-token'
});

// Fetch UI layout data
const layout = await client.getUILayout('dashboard');
console.log(layout);
```

### React Integration

```typescript
import React from 'react';
import { useAPIClient, useUILayout } from '@graphql-ui-layout/api-client';

function App() {
  const { client, isAuthenticated, login, logout } = useAPIClient({
    config: {
      baseURL: 'https://api.example.com/api/v1',
    },
    autoRefresh: true,
  });

  const {
    layout,
    navigation,
    theme,
    loading,
    error,
    updateTheme
  } = useUILayout(client, {
    page: 'dashboard',
    includeOfflineData: true,
    autoRefresh: true,
  });

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;

  return (
    <div style={{ backgroundColor: theme?.primary_color }}>
      <nav>
        {navigation?.items.map(item => (
          <a key={item.url} href={item.url}>{item.label}</a>
        ))}
      </nav>
      <main>
        {/* Your app content */}
      </main>
    </div>
  );
}
```

## API Reference

### Core Client

#### `createClient(config, auth?)`

Creates a new API client instance.

```typescript
import { createClient } from '@graphql-ui-layout/api-client';

const client = createClient({
  baseURL: 'https://api.example.com/api/v1',
  timeout: 30000,
  headers: {
    'X-Custom-Header': 'value'
  }
}, {
  token: 'your-auth-token'
});
```

#### `ZeropointClient`

The main client class with all API methods.

### React Hooks

#### `useAPIClient(options)`

Manages API client instance with authentication.

```typescript
const { client, isAuthenticated, login, logout, updateConfig } = useAPIClient({
  config: { baseURL: 'https://api.example.com/api/v1' },
  auth: { token: 'initial-token' },
  autoRefresh: true,
  refreshInterval: 300000
});
```

#### `useUILayout(client, options)`

Fetches and manages UI layout data with caching.

```typescript
const {
  layout,
  navigation,
  sidebar,
  contentAreas,
  widgets,
  actions,
  theme,
  config,
  permissions,
  loading,
  error,
  refetch,
  updateTheme,
  updateConfig,
  clearCache
} = useUILayout(client, {
  page: 'dashboard',
  includeOfflineData: true,
  autoRefresh: true,
  refreshInterval: 300000,
  cacheKey: 'ui-layout'
});
```

#### `useOfflineData(client, options)`

Manages offline data synchronization.

```typescript
const {
  offlineData,
  loading,
  error,
  syncRequired,
  lastSync,
  sync,
  clearOfflineData
} = useOfflineData(client, {
  autoSync: true,
  syncInterval: 60000
});
```

#### `useAPIState(fetchFn, dependencies)`

Generic hook for managing API state.

```typescript
const { data, loading, error, refetch } = useAPIState(
  () => client.getHealth(),
  []
);
```

#### `usePaginatedAPIState(fetchFn, initialPage, initialPerPage)`

Hook for paginated data.

```typescript
const {
  data,
  loading,
  error,
  page,
  perPage,
  totalCount,
  totalPages,
  hasNextPage,
  hasPreviousPage,
  nextPage,
  previousPage,
  goToPage,
  setPerPage
} = usePaginatedAPIState(
  (page, perPage) => client.listFiles({ page, per_page: perPage }),
  1,
  20
);
```

### API Endpoints

#### Health Check

```typescript
const health = await client.getHealth();
```

#### GraphQL

```typescript
// Execute GraphQL query
const result = await client.executeQuery({
  query: '{ user { id name } }',
  variables: { userId: 123 }
});

// Get schema
const schema = await client.getSchema();

// Validate query
const validation = await client.validateQuery('{ user { id } }');
```

#### UI Layout

```typescript
// Get complete layout
const layout = await client.getUILayout('dashboard', true);

// Get specific components
const navigation = await client.getNavigation('dashboard');
const sidebar = await client.getSidebar('dashboard');
const contentAreas = await client.getContentAreas('dashboard');
const widgets = await client.getWidgets('dashboard');
const actions = await client.getActions('dashboard');
const theme = await client.getTheme();
const config = await client.getConfig();
const permissions = await client.getPermissions();

// Update theme
await client.updateTheme({
  primary_color: '#007bff',
  secondary_color: '#6c757d'
});

// Update config
await client.updateConfig({
  app_name: 'My App',
  default_locale: 'en'
});
```

#### Search

```typescript
// Global search
const results = await client.globalSearch({
  query: 'search term',
  models: ['posts', 'users'],
  search_type: 'full_text',
  page: 1,
  per_page: 20
});

// Specific searches
const posts = await client.searchPosts({
  query: 'technology',
  tags: ['programming'],
  published: true
});

const users = await client.searchUsers({
  query: 'john',
  roles: ['admin', 'moderator']
});

// Get suggestions
const suggestions = await client.getSuggestions({
  query: 'prog',
  models: ['posts'],
  limit: 5
});
```

#### File Management

```typescript
// Upload file
const upload = await client.uploadFile({
  file: fileInput.files[0],
  category: 'documents',
  tags: ['important', 'report'],
  description: 'Monthly report'
});

// List files
const files = await client.listFiles({
  category: 'documents',
  tags: ['important'],
  page: 1,
  per_page: 20
});

// Get file
const file = await client.getFile(123);

// Update file
await client.updateFile(123, {
  category: 'archived',
  tags: ['archived'],
  description: 'Updated description'
});

// Delete file
await client.deleteFile(123);

// Bulk upload
const bulkResult = await client.bulkUpload({
  files: [file1, file2, file3],
  category: 'documents',
  tags: ['bulk']
});
```

#### Analytics

```typescript
// Get page views
const pageViews = await client.getPageViews({
  start_date: '2024-01-01',
  end_date: '2024-01-31',
  page: '/dashboard'
});

// Get user activity
const activity = await client.getUserActivity({
  start_date: '2024-01-01',
  end_date: '2024-01-31',
  user_id: 123
});

// Track event
await client.trackEvent({
  event_name: 'button_click',
  properties: { button_id: 'submit', page: '/form' },
  user_id: 123
});

// Get dashboard stats
const dashboard = await client.getDashboard();
```

#### Notifications

```typescript
// Get notifications
const notifications = await client.getNotifications({
  read: false,
  type: 'system',
  page: 1,
  per_page: 20
});

// Mark as read
await client.markNotificationAsRead(123);

// Mark all as read
await client.markAllNotificationsAsRead();

// Delete notification
await client.deleteNotification(123);

// Get preferences
const preferences = await client.getNotificationPreferences();

// Update preferences
await client.updateNotificationPreferences({
  email: true,
  push: false,
  types: {
    system: true,
    posts: false
  }
});
```

#### Cache Management

```typescript
// Get cache stats
const stats = await client.getCacheStats();

// Get cache keys
const keys = await client.getCacheKeys({
  pattern: 'user:*',
  limit: 100
});

// Get cache value
const value = await client.getCacheValue('user:123');

// Set cache value
await client.setCacheValue('user:123', {
  value: JSON.stringify(userData),
  ttl: 3600
});

// Delete cache key
await client.deleteCacheKey('user:123');

// Clear cache pattern
await client.clearCachePattern('user:*');

// Clear all cache
await client.clearAllCache();
```

### Utilities

#### Error Handling

```typescript
import { APIError } from '@graphql-ui-layout/api-client';

try {
  const data = await client.getUILayout();
} catch (error) {
  if (error instanceof APIError) {
    console.error(`API Error ${error.status}: ${error.message}`);
  }
}
```

#### Retry Logic

```typescript
import { withRetry } from '@graphql-ui-layout/api-client';

const result = await withRetry(
  () => client.getUILayout(),
  {
    maxAttempts: 3,
    delay: 1000,
    backoff: 2,
    shouldRetry: (error) => error.status >= 500
  }
);
```

#### Caching

```typescript
import { APICache } from '@graphql-ui-layout/api-client';

const cache = new APICache();
cache.set('layout', layoutData, 300000); // 5 minutes
const data = cache.get('layout');
```

#### Data Transformation

```typescript
import { toCamelCase, toSnakeCase } from '@graphql-ui-layout/api-client';

const camelData = toCamelCase({ user_name: 'john', created_at: '2024-01-01' });
// Result: { userName: 'john', createdAt: '2024-01-01' }

const snakeData = toSnakeCase({ userName: 'john', createdAt: '2024-01-01' });
// Result: { user_name: 'john', created_at: '2024-01-01' }
```

#### Validation

```typescript
import { validateEmail, validateURL, validateRequired } from '@graphql-ui-layout/api-client';

const isValidEmail = validateEmail('user@example.com');
const isValidURL = validateURL('https://example.com');
const isRequired = validateRequired('value');
```

#### File Utilities

```typescript
import { formatFileSize, isImageFile, isVideoFile } from '@graphql-ui-layout/api-client';

const size = formatFileSize(1024 * 1024); // "1 MB"
const isImage = isImageFile('photo.jpg'); // true
const isVideo = isVideoFile('video.mp4'); // true
```

## TypeScript Support

The library provides comprehensive TypeScript support with full type definitions for all API responses, request parameters, and utility functions.

```typescript
import type { 
  APIConfig, 
  AuthConfig, 
  UILayout, 
  Search,
  Files 
} from '@graphql-ui-layout/api-client';

// Type-safe configuration
const config: APIConfig = {
  baseURL: 'https://api.example.com/api/v1',
  timeout: 30000
};

// Type-safe authentication
const auth: AuthConfig = {
  token: 'your-token'
};

// Type-safe layout data
const layout: UILayout.LayoutData = await client.getUILayout();
```

## Error Handling

The library provides comprehensive error handling with custom error classes and utilities.

```typescript
import { APIError, withRetry } from '@graphql-ui-layout/api-client';

// Custom error handling
try {
  const data = await client.getUILayout();
} catch (error) {
  if (error instanceof APIError) {
    switch (error.status) {
      case 401:
        // Handle authentication error
        break;
      case 403:
        // Handle authorization error
        break;
      case 404:
        // Handle not found error
        break;
      case 500:
        // Handle server error
        break;
      default:
        // Handle other errors
        break;
    }
  }
}

// Retry with exponential backoff
const data = await withRetry(
  () => client.getUILayout(),
  {
    maxAttempts: 3,
    delay: 1000,
    backoff: 2,
    shouldRetry: (error) => error.status >= 500
  }
);
```

## Offline Support

The library includes built-in offline support with caching and synchronization.

```typescript
import { useUILayout, useOfflineData } from '@graphql-ui-layout/api-client';

function App() {
  const { layout, loading, error } = useUILayout(client, {
    includeOfflineData: true,
    cacheKey: 'ui-layout'
  });

  const { offlineData, syncRequired, sync } = useOfflineData(client, {
    autoSync: true
  });

  // Layout data is automatically cached and available offline
  // Sync happens automatically when connection is restored
}
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

MIT License - see LICENSE file for details. 