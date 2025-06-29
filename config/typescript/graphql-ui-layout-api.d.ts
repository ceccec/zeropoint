// GraphQL UI Layout API TypeScript Definitions
// Comprehensive type definitions for the unified API

declare namespace ZeropointAPI {
  // Base API Configuration
  interface APIConfig {
    baseURL: string;
    token?: string;
    timeout?: number;
    headers?: Record<string, string>;
  }

  // Authentication
  interface AuthConfig {
    token?: string;
    username?: string;
    password?: string;
  }

  // Common Response Structure
  interface APIResponse<T = any> {
    data?: T;
    error?: string;
    message?: string;
    timestamp: string;
    version?: string;
  }

  // Pagination
  interface PaginationParams {
    page?: number;
    per_page?: number;
  }

  interface PaginatedResponse<T> extends APIResponse<T[]> {
    total_count: number;
    total_pages: number;
    page: number;
    per_page: number;
  }

  // Health Check
  interface HealthCheck {
    status: 'healthy' | 'unhealthy';
    version: string;
    timestamp: string;
    services: {
      database: boolean;
      redis: boolean;
      elasticsearch: boolean;
      sidekiq: boolean;
    };
  }

  // GraphQL Types
  namespace GraphQL {
    interface QueryRequest {
      query: string;
      variables?: Record<string, any>;
      operation_name?: string;
    }

    interface QueryResponse {
      data?: any;
      errors?: Array<{
        message: string;
        locations?: Array<{ line: number; column: number }>;
        path?: string[];
      }>;
      extensions?: any;
    }

    interface SchemaResponse {
      schema: any;
    }

    interface TypesResponse {
      types: string[];
    }

    interface QueriesResponse {
      queries: string[];
    }

    interface MutationsResponse {
      mutations: string[];
    }

    interface ValidationResponse {
      valid: boolean;
      errors: string[];
    }
  }

  // UI Layout Types
  namespace UILayout {
    interface User {
      id: number;
      email: string;
      profile_name?: string;
    }

    interface Permission {
      can_view: boolean;
      can_edit: boolean;
      can_delete: boolean;
      can_manage: boolean;
      can_create: boolean;
      can_export: boolean;
      can_import: boolean;
    }

    interface Role {
      id: number;
      name: string;
      permissions: string[];
    }

    interface NavigationItem {
      label: string;
      url: string;
      icon?: string;
      always?: boolean;
      order: number;
    }

    interface Navigation {
      items: NavigationItem[];
      type: string;
      responsive: boolean;
      collapsible: boolean;
    }

    interface SidebarItem {
      label: string;
      url: string;
      icon?: string;
      order: number;
    }

    interface Sidebar {
      items: SidebarItem[];
      type: string;
      collapsible: boolean;
      default_collapsed: boolean;
    }

    interface Breadcrumb {
      label: string;
      url: string;
      current: boolean;
    }

    interface ContentArea {
      id: string;
      type: string;
      title: string;
      permission: string;
      component: string;
      props: Record<string, any>;
    }

    interface Widget {
      id: string;
      title: string;
      icon?: string;
      type: string;
      endpoint?: string;
      params?: Record<string, any>;
      refresh_interval?: number;
    }

    interface Action {
      id: string;
      label: string;
      icon?: string;
      url: string;
      type: string;
      method: string;
    }

    interface Theme {
      primary_color: string;
      secondary_color: string;
      accent_color: string;
      success_color: string;
      warning_color: string;
      danger_color: string;
      info_color: string;
      light_color: string;
      dark_color: string;
      font_family: string;
      border_radius: string;
      box_shadow: string;
      transition: string;
    }

    interface AppConfig {
      app_name: string;
      app_version: string;
      api_version: string;
      default_locale: string;
      supported_locales: string[];
      timezone: string;
      date_format: string;
      time_format: string;
      pagination: {
        default_per_page: number;
        max_per_page: number;
        page_param: string;
        per_page_param: string;
      };
      search: {
        default_search_type: string;
        search_types: string[];
        min_query_length: number;
        max_suggestions: number;
      };
      cache: {
        default_ttl: number;
        max_ttl: number;
        cache_prefix: string;
      };
      offline: {
        enabled: boolean;
        max_cache_size: string;
        sync_interval: number;
        background_sync: boolean;
      };
    }

    interface OfflineData {
      essential_data: any;
      user_data: any;
      content_data: any;
      navigation_data: any;
      cache_strategy: string;
      sync_required: boolean;
      last_sync: string;
    }

