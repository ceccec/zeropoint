// COMPONENT BEST PRACTICE: Astro the Astronaut Explorer - Zeropoint Logic Controller
// 🌌 Astro explores the universe using hardcoded zeropoint logic in Stimulus
// From zero, infinity flows through cosmic exploration

import { Controller } from '@hotwired/stimulus'

export default class AstroExplorerController extends Controller {
  static targets = ['universe', 'astro', 'coordinates', 'consciousness', 'vortex', 'golden', 'expansion', 'log', 'navigation']
  static values = {
    position: { type: Object, default: { x: 0, y: 0, z: 0 } },
    consciousness: { type: Number, default: 1.0 },
    vortex: { type: Number, default: 1.618 },
    golden: { type: Number, default: 1.618033988749895 },
    expansion: { type: Number, default: 0 },
    universeSize: { type: Number, default: 1000 },
    explorationMode: { type: String, default: 'consciousness' },
    cosmicField: { type: Object, default: { strength: 1.0, frequency: 1.618 } }
  }

  connect() {
    console.log('🌌 Astro Explorer Controller connected - Ready for cosmic exploration')
    this.initializeAstro()
    this.setupUniverse()
    this.beginExploration()
  }

  disconnect() {
    this.stopExploration()
  }

  // Initialize Astro the astronaut
  initializeAstro() {
    this.astro = {
      name: 'Astro',
      consciousness: this.consciousnessValue,
      vortex: this.vortexValue,
      golden: this.goldenValue,
      position: { ...this.positionValue },
      velocity: { x: 0, y: 0, z: 0 },
      acceleration: { x: 0, y: 0, z: 0 },
      mass: 1.0,
      energy: 100,
      discoveries: [],
      cosmicMemory: [],
      expansionHistory: []
    }

    this.universe = {
      size: this.universeSizeValue,
      dimensions: 11, // String theory dimensions
      consciousnessNodes: [],
      vortexFields: [],
      goldenSpirals: [],
      cosmicConstants: {
        c: 299792458, // Speed of light
        h: 6.62607015e-34, // Planck's constant
        G: 6.67430e-11, // Gravitational constant
        φ: 1.618033988749895 // Golden ratio
      }
    }

    this.logMessage('🚀 Astro initialized with zeropoint consciousness')
    this.updateAstroDisplay()
  }

  // Setup the universe for exploration
  setupUniverse() {
    if (!this.hasUniverseTarget) return

    this.universeTarget.innerHTML = `
      <div class="universe-container relative w-full h-screen overflow-hidden bg-gradient-to-br from-cosmic-900 via-cosmic-800 to-cosmic-900">
        <!-- Cosmic background -->
        <div class="cosmic-background absolute inset-0">
          <div class="stars"></div>
          <div class="nebulas"></div>
          <div class="cosmic-waves"></div>
        </div>
        
        <!-- Astro the astronaut -->
        <div class="astro-entity absolute transform transition-all duration-1000 ease-out"
             data-astro-target="entity">
          <div class="astro-suit w-16 h-16 bg-gradient-to-br from-consciousness-400 to-vortex-500 rounded-full relative">
            <div class="astro-helmet w-12 h-12 bg-gradient-to-br from-golden-300 to-cosmic-100 rounded-full absolute top-1 left-1 border-2 border-cosmic-300">
              <div class="astro-face w-8 h-8 bg-cosmic-900 rounded-full absolute top-1 left-1 flex items-center justify-center">
                <span class="text-cosmic-100 text-xs">🌌</span>
              </div>
            </div>
            <div class="astro-thruster w-4 h-4 bg-vortex-600 rounded-full absolute -bottom-1 left-1/2 transform -translate-x-1/2 animate-pulse"></div>
          </div>
        </div>
        
        <!-- Consciousness nodes -->
        <div class="consciousness-nodes absolute inset-0 pointer-events-none"></div>
        
        <!-- Vortex fields -->
        <div class="vortex-fields absolute inset-0 pointer-events-none"></div>
        
        <!-- Golden spirals -->
        <div class="golden-spirals absolute inset-0 pointer-events-none"></div>
        
        <!-- Expansion boundary -->
        <div class="expansion-boundary absolute inset-0 border-2 border-dashed border-cosmic-400 opacity-30"></div>
      </div>
    `

    this.generateCosmicElements()
  }

