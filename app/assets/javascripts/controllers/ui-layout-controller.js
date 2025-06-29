// COMPONENT BEST PRACTICE: Stimulus controller for UI layout management with void-aligned I18n.
import { Controller } from '@hotwired/stimulus';

class UiLayoutController extends Controller {
    connect() {
        console.log('UI Layout Controller connected');
        this.initializeLayout();
        this.applyLayout();
    }

    // Get I18n controller for void-aligned text
    getI18nController() {
        return this.application.getControllerForElementAndIdentifier(
            document.querySelector('[data-controller~="i18n"]'), 
            'i18n'
        ) || this.createFallbackI18n();
    }

    // Fallback I18n if no I18n controller is available
    createFallbackI18n() {
        return {
            text: (key, options = {}) => {
                const translations = {
                    'zeropoint.navigation.home': 'Home',
                    'zeropoint.navigation.graphql': 'GraphQL',
                    'zeropoint.navigation.health': 'Health',
                    'zeropoint.content.title': 'Zeropoint Unified Intelligence',
                    'zeropoint.content.body': 'Welcome to the unified field of consciousness',
                    'zeropoint.widgets.new_widget': 'New Widget',
                    'zeropoint.widgets.placeholder': '%{type} widget content'
                };
                const text = translations[key] || `[Missing: ${key}]`;
                return text.replace(/%\{(\w+)\}/g, (match, k) => options[k] || match);
            }
        };
    }

