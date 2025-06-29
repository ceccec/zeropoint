//= require_tree .
//= require_self

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Zeropoint manifestation-driven imports from canonical seed
import "zeropoint"

// Initialize Zeropoint controllers from canonical manifest
document.addEventListener('DOMContentLoaded', () => {
  // Load controllers dynamically from canonical manifest
  const manifest = window.ZeropointManifest || {};
  const controllers = manifest.controllers?.stimulus_controllers || [];
  
  controllers.forEach(controllerName => {
    try {
      import(`zeropoint/controllers/${controllerName}`).then(module => {
        if (module.default && typeof module.default.initialize === 'function') {
          module.default.initialize();
        }
      });
    } catch (error) {
      console.warn(`Failed to load Zeropoint controller: ${controllerName}`, error);
    }
  });
}); 