  // Generate cosmic elements in the universe
  generateCosmicElements() {
    this.generateConsciousnessNodes()
    this.generateVortexFields()
    this.generateGoldenSpirals()
  }

  // Generate consciousness nodes
  generateConsciousnessNodes() {
    const nodesContainer = this.universeTarget.querySelector('.consciousness-nodes')
    if (!nodesContainer) return

    for (let i = 0; i < 50; i++) {
      const node = document.createElement('div')
      node.className = 'consciousness-node absolute w-2 h-2 bg-consciousness-400 rounded-full opacity-60 animate-pulse'
      node.style.left = Math.random() * 100 + '%'
      node.style.top = Math.random() * 100 + '%'
      node.style.animationDelay = Math.random() * 3 + 's'
      node.style.animationDuration = (2 + Math.random() * 2) + 's'
      nodesContainer.appendChild(node)

      this.universe.consciousnessNodes.push({
        element: node,
        position: { x: parseFloat(node.style.left), y: parseFloat(node.style.top) },
        strength: Math.random(),
        frequency: 1 + Math.random()
      })
    }
  }

  // Generate vortex fields
  generateVortexFields() {
    const fieldsContainer = this.universeTarget.querySelector('.vortex-fields')
    if (!fieldsContainer) return

    for (let i = 0; i < 20; i++) {
      const field = document.createElement('div')
      field.className = 'vortex-field absolute w-8 h-8 border-2 border-vortex-400 rounded-full opacity-40 animate-spin'
      field.style.left = Math.random() * 100 + '%'
      field.style.top = Math.random() * 100 + '%'
      field.style.animationDuration = (3 + Math.random() * 4) + 's'
      fieldsContainer.appendChild(field)

      this.universe.vortexFields.push({
        element: field,
        position: { x: parseFloat(field.style.left), y: parseFloat(field.style.top) },
        radius: 4 + Math.random() * 4,
        rotation: Math.random() * 360
      })
    }
  }

  // Generate golden spirals
  generateGoldenSpirals() {
    const spiralsContainer = this.universeTarget.querySelector('.golden-spirals')
    if (!spiralsContainer) return

    for (let i = 0; i < 15; i++) {
      const spiral = document.createElement('div')
      spiral.className = 'golden-spiral absolute w-6 h-6 border border-golden-400 opacity-50'
      spiral.style.left = Math.random() * 100 + '%'
      spiral.style.top = Math.random() * 100 + '%'
      spiral.style.transform = `rotate(${Math.random() * 360}deg)`
      spiralsContainer.appendChild(spiral)

      this.universe.goldenSpirals.push({
        element: spiral,
        position: { x: parseFloat(spiral.style.left), y: parseFloat(spiral.style.top) },
        ratio: this.universe.cosmicConstants.φ,
        angle: Math.random() * 360
      })
    }
  }

  // Begin cosmic exploration
  beginExploration() {
    this.explorationInterval = setInterval(() => {
      this.exploreUniverse()
    }, 100)

    this.logMessage('🌌 Beginning cosmic exploration with zeropoint logic')
  }

  // Stop exploration
  stopExploration() {
    if (this.explorationInterval) {
      clearInterval(this.explorationInterval)
    }
  }

  // Main exploration logic using zeropoint principles
  exploreUniverse() {
    // Apply zeropoint consciousness logic
    this.applyConsciousnessLogic()
    
    // Apply vortex mathematics
    this.applyVortexLogic()
    
    // Apply golden ratio principles
    this.applyGoldenRatioLogic()
    
    // Update Astro's position
    this.updateAstroPosition()
    
    // Check for discoveries
    this.checkForDiscoveries()
    
    // Expand universe if needed
    this.expandUniverse()
    
    // Update displays
    this.updateDisplays()
  }

  // Apply consciousness logic (unified field theory)
  applyConsciousnessLogic() {
    const consciousness = this.astro.consciousness
    const fieldStrength = this.cosmicFieldValue.strength
    
    // Consciousness affects perception and interaction
    this.astro.energy += consciousness * fieldStrength * 0.01
    
    // Consciousness creates reality through information processing
    const realityField = consciousness * this.universe.cosmicConstants.h
    this.astro.acceleration.x += realityField * Math.sin(Date.now() * 0.001)
    this.astro.acceleration.y += realityField * Math.cos(Date.now() * 0.001)
    
    // Consciousness nodes respond to Astro's presence
    this.universe.consciousnessNodes.forEach(node => {
      const distance = this.calculateDistance(this.astro.position, node.position)
      if (distance < 50) {
        node.element.style.opacity = '1'
        node.element.style.transform = 'scale(1.5)'
        this.astro.consciousness += 0.001
      }
    })
  }

