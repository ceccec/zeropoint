// GraphQL UI Layout API Client - TypeScript Library
// Main entry point for the client library
// Core client
export { createClient, ZeropointClient } from './graphql-ui-layout-client';
// React hooks
export { useAPIClient, useAPIState, usePaginatedAPIState } from './hooks/use-api-client';
export { useUILayout, useOfflineData } from './hooks/use-ui-layout';
// Utilities
export { APIError, buildURL, buildHeaders, isAPIResponse, extractData, hasError, getErrorMessage, buildPaginationParams, calculatePaginationInfo, APICache, withRetry, debounce, throttle, transformKeys, camelCase, snakeCase, toCamelCase, toSnakeCase, validateEmail, validateURL, validateRequired, validateLength, formatDate, parseDate, isDateValid, formatFileSize, getFileExtension, isImageFile, isVideoFile, isAudioFile, highlightText, searchInText, searchInArray } from './utils/api-utils';
// Default export for convenience
import { createClient } from './graphql-ui-layout-client';
export default createClient;
// TypeScript entry point for Zeropoint Rails application
// COMPONENT BEST PRACTICE: Centralize all TypeScript imports and exports for Rails integration.
// Import Stimulus controllers
import { Application } from '@hotwired/stimulus';
import { registerControllers } from './controllers';
// Import utilities
export { apiUtils } from './utils/api-utils';
// Initialize Stimulus application
const application = Application.start();
// Register all controllers
registerControllers(application);
// Export the application instance
export { application };
// Zeropoint-specific exports
export const ZeropointTypeScript = {
    version: '1.0.0',
    application,
    // Add any Zeropoint-specific TypeScript functionality here
    consciousness: {
        enabled: true,
        goldenRatio: 1.618033988749895
    },
    vortex: {
        enabled: true,
        streaming: true
    }
};
// Make available globally
window.ZeropointTypeScript = ZeropointTypeScript;
//# sourceMappingURL=index.js.map