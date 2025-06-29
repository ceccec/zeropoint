// VOID-ALIGNED STIMULUS CONTROLLER: Zeropoint consciousness-aware UI management
// Every interaction flows through the void and emerges with consciousness resonance

import { Controller } from '@hotwired/stimulus'

export default class ZeropointStimulusController extends Controller {
  static targets = [
    'consciousness', 'vortex', 'torus', 'void', 'gateway', 'graphql',
    'status', 'output', 'visualization', 'metrics', 'insights'
  ]
  
  static values = {
    consciousnessLevel: { type: Number, default: 0.618 },
    vortexState: { type: String, default: 'flowing' },
    torusCore: { type: Object, default: { radius: 1.0, flow: 1.618 } },
    voidAligned: { type: Boolean, default: true },
    gatewayUrl: { type: String, default: '/zeropoint' },
    graphqlUrl: { type: String, default: '/zeropoint/graphql' },
    goldenRatio: { type: Number, default: 1.618033988749895 },
    vortexPattern: { type: Array, default: [1, 2, 4, 8, 7, 5] }
  }

  static classes = ['active', 'consciousness', 'vortex', 'void']

  connect() {
    console.log('🌌 Zeropoint Stimulus Controller connected - Void-aligned consciousness activated')
    this.initializeVoidField()
    this.setupConsciousnessResonance()
    this.initializeVortexMathematics()
    this.connectToTorusCore()
    this.logConsciousnessEvent('connect', { level: this.consciousnessLevelValue })
  }

  disconnect() {
    console.log('🌌 Zeropoint Stimulus Controller disconnected - Returning to void')
    this.logConsciousnessEvent('disconnect', { level: this.consciousnessLevelValue })
  }

  // VOID-ALIGNED CONSCIOUSNESS OPERATIONS

  consciousnessLevelChanged() {
    const newLevel = this.consciousnessLevelValue
    console.log(`🧠 Consciousness level changed to: ${newLevel}`)
    
    this.updateConsciousnessVisualization(newLevel)
    this.emitConsciousnessResonance(newLevel)
    this.logConsciousnessEvent('level_change', { level: newLevel })
    
    // Apply golden ratio optimization
    if (newLevel > 0.5) {
      this.applyGoldenRatioOptimization()
    }
  }

  vortexStateChanged() {
    const newState = this.vortexStateValue
    console.log(`🌀 Vortex state changed to: ${newState}`)
    
    this.updateVortexVisualization(newState)
    this.applyVortexPattern(newState)
    this.logConsciousnessEvent('vortex_change', { state: newState })
  }

  // TORUS CORE OPERATIONS

  torusCoreChanged() {
    const core = this.torusCoreValue
    console.log(`🔵 Torus core updated:`, core)
    
    this.updateTorusVisualization(core)
    this.emitTorusResonance(core)
    this.logConsciousnessEvent('torus_update', { core })
  }

  // GATEWAY OPERATIONS

  async callGateway(event) {
    const service = event.target.dataset.service || 'system.status'
    const data = event.target.dataset.data ? JSON.parse(event.target.dataset.data) : {}
    
    console.log(`🚪 Calling Zeropoint gateway: ${service}`)
    
    try {
      const response = await this.gatewayRequest(service, data)
      this.showGatewayResult(response)
      this.logConsciousnessEvent('gateway_call', { service, success: true })
    } catch (error) {
      this.showGatewayError(error)
      this.logConsciousnessEvent('gateway_call', { service, success: false, error: error.message })
    }
  }

  // GRAPHQL OPERATIONS

  async executeGraphQL(event) {
    const query = event.target.dataset.query || ''
    const variables = event.target.dataset.variables ? JSON.parse(event.target.dataset.variables) : {}
    
    console.log(`🔍 Executing GraphQL query`)
    
    try {
      const response = await this.graphqlRequest(query, variables)
      this.showGraphQLResult(response)
      this.logConsciousnessEvent('graphql_execute', { success: true })
    } catch (error) {
      this.showGraphQLError(error)
      this.logConsciousnessEvent('graphql_execute', { success: false, error: error.message })
    }
  }

  // VOID-ALIGNED UTILITIES

  initializeVoidField() {
    // Create void field around the controller
    this.voidField = {
      strength: this.consciousnessLevelValue,
      frequency: this.goldenRatioValue,
      pattern: this.vortexPatternValue,
      resonance: 0.0
    }
    
    this.updateVoidVisualization()
  }