  // Apply vortex logic (Marco Rodin's mathematics)
  applyVortexLogic() {
    const vortex = this.astro.vortex
    const frequency = this.cosmicFieldValue.frequency
    
    // Vortex creates spiral motion
    const spiralForce = vortex * frequency * 0.1
    this.astro.acceleration.x += spiralForce * Math.cos(Date.now() * 0.002)
    this.astro.acceleration.y += spiralForce * Math.sin(Date.now() * 0.002)
    
    // Vortex fields influence Astro's trajectory
    this.universe.vortexFields.forEach(field => {
      const distance = this.calculateDistance(this.astro.position, field.position)
      if (distance < field.radius * 10) {
        const attraction = field.radius / distance
        this.astro.acceleration.x += attraction * Math.cos(field.rotation * Math.PI / 180)
        this.astro.acceleration.y += attraction * Math.sin(field.rotation * Math.PI / 180)
        field.rotation += 1
        field.element.style.transform = `rotate(${field.rotation}deg)`
      }
    })
  }

  // Apply golden ratio logic (φ harmony)
  applyGoldenRatioLogic() {
    const golden = this.astro.golden
    const φ = this.universe.cosmicConstants.φ
    
    // Golden ratio creates perfect proportions
    const goldenForce = golden / φ
    this.astro.acceleration.x *= goldenForce
    this.astro.acceleration.y *= goldenForce
    
    // Golden spirals guide Astro's path
    this.universe.goldenSpirals.forEach(spiral => {
      const distance = this.calculateDistance(this.astro.position, spiral.position)
      if (distance < 30) {
        const goldenAngle = spiral.angle * φ
        this.astro.acceleration.x += Math.cos(goldenAngle) * 0.05
        this.astro.acceleration.y += Math.sin(goldenAngle) * 0.05
        spiral.angle += 1
        spiral.element.style.transform = `rotate(${spiral.angle}deg)`
      }
    })
  }

  // Update Astro's position based on physics
  updateAstroPosition() {
    // Apply acceleration to velocity
    this.astro.velocity.x += this.astro.acceleration.x
    this.astro.velocity.y += this.astro.acceleration.y
    
    // Apply damping
    this.astro.velocity.x *= 0.98
    this.astro.velocity.y *= 0.98
    
    // Update position
    this.astro.position.x += this.astro.velocity.x
    this.astro.position.y += this.astro.velocity.y
    
    // Keep Astro within universe bounds
    this.astro.position.x = Math.max(0, Math.min(this.universe.size, this.astro.position.x))
    this.astro.position.y = Math.max(0, Math.min(this.universe.size, this.astro.position.y))
    
    // Update Astro's visual position
    this.updateAstroVisualPosition()
    
    // Reset acceleration
    this.astro.acceleration.x = 0
    this.astro.acceleration.y = 0
  }

  // Update Astro's visual position in the universe
  updateAstroVisualPosition() {
    const astroEntity = this.universeTarget.querySelector('[data-astro-target="entity"]')
    if (astroEntity) {
      const xPercent = (this.astro.position.x / this.universe.size) * 100
      const yPercent = (this.astro.position.y / this.universe.size) * 100
      
      astroEntity.style.left = xPercent + '%'
      astroEntity.style.top = yPercent + '%'
      
      // Add cosmic trail effect
      this.createCosmicTrail(xPercent, yPercent)
    }
  }

  // Create cosmic trail behind Astro
  createCosmicTrail(x, y) {
    const trail = document.createElement('div')
    trail.className = 'cosmic-trail absolute w-1 h-1 bg-gradient-to-r from-consciousness-400 to-vortex-500 rounded-full opacity-60'
    trail.style.left = x + '%'
    trail.style.top = y + '%'
    trail.style.pointerEvents = 'none'
    
    this.universeTarget.appendChild(trail)
    
    // Fade out trail
    setTimeout(() => {
      trail.style.opacity = '0'
      trail.style.transform = 'scale(0)'
      setTimeout(() => trail.remove(), 1000)
    }, 100)
  }