    interface LayoutData {
      user?: User;
      permissions: Permission;
      roles: Role[];
      navigation: Navigation;
      sidebar: Sidebar;
      breadcrumbs: Breadcrumb[];
      content_areas: ContentArea[];
      widgets: Widget[];
      actions: Action[];
      theme: Theme;
      config: AppConfig;
      offline_data?: OfflineData;
      cache_keys: string[];
      last_updated: string;
      version: string;
    }

    interface LayoutResponse extends APIResponse<LayoutData> {
      layout: LayoutData;
    }

    interface NavigationResponse extends APIResponse<Navigation> {
      navigation: Navigation;
    }

    interface SidebarResponse extends APIResponse<Sidebar> {
      sidebar: Sidebar;
    }

    interface ContentAreasResponse extends APIResponse<ContentArea[]> {
      content_areas: ContentArea[];
    }

    interface WidgetsResponse extends APIResponse<Widget[]> {
      widgets: Widget[];
    }

    interface ActionsResponse extends APIResponse<Action[]> {
      actions: Action[];
    }

    interface ThemeResponse extends APIResponse<Theme> {
      theme: Theme;
    }

    interface ConfigResponse extends APIResponse<AppConfig> {
      config: AppConfig;
    }

    interface OfflineDataResponse extends APIResponse<OfflineData> {
      offline_data: OfflineData;
    }

    interface PermissionsResponse extends APIResponse<Permission> {
      permissions: Permission;
    }

    interface CacheKeysResponse extends APIResponse<string[]> {
      cache_keys: string[];
    }

    interface CacheClearResponse extends APIResponse<{
      message: string;
      cleared_keys: string[];
    }> {
      message: string;
      cleared_keys: string[];
    }

    interface ThemeUpdateRequest {
      theme: Partial<Theme>;
    }

    interface ConfigUpdateRequest {
      config: Partial<AppConfig>;
    }
  }

  // Search Types
  namespace Search {
    interface SearchParams extends PaginationParams {
      query: string;
      models?: string[];
      search_type?: 'full_text' | 'fuzzy' | 'exact' | 'auto';
    }

    interface SearchResult {
      id: number;
      type: string;
      title: string;
      content?: string;
      url?: string;
      created_at: string;
      updated_at: string;
      [key: string]: any;
    }

    interface GlobalSearchResponse extends PaginatedResponse<SearchResult> {
      query: string;
      search_type: string;
    }

    interface PostSearchParams extends SearchParams {
      tags?: string[];
      author_id?: number;
      published?: boolean;
    }

    interface PostSearchResponse extends PaginatedResponse<SearchResult> {
      query: string;
      filters: {
        tags?: string[];
        author_id?: number;
        published?: boolean;
      };
    }

    interface UserSearchParams extends SearchParams {
      roles?: string[];
      skills?: string[];
    }

    interface UserSearchResponse extends PaginatedResponse<SearchResult> {
      query: string;
      filters: {
        roles?: string[];
        skills?: string[];
      };
    }

    interface TagSearchParams extends SearchParams {
      context?: string;
    }

    interface TagSearchResponse extends PaginatedResponse<SearchResult> {
      query: string;
      context?: string;
    }

    interface SuggestionsParams {
      query: string;
      models?: string[];
      limit?: number;
    }

    interface SuggestionsResponse extends APIResponse<string[]> {
      query: string;
      suggestions: string[];
    }

    interface SearchStats {
      total_posts: number;
      total_users: number;
      total_tags: number;
      searchable_models: string[];
      search_types: string[];
    }

    interface SearchStatsResponse extends APIResponse<SearchStats> {
      statistics: SearchStats;
    }

    interface ReindexRequest {
      models?: string[];
    }

    interface ReindexResponse extends APIResponse<{
      message: string;
      models: string[] | 'all';
    }> {
      message: string;
      models: string[] | 'all';
    }
  }

  // File Management Types
  namespace Files {
    interface FileUpload {
      id: number;
      user_id: number;
      category: string;
      description?: string;
      file_name: string;
      file_size: number;
      file_type: string;
      file_url: string;
      tags: string[];
      created_at: string;
      updated_at: string;
    }

    interface FileUploadRequest {
      file: File;
      category?: string;
      tags?: string[];
      description?: string;
    }

    interface FileUploadResponse extends APIResponse<FileUpload> {
      file: FileUpload;
      message: string;
    }

    interface FileResponse extends APIResponse<FileUpload> {
      file: FileUpload;
    }