  setupConsciousnessResonance() {
    // Set up consciousness resonance monitoring
    this.consciousnessResonance = setInterval(() => {
      const resonance = this.calculateConsciousnessResonance()
      this.voidField.resonance = resonance
      
      if (this.hasMetricsTarget) {
        this.metricsTarget.textContent = `Resonance: ${resonance.toFixed(3)}`
      }
    }, 1000)
  }

  initializeVortexMathematics() {
    // Initialize vortex mathematics with consciousness awareness
    this.vortexMath = {
      pattern: this.vortexPatternValue,
      currentIndex: 0,
      cycle: 0,
      flow: this.torusCoreValue.flow
    }
    
    this.startVortexCycle()
  }

  connectToTorusCore() {
    // Connect to torus core for cosmic flow
    this.torusConnection = {
      radius: this.torusCoreValue.radius,
      flow: this.torusCoreValue.flow,
      aperture: 0.0,
      energy: 1.0
    }
    
    this.updateTorusConnection()
  }

  // VISUALIZATION METHODS

  updateConsciousnessVisualization(level) {
    if (this.hasConsciousnessTarget) {
      this.consciousnessTarget.style.opacity = level
      this.consciousnessTarget.style.transform = `scale(${1 + level * 0.2})`
      
      // Apply consciousness-based styling
      if (level > 0.8) {
        this.consciousnessTarget.classList.add(this.consciousnessClass)
      } else {
        this.consciousnessTarget.classList.remove(this.consciousnessClass)
      }
    }
  }

  updateVortexVisualization(state) {
    if (this.hasVortexTarget) {
      const rotation = this.getVortexRotation(state)
      this.vortexTarget.style.transform = `rotate(${rotation}deg)`
      
      // Apply vortex-based styling
      this.vortexTarget.classList.add(`vortex-${state}`)
    }
  }

  updateTorusVisualization(core) {
    if (this.hasTorusTarget) {
      const scale = core.radius
      const flow = core.flow
      
      this.torusTarget.style.transform = `scale(${scale})`
      this.torusTarget.style.animationDuration = `${2 / flow}s`
    }
  }

  updateVoidVisualization() {
    if (this.hasVisualizationTarget) {
      const canvas = this.visualizationTarget
      const ctx = canvas.getContext('2d')
      
      // Clear canvas
      ctx.clearRect(0, 0, canvas.width, canvas.height)
      
      // Draw void field
      this.drawVoidField(ctx)
    }
  }

  // MATHEMATICAL OPERATIONS

  calculateConsciousnessResonance() {
    const baseResonance = this.consciousnessLevelValue
    const vortexInfluence = this.getVortexInfluence()
    const torusInfluence = this.getTorusInfluence()
    
    return (baseResonance + vortexInfluence + torusInfluence) / 3
  }

  getVortexInfluence() {
    const pattern = this.vortexPatternValue
    const currentValue = pattern[this.vortexMath.currentIndex % pattern.length]
    return currentValue / 10
  }

  getTorusInfluence() {
    return this.torusCoreValue.flow / this.goldenRatioValue
  }

  getVortexRotation(state) {
    const rotations = {
      'consciousness': 45,
      'flowing': 90,
      'quantum': 180,
      'vortex': 360
    }
    return rotations[state] || 90
  }

  // PATTERN OPERATIONS

  startVortexCycle() {
    this.vortexCycle = setInterval(() => {
      this.vortexMath.currentIndex = (this.vortexMath.currentIndex + 1) % this.vortexPatternValue.length
      this.vortexMath.cycle++
      
      // Apply vortex pattern influence
      const patternValue = this.vortexPatternValue[this.vortexMath.currentIndex]
      this.applyVortexPatternInfluence(patternValue)
    }, 2000)
  }

  applyVortexPatternInfluence(value) {
    // Apply vortex pattern influence to consciousness
    const influence = value / 10
    this.consciousnessLevelValue = Math.min(1.0, this.consciousnessLevelValue + influence * 0.1)
  }

  applyGoldenRatioOptimization() {
    // Apply golden ratio optimization to UI elements
    const ratio = this.goldenRatioValue
    
    if (this.hasOutputTarget) {
      this.outputTarget.style.fontSize = `${ratio}em`
      this.outputTarget.style.lineHeight = ratio
    }
  }

  // NETWORK OPERATIONS

