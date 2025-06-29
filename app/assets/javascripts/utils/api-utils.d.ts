import type { APIConfig, AuthConfig, APIResponse, PaginationParams } from '../graphql-ui-layout-api';
import type { ZeropointApiResponse, ZeropointServiceRequest } from '../types/api-client';
export declare class APIError extends Error {
    status: number;
    code?: string;
    details?: any;
    constructor(message: string, status?: number, code?: string, details?: any);
    static fromResponse(response: Response, data?: any): APIError;
    static fromNetworkError(error: Error): APIError;
}
export declare function buildURL(baseURL: string, endpoint: string, params?: Record<string, any>): string;
export declare function buildHeaders(config: APIConfig, auth?: AuthConfig): Record<string, string>;
export declare function isAPIResponse<T>(data: any): data is APIResponse<T>;
export declare function extractData<T>(response: APIResponse<T>): T;
export declare function hasError(response: APIResponse): boolean;
export declare function getErrorMessage(response: APIResponse): string;
export declare function buildPaginationParams(params: PaginationParams): Record<string, string>;
export declare function calculatePaginationInfo(page: number, perPage: number, totalCount: number): {
    totalPages: number;
    hasNextPage: boolean;
    hasPreviousPage: boolean;
    startIndex: number;
    endIndex: number;
};
export declare class APICache {
    private cache;
    set(key: string, data: any, ttl?: number): void;
    get(key: string): any | null;
    has(key: string): boolean;
    delete(key: string): boolean;
    clear(): void;
    keys(): string[];
    size(): number;
}
export interface RetryOptions {
    maxAttempts: number;
    delay: number;
    backoff: number;
    shouldRetry?: (error: APIError) => boolean;
}
export declare function withRetry<T>(fn: () => Promise<T>, options?: RetryOptions): Promise<T>;
export declare function debounce<T extends (...args: any[]) => any>(func: T, wait: number): (...args: Parameters<T>) => void;
export declare function throttle<T extends (...args: any[]) => any>(func: T, limit: number): (...args: Parameters<T>) => void;
export declare function transformKeys(obj: any, transformer: (key: string) => string): any;
export declare function camelCase(str: string): string;
export declare function snakeCase(str: string): string;
export declare function toCamelCase(obj: any): any;
export declare function toSnakeCase(obj: any): any;
export declare function validateEmail(email: string): boolean;
export declare function validateURL(url: string): boolean;
export declare function validateRequired(value: any): boolean;
export declare function validateLength(value: string, min: number, max?: number): boolean;
export declare function formatDate(date: Date | string, format?: string): string;
export declare function parseDate(dateString: string): Date;
export declare function isDateValid(date: any): boolean;
export declare function formatFileSize(bytes: number): string;
export declare function getFileExtension(filename: string): string;
export declare function isImageFile(filename: string): boolean;
export declare function isVideoFile(filename: string): boolean;
export declare function isAudioFile(filename: string): boolean;
export declare function highlightText(text: string, query: string): string;
export declare function searchInText(text: string, query: string): boolean;
export declare function searchInArray<T>(array: T[], query: string, fields: (keyof T)[]): T[];
export declare const apiUtils: {
    generateRequestId(): string;
    createServiceRequest(service: string, data: any): ZeropointServiceRequest;
    parseResponse<T>(response: ZeropointApiResponse<T>): T;
    handleError(error: any, context: string): never;
    validateServiceRequest(request: ZeropointServiceRequest): boolean;
    applyVortexTransformation(data: any, vortexState: "consciousness" | "flowing" | "quantum"): any;
    calculateConsciousnessLevel(data: any): number;
    formatRequestForLog(request: ZeropointServiceRequest): string;
    formatResponseForLog(response: ZeropointApiResponse<any>): string;
};
//# sourceMappingURL=api-utils.d.ts.map