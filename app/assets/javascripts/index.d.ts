export { createClient, ZeropointClient } from './graphql-ui-layout-client';
export type { APIConfig, AuthConfig, APIResponse, PaginationParams, PaginatedResponse, HealthCheck, GraphQL, UILayout, Search, Files, Analytics, Notifications, Cache, APIClient } from './graphql-ui-layout-api';
export { useAPIClient, useAPIState, usePaginatedAPIState } from './hooks/use-api-client';
export { useUILayout, useOfflineData } from './hooks/use-ui-layout';
export { APIError, buildURL, buildHeaders, isAPIResponse, extractData, hasError, getErrorMessage, buildPaginationParams, calculatePaginationInfo, APICache, withRetry, debounce, throttle, transformKeys, camelCase, snakeCase, toCamelCase, toSnakeCase, validateEmail, validateURL, validateRequired, validateLength, formatDate, parseDate, isDateValid, formatFileSize, getFileExtension, isImageFile, isVideoFile, isAudioFile, highlightText, searchInText, searchInArray } from './utils/api-utils';
export type { RetryOptions } from './utils/api-utils';
import { createClient } from './graphql-ui-layout-client';
export default createClient;
import { Application } from '@hotwired/stimulus';
export { apiUtils } from './utils/api-utils';
export type { ApiClient, ZeropointApiResponse, ZeropointServiceRequest } from './types/api-client';
export type { UiLayout, Theme, Navigation, Content, Sidebar, Widget } from './types/ui-layout';
declare const application: Application;
export { application };
export declare const ZeropointTypeScript: {
    version: string;
    application: Application;
    consciousness: {
        enabled: boolean;
        goldenRatio: number;
    };
    vortex: {
        enabled: boolean;
        streaming: boolean;
    };
};
declare global {
    interface Window {
        ZeropointTypeScript: typeof ZeropointTypeScript;
    }
}
//# sourceMappingURL=index.d.ts.map