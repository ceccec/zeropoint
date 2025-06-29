// GraphQL UI Layout API Client
// TypeScript client library for the unified API

import type * as API from './graphql-ui-layout-api';

class ZeropointClient implements API.APIClient {
  private config: API.APIConfig;
  private auth: API.AuthConfig;

  constructor(config: API.APIConfig, auth?: API.AuthConfig) {
    this.config = {
      baseURL: config.baseURL.replace(/\/$/, ''),
      timeout: config.timeout || 30000,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...config.headers,
      },
    };
    this.auth = auth || {};
  }

  private async request<T>(
    method: string,
    endpoint: string,
    data?: any,
    params?: Record<string, any>
  ): Promise<T> {
    const url = new URL(`${this.config.baseURL}${endpoint}`);
    
    if (params) {
      Object.entries(params).forEach(([key, value]) => {
        if (value !== undefined && value !== null) {
          url.searchParams.append(key, String(value));
        }
      });
    }

    const headers: Record<string, string> = { ...this.config.headers };

    // Add authentication headers
    if (this.auth.token) {
      headers['Authorization'] = `Bearer ${this.auth.token}`;
    } else if (this.auth.username && this.auth.password) {
      const credentials = btoa(`${this.auth.username}:${this.auth.password}`);
      headers['Authorization'] = `Basic ${credentials}`;
    }

    const requestOptions: RequestInit = {
      method,
      headers,
      signal: AbortSignal.timeout(this.config.timeout || 30000),
    };

    if (data && method !== 'GET') {
      requestOptions.body = JSON.stringify(data);
    }

    try {
      const response = await fetch(url.toString(), requestOptions);
      
      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        throw new Error(errorData.error || `HTTP ${response.status}: ${response.statusText}`);
      }

      return await response.json();
    } catch (error) {
      if (error instanceof Error) {
        throw new Error(`API request failed: ${error.message}`);
      }
      throw new Error('API request failed');
    }
  }

  // Health Check
  async getHealth(): Promise<API.HealthCheck> {
    return this.request<API.HealthCheck>('GET', '/health');
  }

  // GraphQL Endpoints
  async executeQuery(request: API.GraphQL.QueryRequest): Promise<API.GraphQL.QueryResponse> {
    return this.request<API.GraphQL.QueryResponse>('POST', '/graphql/query', request);
  }

  async getSchema(): Promise<API.GraphQL.SchemaResponse> {
    return this.request<API.GraphQL.SchemaResponse>('GET', '/graphql/schema');
  }

  async getTypes(): Promise<API.GraphQL.TypesResponse> {
    return this.request<API.GraphQL.TypesResponse>('GET', '/graphql/types');
  }

  async getQueries(): Promise<API.GraphQL.QueriesResponse> {
    return this.request<API.GraphQL.QueriesResponse>('GET', '/graphql/queries');
  }

  async getMutations(): Promise<API.GraphQL.MutationsResponse> {
    return this.request<API.GraphQL.MutationsResponse>('GET', '/graphql/mutations');
  }

  async validateQuery(query: string): Promise<API.GraphQL.ValidationResponse> {
    return this.request<API.GraphQL.ValidationResponse>('POST', '/graphql/validate', { query });
  }

  // UI Layout Endpoints
  async getUILayout(page?: string, includeOfflineData?: boolean): Promise<API.UILayout.LayoutResponse> {
    const params: Record<string, any> = {};
    if (page) params.page = page;
    if (includeOfflineData) params.include_offline_data = includeOfflineData;
    
    return this.request<API.UILayout.LayoutResponse>('GET', '/ui-layout', undefined, params);
  }

  async getNavigation(page?: string): Promise<API.UILayout.NavigationResponse> {
    const params = page ? { page } : undefined;
    return this.request<API.UILayout.NavigationResponse>('GET', '/ui-layout/navigation', undefined, params);
  }

  async getSidebar(page: string): Promise<API.UILayout.SidebarResponse> {
    return this.request<API.UILayout.SidebarResponse>('GET', '/ui-layout/sidebar', undefined, { page });
  }

  async getContentAreas(page?: string): Promise<API.UILayout.ContentAreasResponse> {
    const params = page ? { page } : undefined;
    return this.request<API.UILayout.ContentAreasResponse>('GET', '/ui-layout/content-areas', undefined, params);
  }

  async getWidgets(page?: string): Promise<API.UILayout.WidgetsResponse> {
    const params = page ? { page } : undefined;
    return this.request<API.UILayout.WidgetsResponse>('GET', '/ui-layout/widgets', undefined, params);
  }

  async getActions(page?: string): Promise<API.UILayout.ActionsResponse> {
    const params = page ? { page } : undefined;
    return this.request<API.UILayout.ActionsResponse>('GET', '/ui-layout/actions', undefined, params);
  }

  async getTheme(): Promise<API.UILayout.ThemeResponse> {
    return this.request<API.UILayout.ThemeResponse>('GET', '/ui-layout/theme');
  }

  async getConfig(): Promise<API.UILayout.ConfigResponse> {
    return this.request<API.UILayout.ConfigResponse>('GET', '/ui-layout/config');
  }

  async getOfflineData(): Promise<API.UILayout.OfflineDataResponse> {
    return this.request<API.UILayout.OfflineDataResponse>('GET', '/ui-layout/offline-data');
  }

  async getPermissions(): Promise<API.UILayout.PermissionsResponse> {
    return this.request<API.UILayout.PermissionsResponse>('GET', '/ui-layout/permissions');
  }

  async getCacheKeys(): Promise<API.UILayout.CacheKeysResponse>;
  async getCacheKeys(params?: API.Cache.CacheKeysParams): Promise<API.Cache.CacheKeysResponse>;
  async getCacheKeys(params?: API.Cache.CacheKeysParams): Promise<API.UILayout.CacheKeysResponse | API.Cache.CacheKeysResponse> {
    if (params) {
      // Cache Management getCacheKeys
      return this.request<API.Cache.CacheKeysResponse>('GET', '/cache/keys', undefined, params);
    } else {
      // UI Layout getCacheKeys
      return this.request<API.UILayout.CacheKeysResponse>('GET', '/ui-layout/cache-keys');
    }
  }

  async clearCache(): Promise<API.UILayout.CacheClearResponse> {
    return this.request<API.UILayout.CacheClearResponse>('DELETE', '/ui-layout/cache');
  }

  async updateTheme(theme: Partial<API.UILayout.Theme>): Promise<API.UILayout.ThemeResponse> {
    return this.request<API.UILayout.ThemeResponse>('PUT', '/ui-layout/theme', { theme });
  }

  async updateConfig(config: Partial<API.UILayout.AppConfig>): Promise<API.UILayout.ConfigResponse> {
    return this.request<API.UILayout.ConfigResponse>('PUT', '/ui-layout/config', { config });
  }

  // Search Endpoints
  async globalSearch(params: API.Search.SearchParams): Promise<API.Search.GlobalSearchResponse> {
    return this.request<API.Search.GlobalSearchResponse>('GET', '/search/global', undefined, params);
  }

  async searchPosts(params: API.Search.PostSearchParams): Promise<API.Search.PostSearchResponse> {
    return this.request<API.Search.PostSearchResponse>('GET', '/search/posts', undefined, params);
  }

  async searchUsers(params: API.Search.UserSearchParams): Promise<API.Search.UserSearchResponse> {
    return this.request<API.Search.UserSearchResponse>('GET', '/search/users', undefined, params);
  }

  async searchTags(params: API.Search.TagSearchParams): Promise<API.Search.TagSearchResponse> {
    return this.request<API.Search.TagSearchResponse>('GET', '/search/tags', undefined, params);
  }

  async getSuggestions(params: API.Search.SuggestionsParams): Promise<API.Search.SuggestionsResponse> {
    return this.request<API.Search.SuggestionsResponse>('GET', '/search/suggestions', undefined, params);
  }

  async getSearchStats(): Promise<API.Search.SearchStatsResponse> {
    return this.request<API.Search.SearchStatsResponse>('GET', '/search/stats');
  }

  async reindexSearch(models?: string[]): Promise<API.Search.ReindexResponse> {
    return this.request<API.Search.ReindexResponse>('POST', '/search/reindex', { models });
  }

  // File Management Endpoints
  async uploadFile(request: API.Files.FileUploadRequest): Promise<API.Files.FileUploadResponse> {
    const formData = new FormData();
    formData.append('file', request.file);
    if (request.category) formData.append('category', request.category);
    if (request.tags) formData.append('tags', JSON.stringify(request.tags));
    if (request.description) formData.append('description', request.description);

    const headers = { ...this.config.headers };
    delete headers['Content-Type']; // Let browser set multipart boundary

    const url = new URL(`${this.config.baseURL}/files/upload`);
    const authHeaders: Record<string, string> = {};
    
    if (this.auth.token) {
      authHeaders['Authorization'] = `Bearer ${this.auth.token}`;
    } else if (this.auth.username && this.auth.password) {
      const credentials = btoa(`${this.auth.username}:${this.auth.password}`);
      authHeaders['Authorization'] = `Basic ${credentials}`;
    }

    const response = await fetch(url.toString(), {
      method: 'POST',
      headers: { ...headers, ...authHeaders },
      body: formData,
      signal: AbortSignal.timeout(this.config.timeout || 30000),
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.error || `HTTP ${response.status}: ${response.statusText}`);
    }

    return response.json();
  }

  async getFile(id: number): Promise<API.Files.FileResponse> {
    return this.request<API.Files.FileResponse>('GET', `/files/${id}`);
  }

  async listFiles(params?: API.Files.FileListParams): Promise<API.Files.FileListResponse> {
    return this.request<API.Files.FileListResponse>('GET', '/files', undefined, params);
  }

  async updateFile(id: number, request: API.Files.FileUpdateRequest): Promise<API.Files.FileUpdateResponse> {
    return this.request<API.Files.FileUpdateResponse>('PUT', `/files/${id}`, request);
  }

  async deleteFile(id: number): Promise<API.Files.FileDeleteResponse> {
    return this.request<API.Files.FileDeleteResponse>('DELETE', `/files/${id}`);
  }

  async getFileStats(): Promise<API.Files.FileStatsResponse> {
    return this.request<API.Files.FileStatsResponse>('GET', '/files/stats');
  }

  async getFileCategories(): Promise<API.Files.FileCategoriesResponse> {
    return this.request<API.Files.FileCategoriesResponse>('GET', '/files/categories');
  }

  async getFileTags(): Promise<API.Files.FileTagsResponse> {
    return this.request<API.Files.FileTagsResponse>('GET', '/files/tags');
  }

  async bulkUpload(request: API.Files.BulkUploadRequest): Promise<API.Files.BulkUploadResponse> {
    const formData = new FormData();
    request.files.forEach((file, index) => {
      formData.append(`files[${index}]`, file);
    });
    if (request.category) formData.append('category', request.category);
    if (request.tags) formData.append('tags', JSON.stringify(request.tags));

    const headers = { ...this.config.headers };
    delete headers['Content-Type'];

    const url = new URL(`${this.config.baseURL}/files/bulk-upload`);
    const authHeaders: Record<string, string> = {};
    
    if (this.auth.token) {
      authHeaders['Authorization'] = `Bearer ${this.auth.token}`;
    } else if (this.auth.username && this.auth.password) {
      const credentials = btoa(`${this.auth.username}:${this.auth.password}`);
      authHeaders['Authorization'] = `Basic ${credentials}`;
    }

    const response = await fetch(url.toString(), {
      method: 'POST',
      headers: { ...headers, ...authHeaders },
      body: formData,
      signal: AbortSignal.timeout(this.config.timeout || 30000),
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.error || `HTTP ${response.status}: ${response.statusText}`);
    }

    return response.json();
  }

  async getFileURL(id: number, expiresIn?: number): Promise<API.Files.FileURLResponse> {
    const params = expiresIn ? { expires_in: expiresIn } : undefined;
    return this.request<API.Files.FileURLResponse>('GET', `/files/${id}/url`, undefined, params);
  }

  // Analytics Endpoints
  async getPageViews(params?: API.Analytics.PageViewsParams): Promise<API.Analytics.PageViewsResponse> {
    return this.request<API.Analytics.PageViewsResponse>('GET', '/analytics/page-views', undefined, params);
  }

  async getUserActivity(params?: API.Analytics.UserActivityParams): Promise<API.Analytics.UserActivityResponse> {
    return this.request<API.Analytics.UserActivityResponse>('GET', '/analytics/user-activity', undefined, params);
  }

  async getSearchAnalytics(params?: API.Analytics.SearchAnalyticsParams): Promise<API.Analytics.SearchAnalyticsResponse> {
    return this.request<API.Analytics.SearchAnalyticsResponse>('GET', '/analytics/search', undefined, params);
  }

  async getFileUploadAnalytics(params?: API.Analytics.FileUploadAnalyticsParams): Promise<API.Analytics.FileUploadAnalyticsResponse> {
    return this.request<API.Analytics.FileUploadAnalyticsResponse>('GET', '/analytics/file-uploads', undefined, params);
  }

  async getEngagement(params?: API.Analytics.EngagementParams): Promise<API.Analytics.EngagementResponse> {
    return this.request<API.Analytics.EngagementResponse>('GET', '/analytics/engagement', undefined, params);
  }

  async getDashboard(): Promise<API.Analytics.DashboardResponse> {
    return this.request<API.Analytics.DashboardResponse>('GET', '/analytics/dashboard');
  }

  async trackEvent(request: API.Analytics.TrackEventRequest): Promise<API.Analytics.TrackEventResponse> {
    return this.request<API.Analytics.TrackEventResponse>('POST', '/analytics/track', request);
  }

  async getPopularContent(params?: API.Analytics.PopularContentParams): Promise<API.Analytics.PopularContentResponse> {
    return this.request<API.Analytics.PopularContentResponse>('GET', '/analytics/popular-content', undefined, params);
  }

  async getRetention(params?: API.Analytics.RetentionParams): Promise<API.Analytics.RetentionResponse> {
    return this.request<API.Analytics.RetentionResponse>('GET', '/analytics/retention', undefined, params);
  }

  // Notifications Endpoints
  async getNotifications(params?: API.Notifications.NotificationParams): Promise<API.Notifications.NotificationListResponse> {
    return this.request<API.Notifications.NotificationListResponse>('GET', '/notifications', undefined, params);
  }

  async getNotification(id: number): Promise<API.Notifications.NotificationResponse> {
    return this.request<API.Notifications.NotificationResponse>('GET', `/notifications/${id}`);
  }

  async markNotificationAsRead(id: number): Promise<API.Notifications.NotificationReadResponse> {
    return this.request<API.Notifications.NotificationReadResponse>('PUT', `/notifications/${id}/read`);
  }

  async markAllNotificationsAsRead(): Promise<API.Notifications.NotificationReadAllResponse> {
    return this.request<API.Notifications.NotificationReadAllResponse>('PUT', '/notifications/read-all');
  }

  async deleteNotification(id: number): Promise<API.Notifications.NotificationDeleteResponse> {
    return this.request<API.Notifications.NotificationDeleteResponse>('DELETE', `/notifications/${id}`);
  }

  async getNotificationStats(): Promise<API.Notifications.NotificationStatsResponse> {
    return this.request<API.Notifications.NotificationStatsResponse>('GET', '/notifications/stats');
  }

  async getNotificationPreferences(): Promise<API.Notifications.NotificationPreferencesResponse> {
    return this.request<API.Notifications.NotificationPreferencesResponse>('GET', '/notifications/preferences');
  }

  async updateNotificationPreferences(preferences: Partial<API.Notifications.NotificationPreferences>): Promise<API.Notifications.NotificationPreferencesUpdateResponse> {
    return this.request<API.Notifications.NotificationPreferencesUpdateResponse>('PUT', '/notifications/preferences', { preferences });
  }

  async sendTestNotification(request: API.Notifications.TestNotificationRequest): Promise<API.Notifications.TestNotificationResponse> {
    return this.request<API.Notifications.TestNotificationResponse>('POST', '/notifications/test', request);
  }

  async getNotificationTemplates(): Promise<API.Notifications.NotificationTemplatesResponse> {
    return this.request<API.Notifications.NotificationTemplatesResponse>('GET', '/notifications/templates');
  }

  // Cache Management Endpoints
  async getCacheStats(): Promise<API.Cache.CacheStatsResponse> {
    return this.request<API.Cache.CacheStatsResponse>('GET', '/cache/stats');
  }

  async getCacheValue(key: string): Promise<API.Cache.CacheKeyValueResponse> {
    return this.request<API.Cache.CacheKeyValueResponse>('GET', `/cache/keys/${encodeURIComponent(key)}`);
  }

  async setCacheValue(key: string, request: API.Cache.CacheSetRequest): Promise<API.Cache.CacheSetResponse> {
    return this.request<API.Cache.CacheSetResponse>('POST', `/cache/keys/${encodeURIComponent(key)}`, request);
  }

  async deleteCacheKey(key: string): Promise<API.Cache.CacheDeleteResponse> {
    return this.request<API.Cache.CacheDeleteResponse>('DELETE', `/cache/keys/${encodeURIComponent(key)}`);
  }

  async clearCachePattern(pattern: string): Promise<API.Cache.CacheClearPatternResponse> {
    return this.request<API.Cache.CacheClearPatternResponse>('DELETE', '/cache/pattern', { pattern });
  }

  async clearAllCache(): Promise<API.Cache.CacheClearAllResponse> {
    return this.request<API.Cache.CacheClearAllResponse>('DELETE', '/cache/all');
  }

  async getCacheMemory(): Promise<API.Cache.CacheMemoryResponse> {
    return this.request<API.Cache.CacheMemoryResponse>('GET', '/cache/memory');
  }

  async getCachePerformance(): Promise<API.Cache.CachePerformanceResponse> {
    return this.request<API.Cache.CachePerformanceResponse>('GET', '/cache/performance');
  }

  async warmUpCache(patterns?: string[]): Promise<API.Cache.CacheWarmUpResponse> {
    return this.request<API.Cache.CacheWarmUpResponse>('POST', '/cache/warm-up', { patterns });
  }

  async getCacheConfig(): Promise<API.Cache.CacheConfigResponse> {
    return this.request<API.Cache.CacheConfigResponse>('GET', '/cache/config');
  }

  async updateCacheConfig(config: Partial<API.Cache.CacheConfig>): Promise<API.Cache.CacheConfigUpdateResponse> {
    return this.request<API.Cache.CacheConfigUpdateResponse>('PUT', '/cache/config', { config });
  }
}

// Factory function to create client instances
export function createClient(config: API.APIConfig, auth?: API.AuthConfig): API.APIClient {
  return new ZeropointClient(config, auth);
}

// Export the client class for direct instantiation
export { ZeropointClient };

// Export types
export type { 
  APIConfig, 
  AuthConfig, 
  APIResponse, 
  PaginationParams, 
  PaginatedResponse,
  HealthCheck 
} from './graphql-ui-layout-api'; 