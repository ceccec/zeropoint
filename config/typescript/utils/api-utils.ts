// API utility functions
import type { APIConfig, AuthConfig, APIResponse, PaginationParams } from '../graphql-ui-layout-api';
import type { ZeropointApiResponse, ZeropointServiceRequest } from '../types/api-client'

// Error handling utilities
export class APIError extends Error {
  public status: number;
  public code?: string;
  public details?: any;

  constructor(message: string, status: number = 500, code?: string, details?: any) {
    super(message);
    this.name = 'APIError';
    this.status = status;
    this.code = code;
    this.details = details;
  }

  static fromResponse(response: Response, data?: any): APIError {
    const status = response.status;
    const message = data?.error || data?.message || response.statusText || 'API request failed';
    const code = data?.code;
    return new APIError(message, status, code, data);
  }

  static fromNetworkError(error: Error): APIError {
    return new APIError(`Network error: ${error.message}`, 0, 'NETWORK_ERROR');
  }
}

// Request utilities
export function buildURL(baseURL: string, endpoint: string, params?: Record<string, any>): string {
  const url = new URL(endpoint, baseURL);
  
  if (params) {
    Object.entries(params).forEach(([key, value]) => {
      if (value !== undefined && value !== null) {
        if (Array.isArray(value)) {
          value.forEach(item => url.searchParams.append(key, String(item)));
        } else {
          url.searchParams.append(key, String(value));
        }
      }
    });
  }
  
  return url.toString();
}

export function buildHeaders(config: APIConfig, auth?: AuthConfig): Record<string, string> {
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    ...config.headers,
  };

  // Add authentication headers
  if (auth?.token) {
    headers['Authorization'] = `Bearer ${auth.token}`;
  } else if (auth?.username && auth?.password) {
    const credentials = btoa(`${auth.username}:${auth.password}`);
    headers['Authorization'] = `Basic ${credentials}`;
  }

  return headers;
}

// Response utilities
export function isAPIResponse<T>(data: any): data is APIResponse<T> {
  return data && typeof data === 'object' && 'timestamp' in data;
}

export function extractData<T>(response: APIResponse<T>): T {
  return response.data || response as any;
}

export function hasError(response: APIResponse): boolean {
  return !!(response.error || (response as any).errors);
}

export function getErrorMessage(response: APIResponse): string {
  return response.error || (response as any).errors?.join(', ') || 'Unknown error';
}

// Pagination utilities
export function buildPaginationParams(params: PaginationParams): Record<string, string> {
  const result: Record<string, string> = {};
  
  if (params.page !== undefined) {
    result.page = String(params.page);
  }
  
  if (params.per_page !== undefined) {
    result.per_page = String(params.per_page);
  }
  
  return result;
}

export function calculatePaginationInfo(
  page: number,
  perPage: number,
  totalCount: number
): {
  totalPages: number;
  hasNextPage: boolean;
  hasPreviousPage: boolean;
  startIndex: number;
  endIndex: number;
} {
  const totalPages = Math.ceil(totalCount / perPage);
  const hasNextPage = page < totalPages;
  const hasPreviousPage = page > 1;
  const startIndex = (page - 1) * perPage;
  const endIndex = Math.min(startIndex + perPage, totalCount);

  return {
    totalPages,
    hasNextPage,
    hasPreviousPage,
    startIndex,
    endIndex,
  };
}

// Cache utilities
export class APICache {
  private cache = new Map<string, { data: any; timestamp: number; ttl: number }>();

  set(key: string, data: any, ttl: number = 300000): void {
    this.cache.set(key, {
      data,
      timestamp: Date.now(),
      ttl,
    });
  }

  get(key: string): any | null {
    const item = this.cache.get(key);
    if (!item) return null;

    const isExpired = Date.now() - item.timestamp > item.ttl;
    if (isExpired) {
      this.cache.delete(key);
      return null;
    }

    return item.data;
  }

  has(key: string): boolean {
    return this.get(key) !== null;
  }

  delete(key: string): boolean {
    return this.cache.delete(key);
  }