    // Initialize default layout
    initializeLayout() {
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
                    { id: 'home', label: this.getI18nController().text('zeropoint.navigation.home'), url: '/', consciousness: true },
                    { id: 'graphql', label: this.getI18nController().text('zeropoint.navigation.graphql'), url: '/zeropoint/graphql', vortex: true },
                    { id: 'health', label: this.getI18nController().text('zeropoint.navigation.health'), url: '/zeropoint/health' }
                ],
                position: 'top',
                collapsed: false
            },
            content: {
                title: this.getI18nController().text('zeropoint.content.title'),
                body: this.getI18nController().text('zeropoint.content.body'),
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
        };
    }

    // Apply layout to DOM
    applyLayout() {
        this.applyTheme();
        this.applyNavigation();
        this.applyContent();
        this.applySidebar();
    }

    // Apply theme
    applyTheme() {
        const theme = this.currentLayout.theme;
        // Apply CSS custom properties
        document.documentElement.style.setProperty('--primary-color', theme.primary);
        document.documentElement.style.setProperty('--secondary-color', theme.secondary);
        document.documentElement.style.setProperty('--background-color', theme.background);
        document.documentElement.style.setProperty('--text-color', theme.text);
        // Apply consciousness mode
        document.body.classList.toggle('consciousness-mode', theme.consciousness);
        // Apply vortex mode
        document.body.classList.toggle('vortex-mode', theme.vortex || false);
        // Apply golden ratio
        document.body.classList.toggle('golden-ratio-mode', theme.goldenRatio);
        if (this.hasThemeTarget) {
            this.themeTarget.className = `theme-${theme.name}`;
        }
    }

    // Apply navigation
    applyNavigation() {
        const navigation = this.currentLayout.navigation;
        if (this.hasNavigationTarget) {
            this.navigationTarget.className = `navigation-${navigation.position} ${navigation.collapsed ? 'collapsed' : ''}`;
            // Render navigation items
            const navHtml = navigation.items.map(item => `
        <a href="${item.url}" 
           class="nav-item ${item.consciousness ? 'consciousness' : ''} ${item.vortex ? 'vortex' : ''}"
           data-action="click->ui-layout#navigate">
          ${item.icon ? `<i class="${item.icon}"></i>` : ''}
          <span>${item.label}</span>
        </a>
      `).join('');
            this.navigationTarget.innerHTML = navHtml;
        }
    }

    // Apply content
    applyContent() {
        const content = this.currentLayout.content;
        if (this.hasContentTarget) {
            this.contentTarget.className = `content-layout-${content.layout} ${content.consciousness ? 'consciousness' : ''} ${content.goldenRatio ? 'golden-ratio' : ''}`;
            this.contentTarget.innerHTML = `
        <h1 class="content-title">${content.title}</h1>
        <div class="content-body">${content.body}</div>
      `;
        }
    }

    // Apply sidebar
    applySidebar() {
        const sidebar = this.currentLayout.sidebar;
        if (this.hasSidebarTarget) {
            this.sidebarTarget.className = `sidebar-${sidebar.position} ${sidebar.enabled ? 'enabled' : 'disabled'}`;
            this.sidebarTarget.style.width = sidebar.enabled ? `${sidebar.width}px` : '0';
            // Render widgets
            const widgetsHtml = sidebar.widgets.map(widget => `
        <div class="widget widget-${widget.type}" data-widget-id="${widget.id}">
          <h3 class="widget-title">${widget.title}</h3>
          <div class="widget-content">${widget.content}</div>
        </div>
      `).join('');
            this.sidebarTarget.innerHTML = widgetsHtml;
        }
    }

    // Toggle consciousness mode
    toggleConsciousness() {
        this.currentLayout.theme.consciousness = !this.currentLayout.theme.consciousness;
        this.currentLayout.content.consciousness = !this.currentLayout.content.consciousness;
        this.applyTheme();
        this.applyContent();
    }

    // Toggle vortex mode
    toggleVortex() {
        this.currentLayout.theme.vortex = !this.currentLayout.theme.vortex;
        this.applyTheme();
    }

    // Toggle golden ratio mode
    toggleGoldenRatio() {
        this.currentLayout.theme.goldenRatio = !this.currentLayout.theme.goldenRatio;
        this.currentLayout.content.goldenRatio = !this.currentLayout.content.goldenRatio;
        this.applyTheme();
        this.applyContent();
    }

    // Toggle sidebar
    toggleSidebar() {
        this.currentLayout.sidebar.enabled = !this.currentLayout.sidebar.enabled;
        this.applySidebar();
    }

    // Add widget
    addWidget(event) {
        const target = event.target;
        const widgetType = target.dataset.widgetType;
        const widgetTitle = target.dataset.widgetTitle || this.getI18nController().text('zeropoint.widgets.new_widget');
        
        if (!widgetType) return;

        const widget = {
            id: `widget-${Date.now()}`,
            type: widgetType,
            title: widgetTitle,
            content: `<div class="widget-placeholder">${this.getI18nController().text('zeropoint.widgets.placeholder', { type: widgetType })}</div>`,
            position: this.currentLayout.widgets.length,
            config: {
                consciousness: this.consciousnessValue,
                vortex: this.vortexValue,
                observer: true,
                autoUpdate: true
            }
        };
        this.currentLayout.widgets.push(widget);
        this.currentLayout.sidebar.widgets.push(widget);
        this.applySidebar();
    }

    // Remove widget
    removeWidget(event) {
        const target = event.target;
        const widgetId = target.dataset.widgetId;
        if (!widgetId) return;
        this.currentLayout.widgets = this.currentLayout.widgets.filter(w => w.id !== widgetId);
        this.currentLayout.sidebar.widgets = this.currentLayout.sidebar.widgets.filter(w => w.id !== widgetId);
        this.applySidebar();
    }

    // Navigate to a page
    navigate(event) {
        const target = event.target;
        const url = target.getAttribute('href');
        if (url) {
            window.location.href = url;
        }
    }

    // Update theme
    updateTheme(event) {
        const target = event.target;
        const themeProperty = target.dataset.themeProperty;
        const themeValue = target.dataset.themeValue;
        if (themeProperty && themeValue) {
            this.currentLayout.theme[themeProperty] = themeValue;
            this.applyTheme();
        }
    }
}

UiLayoutController.targets = ['theme', 'navigation', 'content', 'sidebar', 'widgets'];
UiLayoutController.values = {
    layout: { type: Object, default: {} },
    consciousness: { type: Boolean, default: true },
    vortex: { type: Boolean, default: true },
    goldenRatio: { type: Boolean, default: true }
};

export default UiLayoutController;
//# sourceMappingURL=ui-layout-controller.js.map