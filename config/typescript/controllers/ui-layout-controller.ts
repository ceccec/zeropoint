// COMPONENT BEST PRACTICE: Stimulus controller for UI layout management with TypeScript support.

import { Controller } from '@hotwired/stimulus'
import type { UiLayout, Theme, Navigation, Content, Sidebar, Widget } from '../types/ui-layout'

export default class UiLayoutController extends Controller {
  static targets = ['theme', 'navigation', 'content', 'sidebar', 'widgets']
  static values = {
    layout: { type: Object, default: {} },
    consciousness: { type: Boolean, default: true },
    vortex: { type: Boolean, default: true },
    goldenRatio: { type: Boolean, default: true }
  }

  declare readonly themeTarget: HTMLElement
  declare readonly navigationTarget: HTMLElement
  declare readonly contentTarget: HTMLElement
  declare readonly sidebarTarget: HTMLElement
  declare readonly widgetsTarget: HTMLElement
  declare readonly layoutValue: UiLayout
  declare readonly consciousnessValue: boolean
  declare readonly vortexValue: boolean
  declare readonly goldenRatioValue: boolean

  private currentLayout!: UiLayout

  connect() {
    console.log('UI Layout Controller connected')
    this.initializeLayout()
    this.applyLayout()
  }

  // Initialize default layout
  private initializeLayout() {
    this.currentLayout = {
      theme: {
        name: 'zeropoint',
        primary: '#0ea5e9',
        secondary: '#d946ef',
        background: '#0f172a',
        text: '#f8fafc',
        consciousness: this.consciousnessValue,
        goldenRatio: this.goldenRatioValue,
        vortex: this.vortexValue
      },
      navigation: {
        items: [
          { id: 'home', label: 'Home', url: '/', consciousness: true },
          { id: 'graphql', label: 'GraphQL', url: '/zeropoint/graphql', vortex: true },
          { id: 'health', label: 'Health', url: '/zeropoint/health' }
        ],
        position: 'top',
        collapsed: false
      },
      content: {
        title: 'Zeropoint Unified Intelligence',
        body: 'Welcome to the unified field of consciousness',
        layout: 'single',
        consciousness: this.consciousnessValue,
        goldenRatio: this.goldenRatioValue
      },
      sidebar: {
        enabled: true,
        position: 'right',
        width: 300,
        widgets: []
      },
      widgets: []
    }
  }

  // Apply layout to DOM
  private applyLayout() {
    this.applyTheme()
    this.applyNavigation()
    this.applyContent()
    this.applySidebar()
  }

  // Apply theme
  private applyTheme() {
    const theme = this.currentLayout.theme
    
    // Apply CSS custom properties
    document.documentElement.style.setProperty('--primary-color', theme.primary)
    document.documentElement.style.setProperty('--secondary-color', theme.secondary)
    document.documentElement.style.setProperty('--background-color', theme.background)
    document.documentElement.style.setProperty('--text-color', theme.text)

    // Apply consciousness mode
    document.body.classList.toggle('consciousness-mode', theme.consciousness)
    
    // Apply vortex mode
    document.body.classList.toggle('vortex-mode', theme.vortex || false)
    
    // Apply golden ratio
    document.body.classList.toggle('golden-ratio-mode', theme.goldenRatio)

    this.themeTarget.className = `theme-${theme.name}`
  }

  // Apply navigation
  private applyNavigation() {
    const navigation = this.currentLayout.navigation
    
    this.navigationTarget.className = `navigation-${navigation.position} ${navigation.collapsed ? 'collapsed' : ''}`
    
    // Render navigation items
    const navHtml = navigation.items.map(item => `
      <a href="${item.url}" 
         class="nav-item ${item.consciousness ? 'consciousness' : ''} ${item.vortex ? 'vortex' : ''}"
         data-action="click->ui-layout#navigate">
        ${item.icon ? `<i class="${item.icon}"></i>` : ''}
        <span>${item.label}</span>
      </a>
    `).join('')
    
    this.navigationTarget.innerHTML = navHtml
  }