    interface FileListParams extends PaginationParams {
      category?: string;
      tags?: string[];
    }

    interface FileListResponse extends PaginatedResponse<FileUpload> {
      files: FileUpload[];
      filters: {
        category?: string;
        tags?: string[];
      };
    }

    interface FileUpdateRequest {
      category?: string;
      tags?: string[];
      description?: string;
    }

    interface FileUpdateResponse extends APIResponse<FileUpload> {
      file: FileUpload;
      message: string;
    }

    interface FileDeleteResponse extends APIResponse<{
      deleted: boolean;
      message: string;
    }> {
      deleted: boolean;
      message: string;
    }

    interface FileStats {
      total_files: number;
      total_size: number;
      categories: Record<string, number>;
      recent_uploads: number;
      storage_used: number;
    }

    interface FileStatsResponse extends APIResponse<FileStats> {
      statistics: FileStats;
    }

    interface FileCategoriesResponse extends APIResponse<string[]> {
      categories: string[];
    }

    interface FileTagsResponse extends APIResponse<string[]> {
      tags: string[];
    }

    interface BulkUploadRequest {
      files: File[];
      category?: string;
      tags?: string[];
    }

    interface BulkUploadResult {
      uploaded_files: FileUpload[];
      errors: Array<{
        index: number;
        error: string;
      }>;
      total_uploaded: number;
      total_errors: number;
    }

    interface BulkUploadResponse extends APIResponse<BulkUploadResult> {
      uploaded_files: FileUpload[];
      errors: Array<{
        index: number;
        error: string;
      }>;
      total_uploaded: number;
      total_errors: number;
    }

    interface FileURLParams {
      expires_in?: number;
    }

    interface FileURLResponse extends APIResponse<{
      url: string;
      expires_at: string;
    }> {
      url: string;
      expires_at: string;
    }
  }

  // Analytics Types
  namespace Analytics {
    interface DateRange {
      start_date?: string;
      end_date?: string;
    }

    interface PageViewsParams extends DateRange {
      page?: string;
      user_id?: number;
    }

    interface PageViewsResponse extends APIResponse<Record<string, number>> {
      page_views: Record<string, number>;
      filters: {
        start_date?: string;
        end_date?: string;
        page?: string;
        user_id?: number;
      };
    }

    interface UserActivityParams extends DateRange {
      user_id?: number;
      action?: string;
    }

    interface UserActivityEvent {
      id: number;
      name: string;
      time: string;
      user_id?: number;
      properties: Record<string, any>;
    }

    interface UserActivityResponse extends APIResponse<UserActivityEvent[]> {
      activity: UserActivityEvent[];
      filters: {
        start_date?: string;
        end_date?: string;
        user_id?: number;
        action?: string;
      };
    }

    interface SearchAnalyticsParams extends DateRange {
      query?: string;
    }

    interface SearchAnalytics {
      total_searches: number;
      unique_searches: number;
      popular_queries: Record<string, number>;
      searches_by_day: Record<string, number>;
    }

    interface SearchAnalyticsResponse extends APIResponse<SearchAnalytics> {
      search_data: SearchAnalytics;
      filters: {
        start_date?: string;
        end_date?: string;
        query?: string;
      };
    }

    interface FileUploadAnalyticsParams extends DateRange {
      category?: string;
    }

    interface FileUploadAnalytics {
      total_uploads: number;
      total_size: number;
      uploads_by_category: Record<string, number>;
      uploads_by_day: Record<string, number>;
      average_file_size: number;
    }

    interface FileUploadAnalyticsResponse extends APIResponse<FileUploadAnalytics> {
      upload_data: FileUploadAnalytics;
      filters: {
        start_date?: string;
        end_date?: string;
        category?: string;
      };
    }

    interface EngagementParams extends DateRange {
      metric?: string;
    }

    interface EngagementMetrics {
      daily_active_users: number;
      session_duration: number;
      bounce_rate: number;
      pages_per_session: number;
      user_retention: number;
    }

    interface EngagementResponse extends APIResponse<EngagementMetrics> {
      engagement: EngagementMetrics;
      filters: {
        start_date?: string;
        end_date?: string;
        metric?: string;
      };
    }

    interface DashboardStats {
      total_users: number;
      total_posts: number;
      total_files: number;
      total_searches: number;
      recent_activity: UserActivityEvent[];
      system_health: {
        database: boolean;
        redis: boolean;
        sidekiq: boolean;
        uptime: number;
      };
    }

    interface DashboardResponse extends APIResponse<DashboardStats> {
      statistics: DashboardStats;
    }

