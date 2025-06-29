export interface ApiClient {
    baseURL: string;
    timeout: number;
    headers: Record<string, string>;
    get<T>(url: string, config?: RequestConfig): Promise<ApiResponse<T>>;
    post<T>(url: string, data?: any, config?: RequestConfig): Promise<ApiResponse<T>>;
    put<T>(url: string, data?: any, config?: RequestConfig): Promise<ApiResponse<T>>;
    delete<T>(url: string, config?: RequestConfig): Promise<ApiResponse<T>>;
}
export interface RequestConfig {
    headers?: Record<string, string>;
    timeout?: number;
    params?: Record<string, any>;
}
export interface ApiResponse<T = any> {
    data: T;
    status: number;
    statusText: string;
    headers: Record<string, string>;
    config: RequestConfig;
}
export interface ZeropointApiResponse<T = any> extends ApiResponse<T> {
    extensions: {
        consciousness: {
            enabled: boolean;
            golden_ratio: boolean;
            level: number;
            handled_errors: number;
        };
        vortex: {
            enabled: boolean;
            streaming: boolean;
            state: string;
            transformation_applied: boolean;
        };
        uroboros: {
            request_uuid: string;
            pattern_encoded: boolean;
            vortex_transformed: boolean;
            self_evolving: boolean;
            observer_influence: any;
            cosmic_flow: boolean;
        };
        performance: {
            cache_efficiency: number;
            index_efficiency: number;
            entropy: number;
        };
    };
}
export interface ZeropointServiceRequest {
    service: string;
    data: any;
    timestamp?: number;
}
export interface ZeropointServiceResponse<T = any> {
    data: T;
    error?: string;
}
//# sourceMappingURL=api-client.d.ts.map