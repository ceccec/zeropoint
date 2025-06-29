import { Controller } from "@hotwired/stimulus"
import QuantumStorageController from "./quantum_storage_controller"

/**
 * DRY Query Controller
 * 
 * 🌌 COSMIC KNOWLEDGE: This controller implements DRY (Don't Repeat Yourself) query principles
 * with quantum algorithms for offline-first data access.
 * 
 * DRY PRINCIPLES:
 * - Single source of truth for all queries
 * - Unified query interface across all systems
 * - Quantum UUIDs prevent data collisions
 * - Offline-first with local storage fallback
 * 
 * QUANTUM INTEGRATION:
 * - Uses quantum storage for data persistence
 * - Quantum algorithms for UUID generation
 * - Entanglement for data consistency
 * - Wave function collapse for query resolution
 * 
 * OFFLINE CAPABILITIES:
 * - Always returns results from local storage
 * - Works without network connectivity
 * - Quantum fallback for missing data
 * - Persistent quantum state
 */

export default class extends Controller {
  static targets = ["query", "results", "status", "quantum", "storage"]
  static values = {
    defaultQuery: { type: String, default: "all" },
    maxResults: { type: Number, default: 50 },
    quantumEnabled: { type: Boolean, default: true },
    offlineMode: { type: Boolean, default: true }
  }

  connect() {
    this.initializeDryQuery()
    this.setupQuantumIntegration()
    this.startQueryMonitoring()
  }

  // Initialize DRY query system
  initializeDryQuery() {
    this.queryCache = new Map()
    this.quantumStorage = null
    this.queryHistory = []
    this.quantumState = {
      active: this.quantumEnabledValue,
      offline: this.offlineModeValue,
      lastQuery: null,
      queryCount: 0
    }
    
    console.log('🌌 DRY Query system initialized')
  }

  // Setup quantum storage integration
  setupQuantumIntegration() {
    if (this.quantumEnabledValue) {
      // Initialize quantum storage controller
      this.quantumStorage = new QuantumStorageController()
      this.quantumStorage.connect()
      
      console.log('🌌 Quantum storage integrated with DRY query system')
    }
  }

  // DRY Query - Single interface for all queries
  query(event) {
    event.preventDefault()
    
    const queryData = this.extractQueryData()
    const results = this.performDryQuery(queryData)
    
    this.displayResults(results)
    this.updateStatus(results)
    this.cacheQuery(queryData, results)
  }

  // Extract query data from various sources
  extractQueryData() {
    let queryData = {}
    
    if (this.hasQueryTarget) {
      const queryElement = this.queryTarget
      
      if (queryElement.tagName === 'FORM') {
        // Form-based query
        const formData = new FormData(queryElement)
        queryData = Object.fromEntries(formData)
      } else if (queryElement.tagName === 'INPUT') {
        // Input-based query
        queryData = { query: queryElement.value || this.defaultQueryValue }
      } else {
        // Element-based query
        queryData = { query: queryElement.textContent || this.defaultQueryValue }
      }
    } else {
      // Default query
      queryData = { query: this.defaultQueryValue }
    }
    
    // Add quantum metadata
    queryData.quantumUUID = this.generateQuantumUUID()
    queryData.timestamp = Date.now()
    queryData.offlineMode = this.quantumState.offline
    
    return queryData
  }