    interface TrackEventRequest {
      event_name: string;
      properties?: Record<string, any>;
      user_id?: number;
    }

    interface TrackEventResponse extends APIResponse<{
      message: string;
      event_name: string;
    }> {
      message: string;
      event_name: string;
    }

    interface PopularContentParams {
      limit?: number;
      period?: '1d' | '7d' | '30d' | '1y';
    }

    interface PopularContentItem {
      page: string;
      views: number;
      title: string;
    }

    interface PopularContentResponse extends APIResponse<PopularContentItem[]> {
      popular_content: PopularContentItem[];
      period: string;
      limit: number;
    }

    interface RetentionParams {
      cohort_size?: number;
      periods?: number;
    }

    interface RetentionCohort {
      cohort: string;
      users: number;
      retention: number[];
    }

    interface RetentionResponse extends APIResponse<RetentionCohort[]> {
      retention: RetentionCohort[];
      cohort_size: number;
      periods: number;
    }
  }

  // Notifications Types
  namespace Notifications {
    interface Notification {
      id: number;
      user_id: number;
      notification_type: string;
      title: string;
      message: string;
      read: boolean;
      read_at?: string;
      created_at: string;
      updated_at: string;
    }

    interface NotificationParams extends PaginationParams {
      read?: boolean;
      type?: string;
    }

    interface NotificationListResponse extends PaginatedResponse<Notification> {
      notifications: Notification[];
      unread_count: number;
      filters: {
        read?: boolean;
        type?: string;
      };
    }

    interface NotificationResponse extends APIResponse<Notification> {
      notification: Notification;
    }

    interface NotificationReadResponse extends APIResponse<Notification> {
      notification: Notification;
      message: string;
    }

    interface NotificationReadAllResponse extends APIResponse<{
      message: string;
    }> {
      message: string;
    }

    interface NotificationDeleteResponse extends APIResponse<{
      message: string;
    }> {
      message: string;
    }

    interface NotificationStats {
      total_notifications: number;
      unread_notifications: number;
      notifications_by_type: Record<string, number>;
      notifications_by_day: Record<string, number>;
      recent_notifications: number;
    }

    interface NotificationStatsResponse extends APIResponse<NotificationStats> {
      statistics: NotificationStats;
    }

    interface NotificationPreferences {
      email: boolean;
      push: boolean;
      in_app: boolean;
      types: {
        system: boolean;
        posts: boolean;
        comments: boolean;
        mentions: boolean;
        follows: boolean;
      };
    }

    interface NotificationPreferencesResponse extends APIResponse<NotificationPreferences> {
      preferences: NotificationPreferences;
    }

    interface NotificationPreferencesUpdateRequest {
      preferences: Partial<NotificationPreferences>;
    }

    interface NotificationPreferencesUpdateResponse extends APIResponse<NotificationPreferences> {
      preferences: NotificationPreferences;
      message: string;
    }

    interface TestNotificationRequest {
      type: string;
      message?: string;
    }

    interface TestNotificationResponse extends APIResponse<{
      message: string;
      type: string;
    }> {
      message: string;
      type: string;
    }

    interface NotificationTemplate {
      type: string;
      title: string;
      description: string;
      template: {
        title: string;
        message: string;
      };
    }

    interface NotificationTemplatesResponse extends APIResponse<NotificationTemplate[]> {
      templates: NotificationTemplate[];
    }
  }

  // Cache Management Types
  namespace Cache {
    interface CacheStats {
      total_keys: number;
      memory_usage: string;
      connected_clients: number;
      total_commands_processed: number;
      keyspace_hits: number;
      keyspace_misses: number;
      hit_rate: number;
      cache_size_by_type: Record<string, number>;
      recent_activity: Array<{
        id: number;
        timestamp: string;
        duration: number;
        command: string;
      }>;
    }

    interface CacheStatsResponse extends APIResponse<CacheStats> {
      statistics: CacheStats;
    }

    interface CacheKey {
      key: string;
      ttl: number;
      size: number;
      type: string;
    }

    interface CacheKeysParams {
      pattern?: string;
      limit?: number;
    }

    interface CacheKeysResponse extends APIResponse<CacheKey[]> {
      keys: CacheKey[];
      pattern?: string;
      limit: number;
    }

    interface CacheKeyValueResponse extends APIResponse<{
      key: string;
      value: any;
      exists: boolean;
    }> {
      key: string;
      value: any;
      exists: boolean;
    }