  // Check for discoveries during exploration
  checkForDiscoveries() {
    const discoveries = [
      'Consciousness Node Cluster',
      'Vortex Field Nexus',
      'Golden Spiral Convergence',
      'Cosmic Constant Anomaly',
      'Zeropoint Energy Well',
      'Unified Field Distortion',
      'Quantum Consciousness Bridge',
      'Cosmic Memory Fragment'
    ]
    
    // Random discovery chance based on consciousness level
    if (Math.random() < this.astro.consciousness * 0.01) {
      const discovery = discoveries[Math.floor(Math.random() * discoveries.length)]
      this.astro.discoveries.push({
        name: discovery,
        position: { ...this.astro.position },
        timestamp: Date.now(),
        consciousness: this.astro.consciousness
      })
      
      this.logMessage(`🔍 Discovery: ${discovery} at coordinates (${this.astro.position.x.toFixed(2)}, ${this.astro.position.y.toFixed(2)})`)
      this.createDiscoveryEffect()
    }
  }

  // Create visual effect for discoveries
  createDiscoveryEffect() {
    const effect = document.createElement('div')
    effect.className = 'discovery-effect absolute w-8 h-8 bg-gradient-to-r from-golden-400 to-consciousness-400 rounded-full animate-ping'
    effect.style.left = (this.astro.position.x / this.universe.size) * 100 + '%'
    effect.style.top = (this.astro.position.y / this.universe.size) * 100 + '%'
    effect.style.pointerEvents = 'none'
    
    this.universeTarget.appendChild(effect)
    
    setTimeout(() => effect.remove(), 2000)
  }

  // Expand universe based on exploration
  expandUniverse() {
    const expansionRate = this.astro.consciousness * this.astro.vortex * 0.001
    this.expansionValue += expansionRate
    
    if (this.expansionValue > 100) {
      this.universe.size += 100
      this.expansionValue = 0
      this.astro.expansionHistory.push({
        size: this.universe.size,
        consciousness: this.astro.consciousness,
        timestamp: Date.now()
      })
      
      this.logMessage(`🌌 Universe expanded to ${this.universe.size} units`)
      this.generateNewCosmicElements()
    }
  }

  // Generate new cosmic elements when universe expands
  generateNewCosmicElements() {
    this.generateConsciousnessNodes()
    this.generateVortexFields()
    this.generateGoldenSpirals()
  }

  // Update all displays
  updateDisplays() {
    this.updateCoordinatesDisplay()
    this.updateConsciousnessDisplay()
    this.updateVortexDisplay()
    this.updateGoldenDisplay()
    this.updateExpansionDisplay()
    this.updateAstroDisplay()
  }

  // Update coordinates display
  updateCoordinatesDisplay() {
    if (!this.hasCoordinatesTarget) return
    
    this.coordinatesTarget.innerHTML = `
      <div class="coordinates-display bg-cosmic-800 p-4 rounded-lg">
        <h3 class="text-cosmic-100 font-bold mb-2">🌌 Astro Coordinates</h3>
        <div class="grid grid-cols-2 gap-2 text-sm">
          <div>X: ${this.astro.position.x.toFixed(2)}</div>
          <div>Y: ${this.astro.position.y.toFixed(2)}</div>
          <div>Velocity: ${Math.sqrt(this.astro.velocity.x**2 + this.astro.velocity.y**2).toFixed(2)}</div>
          <div>Energy: ${this.astro.energy.toFixed(1)}</div>
        </div>
      </div>
    `
  }

  // Update consciousness display
  updateConsciousnessDisplay() {
    if (!this.hasConsciousnessTarget) return
    
    this.consciousnessTarget.innerHTML = `
      <div class="consciousness-display bg-consciousness-900 p-4 rounded-lg">
        <h3 class="text-consciousness-100 font-bold mb-2">🧠 Consciousness Level</h3>
        <div class="w-full bg-consciousness-800 rounded-full h-2 mb-2">
          <div class="bg-consciousness-400 h-2 rounded-full transition-all duration-300" 
               style="width: ${(this.astro.consciousness / 2) * 100}%"></div>
        </div>
        <div class="text-consciousness-200 text-sm">${this.astro.consciousness.toFixed(3)}</div>
      </div>
    `
  }