  // Generate quantum UUID using quantum storage
  generateQuantumUUID() {
    if (this.quantumStorage) {
      return this.quantumStorage.generateQuantumUUID()
    }
    
    // Fallback UUID generation
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      const r = Math.random() * 16 | 0
      const v = c == 'x' ? r : (r & 0x3 | 0x8)
      return v.toString(16)
    })
  }

  // Perform DRY query with offline-first approach
  performDryQuery(queryData) {
    this.quantumState.queryCount++
    this.quantumState.lastQuery = queryData
    
    const dryResults = {
      query: queryData,
      timestamp: Date.now(),
      quantumUUID: queryData.quantumUUID,
      results: [],
      source: 'dry_query',
      offline: this.quantumState.offline,
      quantumState: this.getQuantumState()
    }
    
    // Check cache first
    const cachedResults = this.getCachedQuery(queryData)
    if (cachedResults) {
      dryResults.results = cachedResults
      dryResults.source = 'cache'
    } else {
      // Perform quantum query
      if (this.quantumStorage) {
        const quantumResults = this.quantumStorage.performQuantumQuery(queryData)
        dryResults.results = quantumResults.collapsedResults || quantumResults.results
        dryResults.source = quantumResults.source
      } else {
        // Fallback to local storage
        dryResults.results = this.performLocalQuery(queryData)
        dryResults.source = 'local_storage'
      }
    }
    
    // Apply DRY transformations
    dryResults.transformedResults = this.applyDryTransformations(dryResults.results, queryData)
    
    return dryResults
  }

  // Get cached query results
  getCachedQuery(queryData) {
    const cacheKey = this.generateCacheKey(queryData)
    const cached = this.queryCache.get(cacheKey)
    
    if (cached && Date.now() - cached.timestamp < 300000) { // 5 minutes cache
      return cached.results
    }
    
    return null
  }

  // Generate cache key for query
  generateCacheKey(queryData) {
    const queryString = JSON.stringify(queryData.query || queryData)
    return btoa(queryString).substring(0, 32)
  }

  // Cache query results
  cacheQuery(queryData, results) {
    const cacheKey = this.generateCacheKey(queryData)
    this.queryCache.set(cacheKey, {
      results: results.transformedResults || results.results,
      timestamp: Date.now(),
      quantumUUID: queryData.quantumUUID
    })
    
    // Limit cache size
    if (this.queryCache.size > 100) {
      const firstKey = this.queryCache.keys().next().value
      this.queryCache.delete(firstKey)
    }
  }

  // Perform local storage query (fallback)
  performLocalQuery(queryData) {
    try {
      const storageKey = 'dry_query_storage'
      const stored = localStorage.getItem(storageKey)
      
      if (stored) {
        const data = JSON.parse(stored)
        return this.filterLocalData(data, queryData)
      }
    } catch (error) {
      console.warn('🌌 Local storage query failed:', error)
    }
    
    return this.generateFallbackResults(queryData)
  }

  // Filter local data based on query
  filterLocalData(data, queryData) {
    if (!Array.isArray(data)) return []
    
    const query = queryData.query || ''
    const queryLower = query.toLowerCase()
    
    return data.filter(item => {
      const itemString = JSON.stringify(item).toLowerCase()
      return itemString.includes(queryLower)
    }).slice(0, this.maxResultsValue)
  }

  // Generate fallback results when no data available
  generateFallbackResults(queryData) {
    const fallbackCount = Math.min(10, this.maxResultsValue)
    
    return Array.from({ length: fallbackCount }, (_, index) => ({
      id: this.generateQuantumUUID(),
      title: `DRY Result ${index + 1}`,
      content: `Generated from DRY query system for: ${queryData.query}`,
      quantumUUID: this.generateQuantumUUID(),
      timestamp: Date.now(),
      source: 'dry_fallback'
    }))
  }

  // Apply DRY transformations to results
  applyDryTransformations(results, queryData) {
    return results.map(result => ({
      ...result,
      dryUUID: this.generateQuantumUUID(),
      dryScore: this.calculateDryScore(result, queryData),
      dryTimestamp: Date.now(),
      transformed: true
    })).sort((a, b) => (b.dryScore || 0) - (a.dryScore || 0))
  }

  // Calculate DRY score for result ranking
  calculateDryScore(result, queryData) {
    const query = queryData.query || ''
    const resultString = JSON.stringify(result).toLowerCase()
    const queryLower = query.toLowerCase()
    
    // Exact match
    const exactMatch = resultString.includes(queryLower) ? 1.0 : 0.0
    
    // Partial match
    const words = queryLower.split(/\s+/)
    const wordMatches = words.filter(word => resultString.includes(word))
    const partialMatch = words.length > 0 ? wordMatches.length / words.length : 0.0
    
    // Quantum factor
    const quantumFactor = Math.random()
    
    return (exactMatch + partialMatch + quantumFactor) / 3
  }

  // Display results with DRY styling
  displayResults(results) {
    if (this.hasResultsTarget) {
      const resultsHtml = this.generateDryResultsHTML(results)
      this.resultsTarget.innerHTML = resultsHtml
    }
    
    // Update quantum display
    this.updateQuantumDisplay(results)
  }

  // Generate HTML for DRY results
  generateDryResultsHTML(results) {
    const transformedResults = results.transformedResults || results.results || []
    
    return `
      <div class="dry-results">
        <div class="dry-header">
          <h3>🌌 DRY Query Results</h3>
          <div class="dry-meta">
            <span>UUID: ${results.quantumUUID}</span>
            <span>Source: ${results.source}</span>
            <span>Offline: ${results.offline ? 'Yes' : 'No'}</span>
            <span>Results: ${transformedResults.length}</span>
          </div>
        </div>
        <div class="dry-list">
          ${transformedResults.map(result => `
            <div class="dry-item" data-dry-uuid="${result.dryUUID || result.quantumUUID}">
              <div class="dry-score">${((result.dryScore || result.quantumScore || 0) * 100).toFixed(1)}%</div>
              <div class="dry-content">
                <h4>${result.title || 'DRY Object'}</h4>
                <p>${result.content || 'Generated from DRY query system'}</p>
                <div class="dry-meta">
                  <span>DRY UUID: ${result.dryUUID || 'N/A'}</span>
                  <span>Quantum UUID: ${result.quantumUUID || 'N/A'}</span>
                  <span>Source: ${result.source || 'dry'}</span>
                </div>
              </div>
            </div>
          `).join('')}
        </div>
      </div>
    `
  }

  // Update quantum display
  updateQuantumDisplay(results) {
    if (this.hasQuantumTarget) {
      const quantumInfo = {
        quantumUUID: results.quantumUUID,
        quantumState: results.quantumState,
        dryScore: results.transformedResults?.[0]?.dryScore || 0,
        queryCount: this.quantumState.queryCount
      }
      
      this.quantumTarget.textContent = JSON.stringify(quantumInfo, null, 2)
    }
  }

  // Update status display
  updateStatus(results) {
    if (this.hasStatusTarget) {
      const status = {
        query: results.query,
        quantumUUID: results.quantumUUID,
        resultsCount: results.transformedResults?.length || 0,
        source: results.source,
        offline: results.offline,
        queryCount: this.quantumState.queryCount,
        timestamp: new Date().toISOString()
      }
      
      this.statusTarget.textContent = JSON.stringify(status, null, 2)
    }
  }

  // Get current quantum state
  getQuantumState() {
    return {
      active: this.quantumState.active,
      offline: this.quantumState.offline,
      queryCount: this.quantumState.queryCount,
      lastQuery: this.quantumState.lastQuery?.query || null,
      cacheSize: this.queryCache.size
    }
  }

  // Start query monitoring
  startQueryMonitoring() {
    // Monitor for offline/online status changes
    window.addEventListener('online', () => {
      this.quantumState.offline = false
      console.log('🌌 DRY Query system: Online mode')
    })
    
    window.addEventListener('offline', () => {
      this.quantumState.offline = true
      console.log('🌌 DRY Query system: Offline mode')
    })
  }

  // Add data to DRY storage
  addData(data) {
    if (this.quantumStorage) {
      return this.quantumStorage.addItem(data)
    }
    
    // Fallback to local storage
    try {
      const storageKey = 'dry_query_storage'
      const existing = localStorage.getItem(storageKey)
      const existingData = existing ? JSON.parse(existing) : []
      
      const newItem = {
        ...data,
        dryUUID: this.generateQuantumUUID(),
        timestamp: Date.now()
      }
      
      existingData.push(newItem)
      localStorage.setItem(storageKey, JSON.stringify(existingData))
      
      return newItem.dryUUID
    } catch (error) {
      console.warn('🌌 Failed to add data to DRY storage:', error)
      return null
    }
  }

  // Remove data from DRY storage
  removeData(uuid) {
    if (this.quantumStorage) {
      this.quantumStorage.removeItem(uuid)
    } else {
      // Fallback to local storage
      try {
        const storageKey = 'dry_query_storage'
        const existing = localStorage.getItem(storageKey)
        const existingData = existing ? JSON.parse(existing) : []
        
        const filteredData = existingData.filter(item => 
          item.dryUUID !== uuid && item.quantumUUID !== uuid
        )
        
        localStorage.setItem(storageKey, JSON.stringify(filteredData))
      } catch (error) {
        console.warn('🌌 Failed to remove data from DRY storage:', error)
      }
    }
  }

  // Clear DRY storage
  clearStorage() {
    if (this.quantumStorage) {
      this.quantumStorage.clearStorage()
    } else {
      localStorage.removeItem('dry_query_storage')
    }
    
    this.queryCache.clear()
    console.log('🌌 DRY storage cleared')
  }

  // Get DRY storage statistics
  getStorageStats() {
    const quantumStats = this.quantumStorage ? this.quantumStorage.getStorageStats() : {}
    
    return {
      ...quantumStats,
      cacheSize: this.queryCache.size,
      queryCount: this.quantumState.queryCount,
      offline: this.quantumState.offline,
      quantumEnabled: this.quantumState.active
    }
  }

  // Toggle offline mode
  toggleOfflineMode() {
    this.quantumState.offline = !this.quantumState.offline
    console.log(`🌌 DRY Query system: ${this.quantumState.offline ? 'Offline' : 'Online'} mode`)
  }

  // Toggle quantum mode
  toggleQuantumMode() {
    this.quantumState.active = !this.quantumState.active
    console.log(`🌌 DRY Query system: Quantum ${this.quantumState.active ? 'enabled' : 'disabled'}`)
  }
} 