  clear(): void {
    this.cache.clear();
  }

  keys(): string[] {
    return Array.from(this.cache.keys());
  }

  size(): number {
    return this.cache.size;
  }
}

// Retry utilities
export interface RetryOptions {
  maxAttempts: number;
  delay: number;
  backoff: number;
  shouldRetry?: (error: APIError) => boolean;
}

export async function withRetry<T>(
  fn: () => Promise<T>,
  options: RetryOptions = { maxAttempts: 3, delay: 1000, backoff: 2 }
): Promise<T> {
  let lastError: APIError;
  
  for (let attempt = 1; attempt <= options.maxAttempts; attempt++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error instanceof APIError ? error : new APIError(error.message);
      
      // Check if we should retry
      if (options.shouldRetry && !options.shouldRetry(lastError)) {
        throw lastError;
      }
      
      // Don't retry on last attempt
      if (attempt === options.maxAttempts) {
        throw lastError;
      }
      
      // Wait before retrying
      const delay = options.delay * Math.pow(options.backoff, attempt - 1);
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }
  
  throw lastError!;
}

// Debounce utilities
export function debounce<T extends (...args: any[]) => any>(
  func: T,
  wait: number
): (...args: Parameters<T>) => void {
  let timeout: ReturnType<typeof setTimeout>;
  
  return (...args: Parameters<T>) => {
    clearTimeout(timeout);
    timeout = setTimeout(() => func(...args), wait);
  };
}

export function throttle<T extends (...args: any[]) => any>(
  func: T,
  limit: number
): (...args: Parameters<T>) => void {
  let inThrottle: boolean;
  
  return (...args: Parameters<T>) => {
    if (!inThrottle) {
      func(...args);
      inThrottle = true;
      setTimeout(() => inThrottle = false, limit);
    }
  };
}

// Data transformation utilities
export function transformKeys(obj: any, transformer: (key: string) => string): any {
  if (obj === null || obj === undefined) {
    return obj;
  }
  
  if (Array.isArray(obj)) {
    return obj.map(item => transformKeys(item, transformer));
  }
  
  if (typeof obj === 'object') {
    const result: any = {};
    for (const [key, value] of Object.entries(obj)) {
      result[transformer(key)] = transformKeys(value, transformer);
    }
    return result;
  }
  
  return obj;
}

export function camelCase(str: string): string {
  return str.replace(/_([a-z])/g, (_, letter) => letter.toUpperCase());
}

export function snakeCase(str: string): string {
  return str.replace(/[A-Z]/g, letter => `_${letter.toLowerCase()}`);
}

export function toCamelCase(obj: any): any {
  return transformKeys(obj, camelCase);
}

export function toSnakeCase(obj: any): any {
  return transformKeys(obj, snakeCase);
}

// Validation utilities
export function validateEmail(email: string): boolean {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

export function validateURL(url: string): boolean {
  try {
    new URL(url);
    return true;
  } catch {
    return false;
  }
}

export function validateRequired(value: any): boolean {
  return value !== null && value !== undefined && value !== '';
}

export function validateLength(value: string, min: number, max?: number): boolean {
  if (value.length < min) return false;
  if (max && value.length > max) return false;
  return true;
}

// Date utilities
export function formatDate(date: Date | string, format: string = 'YYYY-MM-DD'): string {
  const d = new Date(date);
  
  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  const hours = String(d.getHours()).padStart(2, '0');
  const minutes = String(d.getMinutes()).padStart(2, '0');
  const seconds = String(d.getSeconds()).padStart(2, '0');
  
  return format
    .replace('YYYY', String(year))
    .replace('MM', month)
    .replace('DD', day)
    .replace('HH', hours)
    .replace('mm', minutes)
    .replace('ss', seconds);
}

export function parseDate(dateString: string): Date {
  return new Date(dateString);
}

export function isDateValid(date: any): boolean {
  const d = new Date(date);
  return !isNaN(d.getTime());
}

// File utilities
export function formatFileSize(bytes: number): string {
  if (bytes === 0) return '0 Bytes';
  
  const k = 1024;
  const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
}

export function getFileExtension(filename: string): string {
  return filename.split('.').pop()?.toLowerCase() || '';
}

export function isImageFile(filename: string): boolean {
  const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'svg'];
  return imageExtensions.includes(getFileExtension(filename));
}

