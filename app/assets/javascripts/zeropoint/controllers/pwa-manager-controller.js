import { Controller } from '@hotwired/stimulus'
import { UuidMatrix } from '../utils/uuid-matrix.js'

export default class PwaManagerController extends Controller {
  static targets = ['installButton', 'offlineIndicator']
  static values = {
    installPrompt: { type: Object, default: null },
    isOnline: { type: Boolean, default: navigator.onLine }
  }

  connect() {
    console.log('🌌 PWA Manager Controller connected')
    this.setupPwaFeatures()
    this.setupOfflineDetection()
    this.logAction('connect')
  }

  disconnect() {
    this.cleanupEventListeners()
  }

  // Setup PWA features
  setupPwaFeatures() {
    // Listen for beforeinstallprompt event
    window.addEventListener('beforeinstallprompt', (e) => {
      e.preventDefault()
      this.installPromptValue = e
      this.showInstallButton()
      this.logAction('install-prompt-available')
    })

    // Listen for appinstalled event
    window.addEventListener('appinstalled', () => {
      this.hideInstallButton()
      this.logAction('app-installed')
      this.showInstallationSuccess()
    })
  }

  // Setup offline detection
  setupOfflineDetection() {
    window.addEventListener('online', () => {
      this.isOnlineValue = true
      this.hideOfflineIndicator()
      this.logAction('online')
    })

    window.addEventListener('offline', () => {
      this.isOnlineValue = false
      this.showOfflineIndicator()
      this.logAction('offline')
    })
  }

  // Cleanup event listeners
  cleanupEventListeners() {
    window.removeEventListener('beforeinstallprompt', this.handleBeforeInstallPrompt)
    window.removeEventListener('appinstalled', this.handleAppInstalled)
    window.removeEventListener('online', this.handleOnline)
    window.removeEventListener('offline', this.handleOffline)
  }

  // Show install button
  showInstallButton() {
    if (this.hasInstallButtonTarget) {
      this.installButtonTarget.classList.remove('hidden')
    }
  }

  // Hide install button
  hideInstallButton() {
    if (this.hasInstallButtonTarget) {
      this.installButtonTarget.classList.add('hidden')
    }
  }

  // Show offline indicator
  showOfflineIndicator() {
    if (this.hasOfflineIndicatorTarget) {
      this.offlineIndicatorTarget.classList.add('show')
    }
  }

  // Hide offline indicator
  hideOfflineIndicator() {
    if (this.hasOfflineIndicatorTarget) {
      this.offlineIndicatorTarget.classList.remove('show')
    }
  }

  // Install PWA
  async install() {
    if (!this.installPromptValue) {
      console.log('🌌 No install prompt available')
      return
    }

    try {
      this.logAction('install-attempt')
      await this.installPromptValue.prompt()
      this.installPromptValue = null
      this.hideInstallButton()
    } catch (error) {
      console.error('🌌 PWA installation failed:', error)
      this.logAction('install-failed', { error: error.message })
    }
  }

  // Show installation success message
  showInstallationSuccess() {
    // Create a temporary success message
    const successMessage = document.createElement('div')
    successMessage.className = 'fixed top-4 right-4 bg-green-600 text-white px-4 py-2 rounded-md z-50'
    successMessage.textContent = '🎉 Astro Blog PWA installed successfully!'
    
    document.body.appendChild(successMessage)
    
    setTimeout(() => {
      successMessage.remove()
    }, 3000)
  }

  // Check if PWA is installed
  isPwaInstalled() {
    return window.matchMedia('(display-mode: standalone)').matches ||
           window.navigator.standalone === true
  }

  // Get PWA status
  getPwaStatus() {
    return {
      isInstalled: this.isPwaInstalled(),
      isOnline: this.isOnlineValue,
      hasInstallPrompt: !!this.installPromptValue,
      serviceWorkerSupported: 'serviceWorker' in navigator
    }
  }

  // Log action with UUID
  logAction(action, details = {}) {
    const uuid = UuidMatrix.generate({
      action,
      component: 'pwa-manager',
      state: 'active',
      vortex: 'flowing'
    })
    
    console.log(`[PWA Manager] Action: ${action}, UUID: ${uuid}`, details)
    
    // Dispatch event for other controllers to listen to
    this.dispatch('pwa-action', { detail: { action, uuid, details } })
  }

  // Action methods
  install() {
    this.install()
  }

  checkStatus() {
    const status = this.getPwaStatus()
    console.log('🌌 PWA Status:', status)
    this.logAction('status-check', status)
    return status
  }

  refreshCache() {
    if ('serviceWorker' in navigator) {
      navigator.serviceWorker.getRegistrations().then(registrations => {
        registrations.forEach(registration => {
          registration.update()
        })
      })
      this.logAction('cache-refresh')
    }
  }
} 