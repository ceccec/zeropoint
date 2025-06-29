// GraphQL UI Layout API Client
// TypeScript client library for the unified API
class ZeropointClient {
    constructor(config, auth) {
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
    async request(method, endpoint, data, params) {
        const url = new URL(`${this.config.baseURL}${endpoint}`);
        if (params) {
            Object.entries(params).forEach(([key, value]) => {
                if (value !== undefined && value !== null) {
                    url.searchParams.append(key, String(value));
                }
            });
        }
        const headers = { ...this.config.headers };
        // Add authentication headers
        if (this.auth.token) {
            headers['Authorization'] = `Bearer ${this.auth.token}`;
        }
        else if (this.auth.username && this.auth.password) {
            const credentials = btoa(`${this.auth.username}:${this.auth.password}`);
            headers['Authorization'] = `Basic ${credentials}`;
        }
        const requestOptions = {
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
        }
        catch (error) {
            if (error instanceof Error) {
                throw new Error(`API request failed: ${error.message}`);
            }
            throw new Error('API request failed');
        }
    }
    // Health Check
    async getHealth() {
        return this.request('GET', '/health');
    }
    // GraphQL Endpoints
    async executeQuery(request) {
        return this.request('POST', '/graphql/query', request);
    }
    async getSchema() {
        return this.request('GET', '/graphql/schema');
    }
    async getTypes() {
        return this.request('GET', '/graphql/types');
    }
    async getQueries() {
        return this.request('GET', '/graphql/queries');
    }
    async getMutations() {
        return this.request('GET', '/graphql/mutations');
    }
    async validateQuery(query) {
        return this.request('POST', '/graphql/validate', { query });
    }
    // UI Layout Endpoints
    async getUILayout(page, includeOfflineData) {
        const params = {};
        if (page)
            params.page = page;
        if (includeOfflineData)
            params.include_offline_data = includeOfflineData;
        return this.request('GET', '/ui-layout', undefined, params);
    }
    async getNavigation(page) {
        const params = page ? { page } : undefined;
        return this.request('GET', '/ui-layout/navigation', undefined, params);
    }
    async getSidebar(page) {
        return this.request('GET', '/ui-layout/sidebar', undefined, { page });
    }
    async getContentAreas(page) {
        const params = page ? { page } : undefined;
        return this.request('GET', '/ui-layout/content-areas', undefined, params);
    }
    async getWidgets(page) {
        const params = page ? { page } : undefined;
        return this.request('GET', '/ui-layout/widgets', undefined, params);
    }
    async getActions(page) {
        const params = page ? { page } : undefined;
        return this.request('GET', '/ui-layout/actions', undefined, params);
    }
    async getTheme() {
        return this.request('GET', '/ui-layout/theme');
    }
    async getConfig() {
        return this.request('GET', '/ui-layout/config');
    }
    async getOfflineData() {
        return this.request('GET', '/ui-layout/offline-data');
    }
    async getPermissions() {
        return this.request('GET', '/ui-layout/permissions');
    }
    async getCacheKeys(params) {
        if (params) {
            // Cache Management getCacheKeys
            return this.request('GET', '/cache/keys', undefined, params);
        }
        else {
            // UI Layout getCacheKeys
            return this.request('GET', '/ui-layout/cache-keys');
        }
    }
    async clearCache() {
        return this.request('DELETE', '/ui-layout/cache');
    }
    async updateTheme(theme) {
        return this.request('PUT', '/ui-layout/theme', { theme });
    }
    async updateConfig(config) {
        return this.request('PUT', '/ui-layout/config', { config });
    }
    // Search Endpoints
    async globalSearch(params) {
        return this.request('GET', '/search/global', undefined, params);
    }
    async searchPosts(params) {
        return this.request('GET', '/search/posts', undefined, params);
    }
    async searchUsers(params) {
        return this.request('GET', '/search/users', undefined, params);
    }
    async searchTags(params) {
        return this.request('GET', '/search/tags', undefined, params);
    }
    async getSuggestions(params) {
        return this.request('GET', '/search/suggestions', undefined, params);
    }
    async getSearchStats() {
        return this.request('GET', '/search/stats');
    }
    async reindexSearch(models) {
        return this.request('POST', '/search/reindex', { models });
    }
    // File Management Endpoints
    async uploadFile(request) {
        const formData = new FormData();
        formData.append('file', request.file);
        if (request.category)
            formData.append('category', request.category);
        if (request.tags)
            formData.append('tags', JSON.stringify(request.tags));
        if (request.description)
            formData.append('description', request.description);
        const headers = { ...this.config.headers };
        delete headers['Content-Type']; // Let browser set multipart boundary
        const url = new URL(`${this.config.baseURL}/files/upload`);
        const authHeaders = {};
        if (this.auth.token) {
            authHeaders['Authorization'] = `Bearer ${this.auth.token}`;
        }
        else if (this.auth.username && this.auth.password) {
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
    async getFile(id) {
        return this.request('GET', `/files/${id}`);
    }
    async listFiles(params) {
        return this.request('GET', '/files', undefined, params);
    }
    async updateFile(id, request) {
        return this.request('PUT', `/files/${id}`, request);
    }
    async deleteFile(id) {
        return this.request('DELETE', `/files/${id}`);
    }
    async getFileStats() {
        return this.request('GET', '/files/stats');
    }
    async getFileCategories() {
        return this.request('GET', '/files/categories');
    }
    async getFileTags() {
        return this.request('GET', '/files/tags');
    }
    async bulkUpload(request) {
        const formData = new FormData();
        request.files.forEach((file, index) => {
            formData.append(`files[${index}]`, file);
        });
        if (request.category)
            formData.append('category', request.category);
        if (request.tags)
            formData.append('tags', JSON.stringify(request.tags));
        const headers = { ...this.config.headers };
        delete headers['Content-Type'];
        const url = new URL(`${this.config.baseURL}/files/bulk-upload`);
        const authHeaders = {};
        if (this.auth.token) {
            authHeaders['Authorization'] = `Bearer ${this.auth.token}`;
        }
        else if (this.auth.username && this.auth.password) {
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
    async getFileURL(id, expiresIn) {
        const params = expiresIn ? { expires_in: expiresIn } : undefined;
        return this.request('GET', `/files/${id}/url`, undefined, params);
    }
    // Analytics Endpoints
    async getPageViews(params) {
        return this.request('GET', '/analytics/page-views', undefined, params);
    }
    async getUserActivity(params) {
        return this.request('GET', '/analytics/user-activity', undefined, params);
    }
    async getSearchAnalytics(params) {
        return this.request('GET', '/analytics/search', undefined, params);
    }
    async getFileUploadAnalytics(params) {
        return this.request('GET', '/analytics/file-uploads', undefined, params);
    }
    async getEngagement(params) {
        return this.request('GET', '/analytics/engagement', undefined, params);
    }
    async getDashboard() {
        return this.request('GET', '/analytics/dashboard');
    }
    async trackEvent(request) {
        return this.request('POST', '/analytics/track', request);
    }
    async getPopularContent(params) {
        return this.request('GET', '/analytics/popular-content', undefined, params);
    }
    async getRetention(params) {
        return this.request('GET', '/analytics/retention', undefined, params);
    }
    // Notifications Endpoints
    async getNotifications(params) {
        return this.request('GET', '/notifications', undefined, params);
    }
    async getNotification(id) {
        return this.request('GET', `/notifications/${id}`);
    }
    async markNotificationAsRead(id) {
        return this.request('PUT', `/notifications/${id}/read`);
    }
    async markAllNotificationsAsRead() {
        return this.request('PUT', '/notifications/read-all');
    }
    async deleteNotification(id) {
        return this.request('DELETE', `/notifications/${id}`);
    }
    async getNotificationStats() {
        return this.request('GET', '/notifications/stats');
    }
    async getNotificationPreferences() {
        return this.request('GET', '/notifications/preferences');
    }
    async updateNotificationPreferences(preferences) {
        return this.request('PUT', '/notifications/preferences', { preferences });
    }
    async sendTestNotification(request) {
        return this.request('POST', '/notifications/test', request);
    }
    async getNotificationTemplates() {
        return this.request('GET', '/notifications/templates');
    }
    // Cache Management Endpoints
    async getCacheStats() {
        return this.request('GET', '/cache/stats');
    }
    async getCacheValue(key) {
        return this.request('GET', `/cache/keys/${encodeURIComponent(key)}`);
    }
    async setCacheValue(key, request) {
        return this.request('POST', `/cache/keys/${encodeURIComponent(key)}`, request);
    }
    async deleteCacheKey(key) {
        return this.request('DELETE', `/cache/keys/${encodeURIComponent(key)}`);
    }
    async clearCachePattern(pattern) {
        return this.request('DELETE', '/cache/pattern', { pattern });
    }
    async clearAllCache() {
        return this.request('DELETE', '/cache/all');
    }
    async getCacheMemory() {
        return this.request('GET', '/cache/memory');
    }
    async getCachePerformance() {
        return this.request('GET', '/cache/performance');
    }
    async warmUpCache(patterns) {
        return this.request('POST', '/cache/warm-up', { patterns });
    }
    async getCacheConfig() {
        return this.request('GET', '/cache/config');
    }
    async updateCacheConfig(config) {
        return this.request('PUT', '/cache/config', { config });
    }
}
// Factory function to create client instances
export function createClient(config, auth) {
    return new ZeropointClient(config, auth);
}
// Export the client class for direct instantiation
export { ZeropointClient };
//# sourceMappingURL=graphql-ui-layout-client.js.map