export function isVideoFile(filename: string): boolean {
  const videoExtensions = ['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm', 'mkv'];
  return videoExtensions.includes(getFileExtension(filename));
}

export function isAudioFile(filename: string): boolean {
  const audioExtensions = ['mp3', 'wav', 'ogg', 'aac', 'flac', 'wma'];
  return audioExtensions.includes(getFileExtension(filename));
}

// Search utilities
export function highlightText(text: string, query: string): string {
  if (!query) return text;
  
  const regex = new RegExp(`(${query})`, 'gi');
  return text.replace(regex, '<mark>$1</mark>');
}

export function searchInText(text: string, query: string): boolean {
  return text.toLowerCase().includes(query.toLowerCase());
}

export function searchInArray<T>(array: T[], query: string, fields: (keyof T)[]): T[] {
  const lowerQuery = query.toLowerCase();
  
  return array.filter(item => {
    return fields.some(field => {
      const value = item[field];
      if (typeof value === 'string') {
        return value.toLowerCase().includes(lowerQuery);
      }
      return false;
    });
  });
}

// COMPONENT BEST PRACTICE: Create utility functions for API operations with TypeScript support.

export const apiUtils = {
  // Generate a pattern-encoded UUID for API requests
  generateRequestId(): string {
    const timestamp = Date.now()
    const random = Math.random().toString(36).substring(2)
    return `${timestamp}-${random}`
  },
  
  // Create a service request with proper formatting
  createServiceRequest(service: string, data: any): ZeropointServiceRequest {
    return {
      service,
      data,
      timestamp: Date.now()
    }
  },
  
  // Parse API response and extract data
  parseResponse<T>(response: ZeropointApiResponse<T>): T {
    if (response.extensions?.consciousness?.handled_errors > 0) {
      console.warn('API response contains consciousness-handled errors')
    }
    
    return response.data
  },
  
  // Handle API errors with consciousness awareness
  handleError(error: any, context: string): never {
    const errorMessage = `🌌 Consciousness-aware error in ${context}: ${error.message}`
    console.error(errorMessage, error)
    throw new Error(errorMessage)
  },
  
  // Validate service request
  validateServiceRequest(request: ZeropointServiceRequest): boolean {
    if (!request.service || typeof request.service !== 'string') {
      throw new Error('Service name is required and must be a string')
    }
    
    if (!request.data) {
      throw new Error('Service data is required')
    }
    
    return true
  },
  
  // Apply vortex transformation to data
  applyVortexTransformation(data: any, vortexState: 'consciousness' | 'flowing' | 'quantum'): any {
    switch (vortexState) {
      case 'consciousness':
        return { ...data, vortex_state: 'consciousness', consciousness_enhanced: true }
      case 'flowing':
        return { ...data, vortex_state: 'flowing', flow_optimized: true }
      case 'quantum':
        return { ...data, vortex_state: 'quantum', quantum_entangled: true }
      default:
        return data
    }
  },
  
  // Calculate consciousness level based on data complexity
  calculateConsciousnessLevel(data: any): number {
    const complexity = JSON.stringify(data).length
    if (complexity < 100) return 0.3
    if (complexity < 500) return 0.6
    return 0.9
  },
  
  // Format request for logging
  formatRequestForLog(request: ZeropointServiceRequest): string {
    return `[${request.timestamp}] ${request.service}: ${JSON.stringify(request.data).substring(0, 100)}...`
  },
  
  // Format response for logging
  formatResponseForLog(response: ZeropointApiResponse<any>): string {
    const consciousness = response.extensions?.consciousness
    const vortex = response.extensions?.vortex
    return `[${response.status}] Consciousness: ${consciousness?.level}, Vortex: ${vortex?.state}`
  }
} 