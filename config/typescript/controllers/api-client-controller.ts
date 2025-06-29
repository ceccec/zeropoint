// COMPONENT BEST PRACTICE: Stimulus controller for API client operations with TypeScript support.

import { Controller } from '@hotwired/stimulus'
import type { ZeropointApiResponse, ZeropointServiceRequest } from '../types/api-client'

export default class ApiClientController extends Controller {
  static targets = ['status', 'result', 'error']
  static values = {
    baseUrl: { type: String, default: '/zeropoint' },
    timeout: { type: Number, default: 30000 }
  }

  declare readonly statusTarget: HTMLElement
  declare readonly resultTarget: HTMLElement
  declare readonly errorTarget: HTMLElement
  declare readonly baseUrlValue: string
  declare readonly timeoutValue: number

  connect() {
    console.log('API Client Controller connected')
    this.updateStatus('Ready')
  }

  // Call a Zeropoint service
  async callService(event: Event) {
    const target = event.target as HTMLElement
    const service = target.dataset.service
    const data = target.dataset.data ? JSON.parse(target.dataset.data) : {}

    if (!service) {
      this.showError('Service name is required')
      return
    }

    try {
      this.updateStatus('Loading...')
      const request: ZeropointServiceRequest = {
        service,
        data,
        timestamp: Date.now()
      }

      const response = await this.post(request)
      this.showResult(response)
      this.updateStatus('Success')
    } catch (error) {
      this.showError(`API Error: ${error instanceof Error ? error.message : 'Unknown error'}`)
      this.updateStatus('Error')
    }
  }

  // Make a GET request
  async get(url: string): Promise<ZeropointApiResponse<any>> {
    return this.request('GET', url)
  }

  // Make a POST request
  async post(data: any): Promise<ZeropointApiResponse<any>> {
    return this.request('POST', '', data)
  }

  // Make a PUT request
  async put(url: string, data: any): Promise<ZeropointApiResponse<any>> {
    return this.request('PUT', url, data)
  }

  // Make a DELETE request
  async delete(url: string): Promise<ZeropointApiResponse<any>> {
    return this.request('DELETE', url)
  }

  // Internal request method
  private async request(method: string, url: string, data?: any): Promise<ZeropointApiResponse<any>> {
    const fullUrl = url.startsWith('http') ? url : `${this.baseUrlValue}${url}`
    
    const fetchConfig: RequestInit = {
      method,
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      },
      body: data ? JSON.stringify(data) : null,
      signal: this.timeoutValue ? AbortSignal.timeout(this.timeoutValue) : null
    }

    const response = await fetch(fullUrl, fetchConfig)
    
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`)
    }

    const responseData = await response.json()
    
    return {
      data: responseData.data,
      status: response.status,
      statusText: response.statusText,
      headers: Object.fromEntries(response.headers.entries()),
      config: { url: fullUrl },
      extensions: responseData.extensions || {
        consciousness: { enabled: false, golden_ratio: false, level: 0, handled_errors: 0 },
        vortex: { enabled: false, streaming: false, state: 'flowing', transformation_applied: false },
        uroboros: { request_uuid: '', pattern_encoded: false, vortex_transformed: false, self_evolving: false, observer_influence: null, cosmic_flow: false },
        performance: { cache_efficiency: 0, index_efficiency: 0, entropy: 0 }
      }
    }
  }

  // Update status display
  private updateStatus(status: string) {
    this.statusTarget.textContent = status
    this.statusTarget.className = `status-${status.toLowerCase().replace(/\s+/g, '-')}`
  }

  // Show result
  private showResult(response: ZeropointApiResponse<any>) {
    this.resultTarget.textContent = JSON.stringify(response.data, null, 2)
    this.resultTarget.className = 'result-success'
  }

  // Show error
  private showError(message: string) {
    this.errorTarget.textContent = message
    this.errorTarget.className = 'error-visible'
  }
} 