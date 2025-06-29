// TypeScript entry point for Zeropoint Rails application
// COMPONENT BEST PRACTICE: Centralize all TypeScript imports and exports for Rails integration.

// Import Stimulus controllers
import { Application } from '@hotwired/stimulus'
import { registerControllers } from './controllers'

// Import utilities
export { apiUtils } from './utils/api-utils'

// Import types
export type { ApiClient, ZeropointApiResponse, ZeropointServiceRequest } from './types/api-client'
export type { UiLayout, Theme, Navigation, Content, Sidebar, Widget } from './types/ui-layout'

// Initialize Stimulus application
const application = Application.start()

// Register all controllers
registerControllers(application)

// Export the application instance
export { application }

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
}

// Global type declarations
declare global {
  interface Window {
    ZeropointTypeScript: typeof ZeropointTypeScript
  }
}

// Make available globally
window.ZeropointTypeScript = ZeropointTypeScript