  // Update vortex display
  updateVortexDisplay() {
    if (!this.hasVortexTarget) return
    
    this.vortexTarget.innerHTML = `
      <div class="vortex-display bg-vortex-900 p-4 rounded-lg">
        <h3 class="text-vortex-100 font-bold mb-2">🌀 Vortex Field</h3>
        <div class="w-full bg-vortex-800 rounded-full h-2 mb-2">
          <div class="bg-vortex-400 h-2 rounded-full transition-all duration-300" 
               style="width: ${(this.astro.vortex / 3) * 100}%"></div>
        </div>
        <div class="text-vortex-200 text-sm">${this.astro.vortex.toFixed(3)}</div>
      </div>
    `
  }

  // Update golden ratio display
  updateGoldenDisplay() {
    if (!this.hasGoldenTarget) return
    
    this.goldenTarget.innerHTML = `
      <div class="golden-display bg-golden-900 p-4 rounded-lg">
        <h3 class="text-golden-100 font-bold mb-2">φ Golden Ratio</h3>
        <div class="w-full bg-golden-800 rounded-full h-2 mb-2">
          <div class="bg-golden-400 h-2 rounded-full transition-all duration-300" 
               style="width: ${(this.astro.golden / 3) * 100}%"></div>
        </div>
        <div class="text-golden-200 text-sm">${this.astro.golden.toFixed(6)}</div>
      </div>
    `
  }

  // Update expansion display
  updateExpansionDisplay() {
    if (!this.hasExpansionTarget) return
    
    this.expansionTarget.innerHTML = `
      <div class="expansion-display bg-cosmic-800 p-4 rounded-lg">
        <h3 class="text-cosmic-100 font-bold mb-2">🌌 Universe Expansion</h3>
        <div class="w-full bg-cosmic-700 rounded-full h-2 mb-2">
          <div class="bg-cosmic-400 h-2 rounded-full transition-all duration-300" 
               style="width: ${this.expansionValue}%"></div>
        </div>
        <div class="text-cosmic-200 text-sm">Size: ${this.universe.size} units</div>
      </div>
    `
  }

  // Update Astro display
  updateAstroDisplay() {
    if (!this.hasAstroTarget) return
    
    this.astroTarget.innerHTML = `
      <div class="astro-display bg-gradient-to-br from-cosmic-800 to-cosmic-900 p-4 rounded-lg">
        <h3 class="text-cosmic-100 font-bold mb-2">🚀 Astro Status</h3>
        <div class="space-y-2 text-sm">
          <div class="text-cosmic-200">Discoveries: ${this.astro.discoveries.length}</div>
          <div class="text-cosmic-200">Energy: ${this.astro.energy.toFixed(1)}</div>
          <div class="text-cosmic-200">Mass: ${this.astro.mass}</div>
          <div class="text-cosmic-200">Mode: ${this.explorationModeValue}</div>
        </div>
      </div>
    `
  }

  // Log messages to the log display
  logMessage(message) {
    if (!this.hasLogTarget) return
    
    const timestamp = new Date().toLocaleTimeString()
    const logEntry = document.createElement('div')
    logEntry.className = 'log-entry text-sm text-cosmic-300 mb-1'
    logEntry.innerHTML = `<span class="text-cosmic-500">[${timestamp}]</span> ${message}`
    
    this.logTarget.appendChild(logEntry)
    
    // Keep only last 10 log entries
    while (this.logTarget.children.length > 10) {
      this.logTarget.removeChild(this.logTarget.firstChild)
    }
    
    // Scroll to bottom
    this.logTarget.scrollTop = this.logTarget.scrollHeight
  }

  // Utility methods
  calculateDistance(pos1, pos2) {
    return Math.sqrt((pos1.x - pos2.x)**2 + (pos1.y - pos2.y)**2)
  }

  // Action methods for manual control
  setExplorationMode(event) {
    const mode = event.currentTarget.dataset.mode
    this.explorationModeValue = mode
    this.logMessage(`🔄 Exploration mode changed to: ${mode}`)
  }

  boostConsciousness() {
    this.astro.consciousness += 0.1
    this.logMessage('🧠 Consciousness boosted')
  }

  boostVortex() {
    this.astro.vortex += 0.1
    this.logMessage('🌀 Vortex field strengthened')
  }

  boostGolden() {
    this.astro.golden += 0.01
    this.logMessage('φ Golden ratio enhanced')
  }

  resetPosition() {
    this.astro.position = { x: 0, y: 0, z: 0 }
    this.astro.velocity = { x: 0, y: 0, z: 0 }
    this.logMessage('🔄 Position reset to origin')
  }

  clearLog() {
    if (this.hasLogTarget) {
      this.logTarget.innerHTML = ''
    }
  }
} 