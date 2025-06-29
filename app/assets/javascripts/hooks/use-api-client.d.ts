import type { APIConfig, AuthConfig, APIClient } from '../graphql-ui-layout-api';
import type { ApiClient, ZeropointApiResponse, ZeropointServiceRequest } from '../types/api-client';
interface UseAPIClientOptions {
    config: APIConfig;
    auth?: AuthConfig;
    autoRefresh?: boolean;
    refreshInterval?: number;
}
interface UseAPIClientReturn {
    client: APIClient;
    isAuthenticated: boolean;
    login: (auth: AuthConfig) => void;
    logout: () => void;
    updateConfig: (config: Partial<APIConfig>) => void;
    refreshAuth: () => void;
}
export declare function useAPIClient(options: UseAPIClientOptions): UseAPIClientReturn;
interface UseAPIState<T> {
    data: T | null;
    loading: boolean;
    error: string | null;
    refetch: () => Promise<void>;
}
export declare function useAPIState<T>(fetchFn: () => Promise<T>, dependencies?: any[]): UseAPIState<T>;
interface UsePaginatedAPIState<T> extends UseAPIState<T[]> {
    page: number;
    perPage: number;
    totalCount: number;
    totalPages: number;
    hasNextPage: boolean;
    hasPreviousPage: boolean;
    nextPage: () => void;
    previousPage: () => void;
    goToPage: (page: number) => void;
    setPerPage: (perPage: number) => void;
}
export declare function usePaginatedAPIState<T>(fetchFn: (page: number, perPage: number) => Promise<{
    data: T[];
    total_count: number;
    total_pages: number;
    page: number;
    per_page: number;
}>, initialPage?: number, initialPerPage?: number): UsePaginatedAPIState<T>;
export declare function useApiClient(): {
    client: ApiClient;
    callService: <T>(request: ZeropointServiceRequest) => Promise<ZeropointApiResponse<T>>;
    get: <T>(url: string) => Promise<ZeropointApiResponse<T>>;
    post: <T>(url: string, data: any) => Promise<ZeropointApiResponse<T>>;
};
export {};
//# sourceMappingURL=use-api-client.d.ts.map