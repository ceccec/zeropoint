// React hook for managing API client
import { useMemo, useState, useCallback } from 'react';
import { createClient } from '../graphql-ui-layout-client';
export function useAPIClient(options) {
    const { config, auth: initialAuth, autoRefresh = false, refreshInterval = 300000 } = options;
    const [auth, setAuth] = useState(initialAuth);
    const [currentConfig, setCurrentConfig] = useState(config);
    // Create memoized client instance
    const client = useMemo(() => {
        return createClient(currentConfig, auth);
    }, [currentConfig, auth]);
    // Check if authenticated
    const isAuthenticated = useMemo(() => {
        return !!(auth?.token || (auth?.username && auth?.password));
    }, [auth]);
    // Login function
    const login = useCallback((newAuth) => {
        setAuth(newAuth);
    }, []);
    // Logout function
    const logout = useCallback(() => {
        setAuth(undefined);
    }, []);
    // Update config function
    const updateConfig = useCallback((newConfig) => {
        setCurrentConfig(prev => ({ ...prev, ...newConfig }));
    }, []);
    // Refresh auth function
    const refreshAuth = useCallback(() => {
        // This would typically refresh the token
        // For now, we'll just re-create the client
        if (auth?.token) {
            // In a real implementation, you'd call a refresh endpoint
            console.log('Refreshing authentication...');
        }
    }, [auth]);
    // Auto-refresh logic
    useMemo(() => {
        if (autoRefresh && isAuthenticated && auth?.token) {
            const interval = setInterval(refreshAuth, refreshInterval);
            return () => clearInterval(interval);
        }
    }, [autoRefresh, isAuthenticated, auth, refreshInterval, refreshAuth]);
    return {
        client,
        isAuthenticated,
        login,
        logout,
        updateConfig,
        refreshAuth,
    };
}
export function useAPIState(fetchFn, dependencies = []) {
    const [data, setData] = useState(null);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    const fetchData = useCallback(async () => {
        try {
            setLoading(true);
            setError(null);
            const result = await fetchFn();
            setData(result);
        }
        catch (err) {
            setError(err instanceof Error ? err.message : 'An error occurred');
        }
        finally {
            setLoading(false);
        }
    }, [fetchFn]);
    // Initial fetch
    useMemo(() => {
        fetchData();
    }, dependencies);
    return {
        data,
        loading,
        error,
        refetch: fetchData,
    };
}
export function usePaginatedAPIState(fetchFn, initialPage = 1, initialPerPage = 20) {
    const [page, setPage] = useState(initialPage);
    const [perPage, setPerPage] = useState(initialPerPage);
    const [data, setData] = useState([]);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    const [totalCount, setTotalCount] = useState(0);
    const [totalPages, setTotalPages] = useState(0);
    const fetchData = useCallback(async () => {
        try {
            setLoading(true);
            setError(null);
            const result = await fetchFn(page, perPage);
            setData(result.data);
            setTotalCount(result.total_count);
            setTotalPages(result.total_pages);
        }
        catch (err) {
            setError(err instanceof Error ? err.message : 'An error occurred');
        }
        finally {
            setLoading(false);
        }
    }, [fetchFn, page, perPage]);
    // Initial fetch
    useMemo(() => {
        fetchData();
    }, [fetchData]);
    const nextPage = useCallback(() => {
        if (page < totalPages) {
            setPage(page + 1);
        }
    }, [page, totalPages]);
    const previousPage = useCallback(() => {
        if (page > 1) {
            setPage(page - 1);
        }
    }, [page]);
    const goToPage = useCallback((newPage) => {
        if (newPage >= 1 && newPage <= totalPages) {
            setPage(newPage);
        }
    }, [totalPages]);
    const setPerPageAndReset = useCallback((newPerPage) => {
        setPerPage(newPerPage);
        setPage(1); // Reset to first page when changing per page
    }, []);
    return {
        data,
        loading,
        error,
        refetch: fetchData,
        page,
        perPage,
        totalCount,
        totalPages,
        hasNextPage: page < totalPages,
        hasPreviousPage: page > 1,
        nextPage,
        previousPage,
        goToPage,
        setPerPage: setPerPageAndReset,
    };
}
export function useApiClient() {
    const client = {
        baseURL: '/zeropoint',
        timeout: 30000,
        headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
        },
        async get(url, config = {}) {
            return this.request('GET', url, undefined, config);
        },
        async post(url, data, config = {}) {
            return this.request('POST', url, data, config);
        },
        async put(url, data, config = {}) {
            return this.request('PUT', url, data, config);
        },
        async delete(url, config = {}) {
            return this.request('DELETE', url, undefined, config);
        },
        async request(method, url, data, config = {}) {
            const fullUrl = url.startsWith('http') ? url : `${this.baseURL}${url}`;
            const fetchConfig = {
                method,
                headers: { ...this.headers, ...(config.headers || {}) },
                body: data ? JSON.stringify(data) : null,
                signal: config.timeout ? AbortSignal.timeout(config.timeout) : undefined
            };
            const response = await fetch(fullUrl, fetchConfig);
            const responseData = await response.json();
            return {
                data: responseData.data,
                status: response.status,
                statusText: response.statusText,
                headers: Object.fromEntries(response.headers.entries()),
                config,
                extensions: responseData.extensions || {
                    consciousness: { enabled: false, golden_ratio: false, level: 0, handled_errors: 0 },
                    vortex: { enabled: false, streaming: false, state: 'flowing', transformation_applied: false },
                    uroboros: { request_uuid: '', pattern_encoded: false, vortex_transformed: false, self_evolving: false, observer_influence: null, cosmic_flow: false },
                    performance: { cache_efficiency: 0, index_efficiency: 0, entropy: 0 }
                }
            };
        }
    };
    const callService = async (request) => {
        return client.post('', request);
    };
    return {
        client,
        callService,
        get: client.get.bind(client),
        post: client.post.bind(client)
    };
}
//# sourceMappingURL=use-api-client.js.map