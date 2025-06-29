// COMPONENT BEST PRACTICE: Centralize controller registration for Stimulus with TypeScript support.
import ApiClientController from './api-client-controller';
import UiLayoutController from './ui-layout-controller';
// Import all controllers here
// import UuidStimulusController from './uuid-stimulus-controller'
// import VortexController from './vortex-controller'
// import ConsciousnessController from './consciousness-controller'
export function registerControllers(application) {
    // Register all controllers
    application.register('api-client', ApiClientController);
    application.register('ui-layout', UiLayoutController);
    // Placeholder for future controllers
    console.log('Zeropoint TypeScript controllers registered');
}
// Export individual controllers for direct import if needed
// export { UuidStimulusController, VortexController, ConsciousnessController } 
export { ApiClientController, UiLayoutController };
//# sourceMappingURL=index.js.map