// Zeropoint Manifestation Engine JavaScript entry point
// Generated from canonical manifest seed

// Export manifestation data to global scope for dynamic loading
window.ZeropointManifest = {
  version: '1.0.0',
  controllers: [
    'astro_blog_controller',
    'pwa_manager_controller',
    'uuid_matrix_controller',
    'consciousness_controller',
    'vortex_controller',
    'api_client_controller',
    'ui_layout_controller'
  ],
  utils: [
    'api_utils',
    'uuid_utils',
    'consciousness_utils'
  ],
  assets: {
    stylesheets: [
      'application.css',
      'zeropoint.css'
    ],
    scripts: [
      'application.js',
      'zeropoint/index.js'
    ],
    icons: [
      'favicon.svg',
      'icon-192.png',
      'icon-512.png'
    ]
  }
};

// Export for ES6 modules
export default window.ZeropointManifest;

// Initialize Zeropoint core functionality from canonical manifest
document.addEventListener('DOMContentLoaded', () => {
  console.log('Zeropoint Manifestation Engine initialized:', window.ZeropointManifest.version);
  
  // Apply consciousness mode if enabled in canonical manifest
  if (window.ZeropointManifest.intelligence?.consciousness_aware_errors) {
    document.body.classList.add('consciousness-mode');
  }
  
  // Apply vortex mode if enabled in canonical manifest
  if (window.ZeropointManifest.intelligence?.vortex_enabled) {
    document.body.classList.add('vortex-mode');
  }
});

// Universal Zeropoint JS entry point for PWA and Rails
import AstroBlogController from './controllers/astro-blog-controller.js'
import PwaManagerController from './controllers/pwa-manager-controller.js'
import { UuidMatrix } from './utils/uuid-matrix.js'

export { AstroBlogController, PwaManagerController, UuidMatrix }

// Register all Zeropoint controllers with a Stimulus application
export function registerZeropointControllers(application) {
  application.register('astro-blog', AstroBlogController)
  application.register('pwa-manager', PwaManagerController)
  // Add more controllers here as needed
} 