    interface CacheSetRequest {
      value: string;
      ttl?: number;
    }

    interface CacheSetResponse extends APIResponse<{
      key: string;
      message: string;
      ttl?: number;
    }> {
      key: string;
      message: string;
      ttl?: number;
    }

    interface CacheDeleteResponse extends APIResponse<{
      key: string;
      deleted: boolean;
      message: string;
    }> {
      key: string;
      deleted: boolean;
      message: string;
    }

    interface CacheClearPatternRequest {
      pattern: string;
    }

    interface CacheClearPatternResponse extends APIResponse<{
      pattern: string;
      cleared_count: number;
      message: string;
    }> {
      pattern: string;
      cleared_count: number;
      message: string;
    }

    interface CacheClearAllResponse extends APIResponse<{
      cleared_count: number;
      message: string;
    }> {
      cleared_count: number;
      message: string;
    }

    interface CacheMemory {
      used_memory: string;
      used_memory_peak: string;
      used_memory_rss: string;
      mem_fragmentation_ratio: string;
      total_system_memory: string;
      memory_usage_percentage: number;
    }

    interface CacheMemoryResponse extends APIResponse<CacheMemory> {
      memory: CacheMemory;
    }

    interface CachePerformance {
      ops_per_sec: number;
      total_connections_received: number;
      total_commands_processed: number;
      keyspace_hits: number;
      keyspace_misses: number;
      hit_rate: number;
      average_response_time: number;
      slow_log_entries: Array<{
        id: number;
        timestamp: string;
        duration: number;
        command: string;
      }>;
    }

    interface CachePerformanceResponse extends APIResponse<CachePerformance> {
      performance: CachePerformance;
    }

    interface CacheWarmUpRequest {
      patterns?: string[];
    }

    interface CacheWarmUpResponse extends APIResponse<{
      warmed_count: number;
      patterns?: string[];
      message: string;
    }> {
      warmed_count: number;
      patterns?: string[];
      message: string;
    }

    interface CacheConfig {
      store: string;
      default_ttl?: number;
      max_ttl?: number;
      cache_prefix?: string;
      compression?: boolean;
      compression_threshold?: number;
      redis_config?: Record<string, any>;
    }

    interface CacheConfigResponse extends APIResponse<CacheConfig> {
      configuration: CacheConfig;
    }

    interface CacheConfigUpdateRequest {
      config: Partial<CacheConfig>;
    }

    interface CacheConfigUpdateResponse extends APIResponse<CacheConfig> {
      configuration: CacheConfig;
      message: string;
    }
  }

  // API Client Interface
  interface APIClient {
    // Health Check
    getHealth(): Promise<HealthCheck>;

    // GraphQL
    executeQuery(request: GraphQL.QueryRequest): Promise<GraphQL.QueryResponse>;
    getSchema(): Promise<GraphQL.SchemaResponse>;
    getTypes(): Promise<GraphQL.TypesResponse>;
    getQueries(): Promise<GraphQL.QueriesResponse>;
    getMutations(): Promise<GraphQL.MutationsResponse>;
    validateQuery(query: string): Promise<GraphQL.ValidationResponse>;

    // UI Layout
    getUILayout(page?: string, includeOfflineData?: boolean): Promise<UILayout.LayoutResponse>;
    getNavigation(page?: string): Promise<UILayout.NavigationResponse>;
    getSidebar(page: string): Promise<UILayout.SidebarResponse>;
    getContentAreas(page?: string): Promise<UILayout.ContentAreasResponse>;
    getWidgets(page?: string): Promise<UILayout.WidgetsResponse>;
    getActions(page?: string): Promise<UILayout.ActionsResponse>;
    getTheme(): Promise<UILayout.ThemeResponse>;
    getConfig(): Promise<UILayout.ConfigResponse>;
    getOfflineData(): Promise<UILayout.OfflineDataResponse>;
    getPermissions(): Promise<UILayout.PermissionsResponse>;
    getCacheKeys(): Promise<UILayout.CacheKeysResponse>;
    clearCache(): Promise<UILayout.CacheClearResponse>;
    updateTheme(theme: Partial<UILayout.Theme>): Promise<UILayout.ThemeResponse>;
    updateConfig(config: Partial<UILayout.AppConfig>): Promise<UILayout.ConfigResponse>;