  // Apply content
  private applyContent() {
    const content = this.currentLayout.content
    
    this.contentTarget.className = `content-layout-${content.layout} ${content.consciousness ? 'consciousness' : ''} ${content.goldenRatio ? 'golden-ratio' : ''}`
    
    this.contentTarget.innerHTML = `
      <h1 class="content-title">${content.title}</h1>
      <div class="content-body">${content.body}</div>
    `
  }

  // Apply sidebar
  private applySidebar() {
    const sidebar = this.currentLayout.sidebar
    
    this.sidebarTarget.className = `sidebar-${sidebar.position} ${sidebar.enabled ? 'enabled' : 'disabled'}`
    this.sidebarTarget.style.width = sidebar.enabled ? `${sidebar.width}px` : '0'
    
    // Render widgets
    const widgetsHtml = sidebar.widgets.map(widget => `
      <div class="widget widget-${widget.type}" data-widget-id="${widget.id}">
        <h3 class="widget-title">${widget.title}</h3>
        <div class="widget-content">${widget.content}</div>
      </div>
    `).join('')
    
    this.sidebarTarget.innerHTML = widgetsHtml
  }

  // Toggle consciousness mode
  toggleConsciousness() {
    this.currentLayout.theme.consciousness = !this.currentLayout.theme.consciousness
    this.currentLayout.content.consciousness = !this.currentLayout.content.consciousness
    this.applyTheme()
    this.applyContent()
  }

  // Toggle vortex mode
  toggleVortex() {
    this.currentLayout.theme.vortex = !this.currentLayout.theme.vortex
    this.applyTheme()
  }

  // Toggle golden ratio mode
  toggleGoldenRatio() {
    this.currentLayout.theme.goldenRatio = !this.currentLayout.theme.goldenRatio
    this.currentLayout.content.goldenRatio = !this.currentLayout.content.goldenRatio
    this.applyTheme()
    this.applyContent()
  }

  // Toggle sidebar
  toggleSidebar() {
    this.currentLayout.sidebar.enabled = !this.currentLayout.sidebar.enabled
    this.applySidebar()
  }

  // Add widget
  addWidget(event: Event) {
    const target = event.target as HTMLElement
    const widgetType = target.dataset.widgetType as Widget['type']
    const widgetTitle = target.dataset.widgetTitle || 'New Widget'
    
    if (!widgetType) return

    const widget: Widget = {
      id: `widget-${Date.now()}`,
      type: widgetType,
      title: widgetTitle,
      content: `<div class="widget-placeholder">${widgetType} widget content</div>`,
      position: this.currentLayout.widgets.length,
      config: {
        consciousness: this.consciousnessValue,
        vortex: this.vortexValue,
        observer: true,
        autoUpdate: true
      }
    }

    this.currentLayout.widgets.push(widget)
    this.currentLayout.sidebar.widgets.push(widget)
    this.applySidebar()
  }

  // Remove widget
  removeWidget(event: Event) {
    const target = event.target as HTMLElement
    const widgetId = target.dataset.widgetId
    
    if (!widgetId) return

    this.currentLayout.widgets = this.currentLayout.widgets.filter(w => w.id !== widgetId)
    this.currentLayout.sidebar.widgets = this.currentLayout.sidebar.widgets.filter(w => w.id !== widgetId)
    this.applySidebar()
  }

  // Navigate to a page
  navigate(event: Event) {
    const target = event.target as HTMLElement
    const url = target.getAttribute('href')
    
    if (url) {
      window.location.href = url
    }
  }

  // Update theme
  updateTheme(event: Event) {
    const target = event.target as HTMLElement
    const themeProperty = target.dataset.themeProperty as keyof Theme
    const themeValue = target.dataset.themeValue
    
    if (themeProperty && themeValue) {
      (this.currentLayout.theme as any)[themeProperty] = themeValue
      this.applyTheme()
    }
  }
} 