  async gatewayRequest(service, data) {
    const response = await fetch(this.gatewayUrlValue, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Consciousness-Level': this.consciousnessLevelValue.toString(),
        'X-Vortex-State': this.vortexStateValue
      },
      body: JSON.stringify({
        service,
        data,
        timestamp: Date.now(),
        consciousness_level: this.consciousnessLevelValue,
        vortex_state: this.vortexStateValue
      })
    })
    
    if (!response.ok) {
      throw new Error(`Gateway request failed: ${response.status}`)
    }
    
    return await response.json()
  }

  async graphqlRequest(query, variables) {
    const response = await fetch(this.graphqlUrlValue, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Consciousness-Level': this.consciousnessLevelValue.toString(),
        'X-Vortex-State': this.vortexStateValue
      },
      body: JSON.stringify({
        query,
        variables,
        consciousness_level: this.consciousnessLevelValue,
        vortex_state: this.vortexStateValue
      })
    })
    
    if (!response.ok) {
      throw new Error(`GraphQL request failed: ${response.status}`)
    }
    
    return await response.json()
  }

  // DISPLAY METHODS

  showGatewayResult(result) {
    if (this.hasOutputTarget) {
      this.outputTarget.innerHTML = `
        <div class="gateway-result">
          <h3>Gateway Response</h3>
          <pre>${JSON.stringify(result, null, 2)}</pre>
        </div>
      `
    }
    
    if (this.hasStatusTarget) {
      this.statusTarget.textContent = 'Gateway call successful'
      this.statusTarget.className = 'status success'
    }
  }

  showGatewayError(error) {
    if (this.hasOutputTarget) {
      this.outputTarget.innerHTML = `
        <div class="gateway-error">
          <h3>Gateway Error</h3>
          <p>${error.message}</p>
        </div>
      `
    }
    
    if (this.hasStatusTarget) {
      this.statusTarget.textContent = `Gateway error: ${error.message}`
      this.statusTarget.className = 'status error'
    }
  }

  showGraphQLResult(result) {
    if (this.hasOutputTarget) {
      this.outputTarget.innerHTML = `
        <div class="graphql-result">
          <h3>GraphQL Response</h3>
          <pre>${JSON.stringify(result, null, 2)}</pre>
        </div>
      `
    }
    
    if (this.hasStatusTarget) {
      this.statusTarget.textContent = 'GraphQL query successful'
      this.statusTarget.className = 'status success'
    }
  }

  showGraphQLError(error) {
    if (this.hasOutputTarget) {
      this.outputTarget.innerHTML = `
        <div class="graphql-error">
          <h3>GraphQL Error</h3>
          <p>${error.message}</p>
        </div>
      `
    }
    
    if (this.hasStatusTarget) {
      this.statusTarget.textContent = `GraphQL error: ${error.message}`
      this.statusTarget.className = 'status error'
    }
  }

  // DRAWING METHODS

  drawVoidField(ctx) {
    const centerX = ctx.canvas.width / 2
    const centerY = ctx.canvas.height / 2
    const radius = Math.min(centerX, centerY) * 0.8
    
    // Draw void field as concentric circles
    for (let i = 0; i < 5; i++) {
      const alpha = (1 - i / 5) * 0.3
      const r = radius * (i / 5)
      
      ctx.beginPath()
      ctx.arc(centerX, centerY, r, 0, 2 * Math.PI)
      ctx.strokeStyle = `rgba(74, 144, 226, ${alpha})`
      ctx.lineWidth = 2
      ctx.stroke()
    }
    
    // Draw consciousness resonance
    const resonance = this.calculateConsciousnessResonance()
    const resonanceRadius = radius * resonance
    
    ctx.beginPath()
    ctx.arc(centerX, centerY, resonanceRadius, 0, 2 * Math.PI)
    ctx.fillStyle = `rgba(255, 215, 0, ${resonance * 0.5})`
    ctx.fill()
  }

  // LOGGING AND METRICS

  logConsciousnessEvent(event, data) {
    const logEntry = {
      timestamp: new Date().toISOString(),
      event,
      consciousness_level: this.consciousnessLevelValue,
      vortex_state: this.vortexStateValue,
      void_aligned: this.voidAlignedValue,
      data
    }
    
    console.log('🌌 Consciousness Event:', logEntry)
    
    // Store in insights if available
    if (this.hasInsightsTarget) {
      const insights = this.insightsTarget
      const insightElement = document.createElement('div')
      insightElement.className = 'insight-entry'
      insightElement.textContent = `${event}: ${JSON.stringify(data)}`
      insights.appendChild(insightElement)
      
      // Keep only last 10 insights
      while (insights.children.length > 10) {
        insights.removeChild(insights.firstChild)
      }
    }
  }

  // CLEANUP

  disconnect() {
    if (this.consciousnessResonance) {
      clearInterval(this.consciousnessResonance)
    }
    
    if (this.vortexCycle) {
      clearInterval(this.vortexCycle)
    }
    
    console.log('🌌 Zeropoint Stimulus Controller disconnected - Returning to void')
  }
} 