// PWA Manager Controller Tests
// Tests for PWA installation, offline detection, and status management

import { Application } from '@hotwired/stimulus'
import PwaManagerController from '../../app/assets/javascripts/zeropoint/controllers/pwa-manager-controller.js'
import { UuidMatrix } from '../../app/assets/javascripts/zeropoint/utils/uuid-matrix.js'

// Mock console for testing
global.console = {
  log: jest.fn(),
  error: jest.fn(),
  warn: jest.fn()
}

// Mock navigator
Object.defineProperty(global, 'navigator', {
  value: {
    onLine: true,
    serviceWorker: {
      getRegistrations: jest.fn().mockResolvedValue([])
    }
  },
  writable: true
})

// Mock window.matchMedia
Object.defineProperty(global, 'matchMedia', {
  value: jest.fn().mockImplementation(query => ({
    matches: false,
    media: query,
    onchange: null,
    addListener: jest.fn(),
    removeListener: jest.fn(),
    addEventListener: jest.fn(),
    removeEventListener: jest.fn(),
    dispatchEvent: jest.fn()
  })),
  writable: true
})

describe('PwaManagerController', () => {
  let application
  let controller
  let element

  beforeEach(() => {
    // Setup DOM element
    element = document.createElement('div')
    element.innerHTML = `
      <button data-pwa-manager-target="installButton" class="hidden">📱 Install PWA</button>
      <div data-pwa-manager-target="offlineIndicator" class="offline-indicator">📡 You're offline</div>
    `

    // Setup Stimulus application
    application = Application.start()
    application.register('pwa-manager', PwaManagerController)
    
    // Add controller to element
    element.setAttribute('data-controller', 'pwa-manager')
  })

  afterEach(() => {
    application.stop()
    console.log.mockClear()
    console.error.mockClear()
  })

  describe('Initialization', () => {
    it('connects successfully', () => {
      document.body.appendChild(element)
      
      expect(console.log).toHaveBeenCalledWith('🌌 PWA Manager Controller connected')
    })

    it('generates UUID on connect', () => {
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      document.body.appendChild(element)
      
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'connect',
        component: 'pwa-manager',
        state: 'active',
        vortex: 'flowing'
      })
    })

    it('sets up PWA features', () => {
      const addEventListenerSpy = jest.spyOn(window, 'addEventListener')
      document.body.appendChild(element)
      
      expect(addEventListenerSpy).toHaveBeenCalledWith('beforeinstallprompt', expect.any(Function))
      expect(addEventListenerSpy).toHaveBeenCalledWith('appinstalled', expect.any(Function))
    })

    it('sets up offline detection', () => {
      const addEventListenerSpy = jest.spyOn(window, 'addEventListener')
      document.body.appendChild(element)
      
      expect(addEventListenerSpy).toHaveBeenCalledWith('online', expect.any(Function))
      expect(addEventListenerSpy).toHaveBeenCalledWith('offline', expect.any(Function))
    })
  })

  describe('PWA Installation', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'pwa-manager')
    })

    it('shows install button when beforeinstallprompt event fires', () => {
      const installButton = element.querySelector('[data-pwa-manager-target="installButton"]')
      
      // Initially hidden
      expect(installButton.classList.contains('hidden')).toBe(true)
      
      // Trigger beforeinstallprompt event
      const event = new Event('beforeinstallprompt')
      event.preventDefault = jest.fn()
      event.prompt = jest.fn().mockResolvedValue({ outcome: 'accepted' })
      window.dispatchEvent(event)
      
      // Should show install button
      expect(installButton.classList.contains('hidden')).toBe(false)
    })

    it('handles install prompt', async () => {
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      
      // Set up install prompt
      controller.installPromptValue = {
        prompt: jest.fn().mockResolvedValue({ outcome: 'accepted' })
      }
      
      await controller.install()
      
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'install-attempt',
        component: 'pwa-manager',
        state: 'active',
        vortex: 'flowing'
      })
      
      expect(controller.installPromptValue).toBeNull()
    })

    it('handles install failure gracefully', async () => {
      controller.installPromptValue = {
        prompt: jest.fn().mockRejectedValue(new Error('Install failed'))
      }
      
      await controller.install()
      
      expect(console.error).toHaveBeenCalledWith(
        '🌌 PWA installation failed:',
        expect.any(Error)
      )
    })

    it('shows installation success message', () => {
      const createElementSpy = jest.spyOn(document, 'createElement')
      const appendChildSpy = jest.spyOn(document.body, 'appendChild')
      const removeSpy = jest.spyOn(Element.prototype, 'remove')
      
      controller.showInstallationSuccess()
      
      expect(createElementSpy).toHaveBeenCalledWith('div')
      expect(appendChildSpy).toHaveBeenCalled()
      
      // Wait for timeout
      jest.advanceTimersByTime(3000)
      expect(removeSpy).toHaveBeenCalled()
    })

    it('hides install button after app installation', () => {
      const installButton = element.querySelector('[data-pwa-manager-target="installButton"]')
      
      // Show button first
      installButton.classList.remove('hidden')
      expect(installButton.classList.contains('hidden')).toBe(false)
      
      // Trigger appinstalled event
      window.dispatchEvent(new Event('appinstalled'))
      
      // Should hide button
      expect(installButton.classList.contains('hidden')).toBe(true)
    })
  })

  describe('Offline Detection', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'pwa-manager')
    })

    it('shows offline indicator when offline', () => {
      const offlineIndicator = element.querySelector('[data-pwa-manager-target="offlineIndicator"]')
      
      // Initially hidden
      expect(offlineIndicator.classList.contains('show')).toBe(false)
      
      // Trigger offline event
      window.dispatchEvent(new Event('offline'))
      
      // Should show offline indicator
      expect(offlineIndicator.classList.contains('show')).toBe(true)
      expect(controller.isOnlineValue).toBe(false)
    })

    it('hides offline indicator when back online', () => {
      const offlineIndicator = element.querySelector('[data-pwa-manager-target="offlineIndicator"]')
      
      // Go offline first
      window.dispatchEvent(new Event('offline'))
      expect(offlineIndicator.classList.contains('show')).toBe(true)
      
      // Go back online
      window.dispatchEvent(new Event('online'))
      
      // Should hide offline indicator
      expect(offlineIndicator.classList.contains('show')).toBe(false)
      expect(controller.isOnlineValue).toBe(true)
    })

    it('generates UUID for online/offline events', () => {
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      
      // Trigger offline event
      window.dispatchEvent(new Event('offline'))
      
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'offline',
        component: 'pwa-manager',
        state: 'active',
        vortex: 'flowing'
      })
      
      // Trigger online event
      window.dispatchEvent(new Event('online'))
      
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'online',
        component: 'pwa-manager',
        state: 'active',
        vortex: 'flowing'
      })
    })
  })

  describe('PWA Status', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'astro-blog')
    })

    it('checks if PWA is installed', () => {
      // Mock standalone mode
      matchMedia.mockImplementation(query => ({
        matches: query === '(display-mode: standalone)',
        media: query,
        onchange: null,
        addListener: jest.fn(),
        removeListener: jest.fn(),
        addEventListener: jest.fn(),
        removeEventListener: jest.fn(),
        dispatchEvent: jest.fn()
      }))
      
      expect(controller.isPwaInstalled()).toBe(true)
    })

    it('gets PWA status', () => {
      const status = controller.getPwaStatus()
      
      expect(status).toHaveProperty('isInstalled')
      expect(status).toHaveProperty('isOnline')
      expect(status).toHaveProperty('hasInstallPrompt')
      expect(status).toHaveProperty('serviceWorkerSupported')
    })

    it('generates UUID for status check', () => {
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      
      controller.checkStatus()
      
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'status-check',
        component: 'pwa-manager',
        state: 'active',
        vortex: 'flowing'
      })
    })
  })

  describe('Service Worker Management', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'pwa-manager')
    })

    it('refreshes cache', () => {
      const getRegistrationsSpy = jest.spyOn(navigator.serviceWorker, 'getRegistrations')
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      
      controller.refreshCache()
      
      expect(getRegistrationsSpy).toHaveBeenCalled()
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'cache-refresh',
        component: 'pwa-manager',
        state: 'active',
        vortex: 'flowing'
      })
    })

    it('handles service worker registration updates', () => {
      const mockRegistration = {
        update: jest.fn()
      }
      
      navigator.serviceWorker.getRegistrations.mockResolvedValue([mockRegistration])
      
      controller.refreshCache()
      
      expect(mockRegistration.update).toHaveBeenCalled()
    })
  })

  describe('Event Handling', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'pwa-manager')
    })

    it('dispatches PWA action events', () => {
      const dispatchSpy = jest.spyOn(controller, 'dispatch')
      
      controller.logAction('test-action', { detail: 'test' })
      
      expect(dispatchSpy).toHaveBeenCalledWith('pwa-action', {
        detail: {
          action: 'test-action',
          uuid: expect.any(String),
          details: { detail: 'test' }
        }
      })
    })

    it('handles missing targets gracefully', () => {
      // Remove targets from DOM
      element.innerHTML = '<div></div>'
      
      // Should not throw errors
      expect(() => {
        controller.showInstallButton()
        controller.hideInstallButton()
        controller.showOfflineIndicator()
        controller.hideOfflineIndicator()
      }).not.toThrow()
    })
  })

  describe('Cleanup', () => {
    it('removes event listeners on disconnect', () => {
      const removeEventListenerSpy = jest.spyOn(window, 'removeEventListener')
      
      document.body.appendChild(element)
      element.remove()
      
      expect(removeEventListenerSpy).toHaveBeenCalledWith('beforeinstallprompt', expect.any(Function))
      expect(removeEventListenerSpy).toHaveBeenCalledWith('appinstalled', expect.any(Function))
      expect(removeEventListenerSpy).toHaveBeenCalledWith('online', expect.any(Function))
      expect(removeEventListenerSpy).toHaveBeenCalledWith('offline', expect.any(Function))
    })
  })

  describe('Error Handling', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'pwa-manager')
    })

    it('handles install prompt errors gracefully', async () => {
      controller.installPromptValue = null
      
      await controller.install()
      
      expect(console.log).toHaveBeenCalledWith('🌌 No install prompt available')
    })

    it('handles service worker errors gracefully', () => {
      navigator.serviceWorker.getRegistrations.mockRejectedValue(new Error('SW Error'))
      
      expect(() => {
        controller.refreshCache()
      }).not.toThrow()
    })
  })

  describe('Mobile Detection', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'pwa-manager')
    })

    it('detects iOS standalone mode', () => {
      // Mock iOS navigator.standalone
      Object.defineProperty(navigator, 'standalone', {
        value: true,
        writable: true
      })
      
      expect(controller.isPwaInstalled()).toBe(true)
    })

    it('detects Android standalone mode', () => {
      // Mock Android display-mode: standalone
      matchMedia.mockImplementation(query => ({
        matches: query === '(display-mode: standalone)',
        media: query,
        onchange: null,
        addListener: jest.fn(),
        removeListener: jest.fn(),
        addEventListener: jest.fn(),
        removeEventListener: jest.fn(),
        dispatchEvent: jest.fn()
      }))
      
      expect(controller.isPwaInstalled()).toBe(true)
    })
  })
}) 