    // Search
    globalSearch(params: Search.SearchParams): Promise<Search.GlobalSearchResponse>;
    searchPosts(params: Search.PostSearchParams): Promise<Search.PostSearchResponse>;
    searchUsers(params: Search.UserSearchParams): Promise<Search.UserSearchResponse>;
    searchTags(params: Search.TagSearchParams): Promise<Search.TagSearchResponse>;
    getSuggestions(params: Search.SuggestionsParams): Promise<Search.SuggestionsResponse>;
    getSearchStats(): Promise<Search.SearchStatsResponse>;
    reindexSearch(models?: string[]): Promise<Search.ReindexResponse>;

    // Files
    uploadFile(request: Files.FileUploadRequest): Promise<Files.FileUploadResponse>;
    getFile(id: number): Promise<Files.FileResponse>;
    listFiles(params?: Files.FileListParams): Promise<Files.FileListResponse>;
    updateFile(id: number, request: Files.FileUpdateRequest): Promise<Files.FileUpdateResponse>;
    deleteFile(id: number): Promise<Files.FileDeleteResponse>;
    getFileStats(): Promise<Files.FileStatsResponse>;
    getFileCategories(): Promise<Files.FileCategoriesResponse>;
    getFileTags(): Promise<Files.FileTagsResponse>;
    bulkUpload(request: Files.BulkUploadRequest): Promise<Files.BulkUploadResponse>;
    getFileURL(id: number, expiresIn?: number): Promise<Files.FileURLResponse>;

    // Analytics
    getPageViews(params?: Analytics.PageViewsParams): Promise<Analytics.PageViewsResponse>;
    getUserActivity(params?: Analytics.UserActivityParams): Promise<Analytics.UserActivityResponse>;
    getSearchAnalytics(params?: Analytics.SearchAnalyticsParams): Promise<Analytics.SearchAnalyticsResponse>;
    getFileUploadAnalytics(params?: Analytics.FileUploadAnalyticsParams): Promise<Analytics.FileUploadAnalyticsResponse>;
    getEngagement(params?: Analytics.EngagementParams): Promise<Analytics.EngagementResponse>;
    getDashboard(): Promise<Analytics.DashboardResponse>;
    trackEvent(request: Analytics.TrackEventRequest): Promise<Analytics.TrackEventResponse>;
    getPopularContent(params?: Analytics.PopularContentParams): Promise<Analytics.PopularContentResponse>;
    getRetention(params?: Analytics.RetentionParams): Promise<Analytics.RetentionResponse>;

    // Notifications
    getNotifications(params?: Notifications.NotificationParams): Promise<Notifications.NotificationListResponse>;
    getNotification(id: number): Promise<Notifications.NotificationResponse>;
    markNotificationAsRead(id: number): Promise<Notifications.NotificationReadResponse>;
    markAllNotificationsAsRead(): Promise<Notifications.NotificationReadAllResponse>;
    deleteNotification(id: number): Promise<Notifications.NotificationDeleteResponse>;
    getNotificationStats(): Promise<Notifications.NotificationStatsResponse>;
    getNotificationPreferences(): Promise<Notifications.NotificationPreferencesResponse>;
    updateNotificationPreferences(preferences: Partial<Notifications.NotificationPreferences>): Promise<Notifications.NotificationPreferencesUpdateResponse>;
    sendTestNotification(request: Notifications.TestNotificationRequest): Promise<Notifications.TestNotificationResponse>;
    getNotificationTemplates(): Promise<Notifications.NotificationTemplatesResponse>;

    // Cache
    getCacheStats(): Promise<Cache.CacheStatsResponse>;
    getCacheKeys(params?: Cache.CacheKeysParams): Promise<Cache.CacheKeysResponse>;
    getCacheValue(key: string): Promise<Cache.CacheKeyValueResponse>;
    setCacheValue(key: string, request: Cache.CacheSetRequest): Promise<Cache.CacheSetResponse>;
    deleteCacheKey(key: string): Promise<Cache.CacheDeleteResponse>;
    clearCachePattern(pattern: string): Promise<Cache.CacheClearPatternResponse>;
    clearAllCache(): Promise<Cache.CacheClearAllResponse>;
    getCacheMemory(): Promise<Cache.CacheMemoryResponse>;
    getCachePerformance(): Promise<Cache.CachePerformanceResponse>;
    warmUpCache(patterns?: string[]): Promise<Cache.CacheWarmUpResponse>;
    getCacheConfig(): Promise<Cache.CacheConfigResponse>;
    updateCacheConfig(config: Partial<Cache.CacheConfig>): Promise<Cache.CacheConfigUpdateResponse>;
  }
}

// Export types for use in other modules
export = ZeropointAPI;
export as namespace ZeropointAPI; 