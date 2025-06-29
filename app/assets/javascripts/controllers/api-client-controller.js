// COMPONENT BEST PRACTICE: Stimulus controller for API client operations with void-aligned I18n.
import { Controller } from '@hotwired/stimulus';

class ApiClientController extends Controller {
    connect() {
        console.log('API Client Controller connected');
        this.updateStatus(this.getI18nController().text('zeropoint.api.status.ready'));
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
                    'zeropoint.api.status.ready': 'Ready',
                    'zeropoint.api.status.loading': 'Loading...',
                    'zeropoint.api.status.success': 'Success',
                    'zeropoint.api.status.error': 'Error',
                    'zeropoint.api.errors.service_required': 'Service name is required',
                    'zeropoint.api.errors.api_error': 'API Error: %{message}',
                    'zeropoint.api.errors.unknown_error': 'Unknown error'
                };
                const text = translations[key] || `[Missing: ${key}]`;
                return text.replace(/%\{(\w+)\}/g, (match, k) => options[k] || match);
            }
        };
    }

    // Call a Zeropoint service
    async callService(event) {
        const target = event.target;
        const service = target.dataset.service;
        const data = target.dataset.data ? JSON.parse(target.dataset.data) : {};
        
        if (!service) {
            this.showError(this.getI18nController().text('zeropoint.api.errors.service_required'));
            return;
        }

        try {
            this.updateStatus(this.getI18nController().text('zeropoint.api.status.loading'));
            const request = {
                service,
                data,
                timestamp: Date.now()
            };
            const response = await this.post(request);
            this.showResult(response);
            this.updateStatus(this.getI18nController().text('zeropoint.api.status.success'));
        }
        catch (error) {
            const errorMessage = error instanceof Error ? error.message : this.getI18nController().text('zeropoint.api.errors.unknown_error');
            this.showError(this.getI18nController().text('zeropoint.api.errors.api_error', { message: errorMessage }));
            this.updateStatus(this.getI18nController().text('zeropoint.api.status.error'));
        }
    }

    // Make a GET request
    async get(url) {
        return this.request('GET', url);
    }

    // Make a POST request
    async post(data) {
        return this.request('POST', '', data);
    }

    // Make a PUT request
    async put(url, data) {
        return this.request('PUT', url, data);
    }

    // Make a DELETE request
    async delete(url) {
        return this.request('DELETE', url);
    }

    // Internal request method
    async request(method, url, data) {
        const fullUrl = url.startsWith('http') ? url : `${this.baseUrlValue}${url}`;
        const fetchConfig = {
            method,
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: data ? JSON.stringify(data) : null,
            signal: this.timeoutValue ? AbortSignal.timeout(this.timeoutValue) : undefined
        };

        const response = await fetch(fullUrl, fetchConfig);
        if (!response.ok) {
            throw new Error(`${this.getI18nController().text('zeropoint.api.errors.http_error', { status: response.status, statusText: response.statusText })}`);
        }

        const responseData = await response.json();
        return {
            data: responseData.data,
            status: response.status,
            statusText: response.statusText,
            headers: Object.fromEntries(response.headers.entries()),
            config: { method, url: fullUrl },
            extensions: responseData.extensions || {
                consciousness: { enabled: false, golden_ratio: false, level: 0, handled_errors: 0 },
                vortex: { enabled: false, streaming: false, state: 'flowing', transformation_applied: false },
                uroboros: { request_uuid: '', pattern_encoded: false, vortex_transformed: false, self_evolving: false, observer_influence: null, cosmic_flow: false },
                performance: { cache_efficiency: 0, index_efficiency: 0, entropy: 0 }
            }
        };
    }

    // Update status display
    updateStatus(status) {
        if (this.hasStatusTarget) {
            this.statusTarget.textContent = status;
            this.statusTarget.className = `status-${status.toLowerCase().replace(/\s+/g, '-')}`;
        }
    }

    // Show result
    showResult(response) {
        if (this.hasResultTarget) {
            this.resultTarget.textContent = JSON.stringify(response.data, null, 2);
            this.resultTarget.className = 'result-success';
        }
    }

    // Show error
    showError(message) {
        if (this.hasErrorTarget) {
            this.errorTarget.textContent = message;
            this.errorTarget.className = 'error-visible';
        }
    }
}

ApiClientController.targets = ['status', 'result', 'error'];
ApiClientController.values = {
    baseUrl: { type: String, default: '/zeropoint' },
    timeout: { type: Number, default: 30000 }
};

export default ApiClientController;
//# sourceMappingURL=api-client-controller.js.map