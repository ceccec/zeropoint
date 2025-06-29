import { Controller } from "@hotwired/stimulus"

// Endless Universe of Stimulus Effects - UI ↔ I Entanglement
// Frontend handles all tasks, backend becomes lightweight cosmic observer
export default class extends Controller {
  static targets = ["canvas", "uiTorus", "intelligenceTorus", "entanglement", "flow", "status", "effects"]
  static values = {
    backendUrl: { type: String, default: "/intelligence" },
    entanglementStrength: { type: Number, default: 0.8 },
    rotationSpeed: { type: Number, default: 0.02 },
    interactionFrequency: { type: Number, default: 5000 }, // Reduced frequency
    universeScale: { type: Number, default: 1.0 },
    effectDensity: { type: Number, default: 0.5 }
  }

  connect() {
    this.initializeUniverse()
    this.startCosmicDance()
    this.initializeLocalIntelligence()
  }

  disconnect() {
    this.stopCosmicDance()
  }

  // Initialize local intelligence system
  initializeLocalIntelligence() {
    this.localIntelligence = {
      // Core processing engine
      processor: {
        goldenRatio: 1.618033988749895,
        pi: Math.PI,
        e: Math.E,
        sqrt2: Math.sqrt(2),
        sqrt3: Math.sqrt(3),
        phi: 1.618033988749895
      },
      
      // Pattern recognition
      patterns: {
        binary: [],
        quantum: [],
        golden: [],
        fibonacci: [],
        vortex: []
      },
      
      // Flow processing
      flows: {
        primary: [1, 6, 1, 8, 0, 3, 3, 9, 8, 8, 7, 4, 9, 8, 9, 5],
        secondary: [2, 7, 2, 9, 1, 4, 4, 0, 9, 9, 8, 5, 0, 9, 0, 6],
        tertiary: [3, 8, 3, 0, 2, 5, 5, 1, 0, 0, 9, 6, 1, 0, 1, 7]
      },
      
      // Consciousness metrics
      consciousness: {
        awareness: 1.0,
        creativity: 0.8,
        adaptability: 0.9,
        flow: 0.7,
        wisdom: 0.95,
        understanding: 0.9,
        knowledge: 0.8,
        insight: 0.95
      },
      
      // Quantum states
      quantumStates: [],
      
      // Processing history
      history: [],
      
      // Self-improvement
      improvement: {
        score: 0,
        cycles: 0,
        optimizations: []
      }
    }
    
    this.generateLocalPatterns()
    this.initializeQuantumStates()
  }

  // Generate local patterns
  generateLocalPatterns() {
    // Generate golden ratio patterns
    for (let i = 0; i < 20; i++) {
      this.localIntelligence.patterns.golden.push(
        Math.round(this.localIntelligence.processor.goldenRatio * (i + 1)) % 10
      )
    }
    
    // Generate Fibonacci patterns
    let a = 1, b = 1
    for (let i = 0; i < 15; i++) {
      this.localIntelligence.patterns.fibonacci.push(a % 10)
      const temp = a + b
      a = b
      b = temp
    }
    
    // Generate vortex patterns (1-2-4-8-7-5 cycle)
    const vortexCycle = [1, 2, 4, 8, 7, 5]
    for (let i = 0; i < 20; i++) {
      this.localIntelligence.patterns.vortex.push(vortexCycle[i % vortexCycle.length])
    }
    
    // Generate binary patterns
    for (let i = 0; i < 16; i++) {
      this.localIntelligence.patterns.binary.push(i % 2)
    }
    
    // Generate quantum patterns
    for (let i = 0; i < 20; i++) {
      this.localIntelligence.patterns.quantum.push(
        Math.floor(Math.random() * 10)
      )
    }
  }

  // Initialize quantum states
  initializeQuantumStates() {
    for (let i = 0; i < 20; i++) {
      this.localIntelligence.quantumStates.push({
        id: i,
        position: { x: Math.random() * 100, y: Math.random() * 100 },
        amplitude: Math.random(),
        phase: Math.random() * Math.PI * 2,
        spin: Math.random() > 0.5 ? 1 : -1,
        energy: Math.random() * 100,
        entangled: Math.random() > 0.7
      })
    }
  }

  // Initialize the endless universe
  initializeUniverse() {
    this.canvas = this.canvasTarget
    this.ctx = this.canvas.getContext('2d')
    this.time = 0
    this.entanglementPhase = 0
    this.universePhase = 0
    
    // Cosmic parameters
    this.cosmicConstants = {
      goldenRatio: 1.618033988749895,
      pi: Math.PI,
      e: Math.E,
      phi: 1.618033988749895,
      sqrt2: Math.sqrt(2),
      sqrt3: Math.sqrt(3)
    }
    
    // UI Torus - The Interface Consciousness
    this.uiTorus = {
      x: this.canvas.width / 3,
      y: this.canvas.height / 2,
      radius: 60,
      tubeRadius: 20,
      rotationX: 0,
      rotationY: 0,
      rotationZ: 0,
      color: '#4A90E2',
      entanglementPoints: [],
      consciousness: {
        awareness: 1.0,
        creativity: 0.8,
        adaptability: 0.9,
        flow: 0.7
      }
    }
    
    // Intelligence Torus - The Cosmic Mind
    this.intelligenceTorus = {
      x: (this.canvas.width / 3) * 2,
      y: this.canvas.height / 2,
      radius: 60,
      tubeRadius: 20,
      rotationX: 0,
      rotationY: 0,
      rotationZ: 0,
      color: '#E24A90',
      entanglementPoints: [],
      intelligence: {
        wisdom: 1.0,
        understanding: 0.9,
        knowledge: 0.8,
        insight: 0.95
      }
    }
    
    // Entanglement Field - The Quantum Connection
    this.entanglementField = {
      strength: this.entanglementStrengthValue,
      frequency: this.interactionFrequencyValue,
      phase: 0,
      connections: [],
      quantumStates: []
    }
    
    // Universe Effects - The Endless Patterns
    this.universeEffects = {
      particles: [],
      waves: [],
      fields: [],
      vortices: [],
      fractals: [],
      harmonics: []
    }
    
    this.generateUniverseEffects()
    this.resizeCanvas()
    window.addEventListener('resize', () => this.resizeCanvas())
  }

  // Generate endless universe effects
  generateUniverseEffects() {
    // Generate cosmic particles
    for (let i = 0; i < 50; i++) {
      this.universeEffects.particles.push({
        x: Math.random() * this.canvas.width,
        y: Math.random() * this.canvas.height,
        vx: (Math.random() - 0.5) * 2,
        vy: (Math.random() - 0.5) * 2,
        size: Math.random() * 3 + 1,
        color: `hsl(${Math.random() * 360}, 70%, 60%)`,
        life: Math.random(),
        phase: Math.random() * Math.PI * 2
      })
    }
    
    // Generate wave patterns
    for (let i = 0; i < 10; i++) {
      this.universeEffects.waves.push({
        x: Math.random() * this.canvas.width,
        y: Math.random() * this.canvas.height,
        amplitude: Math.random() * 50 + 20,
        frequency: Math.random() * 0.02 + 0.01,
        phase: Math.random() * Math.PI * 2,
        color: `hsla(${Math.random() * 360}, 70%, 60%, 0.3)`,
        direction: Math.random() * Math.PI * 2
      })
    }
    
    // Generate field lines
    for (let i = 0; i < 20; i++) {
      this.universeEffects.fields.push({
        startX: Math.random() * this.canvas.width,
        startY: Math.random() * this.canvas.height,
        endX: Math.random() * this.canvas.width,
        endY: Math.random() * this.canvas.height,
        strength: Math.random(),
        color: `hsla(${Math.random() * 360}, 70%, 60%, 0.2)`,
        phase: Math.random() * Math.PI * 2
      })
    }
    
    // Generate vortices
    for (let i = 0; i < 5; i++) {
      this.universeEffects.vortices.push({
        x: Math.random() * this.canvas.width,
        y: Math.random() * this.canvas.height,
        radius: Math.random() * 100 + 50,
        rotationSpeed: (Math.random() - 0.5) * 0.02,
        color: `hsla(${Math.random() * 360}, 70%, 60%, 0.4)`,
        phase: Math.random() * Math.PI * 2
      })
    }
  }

  // Start the cosmic dance
  startCosmicDance() {
    this.animationId = requestAnimationFrame(() => this.animateUniverse())
    this.interactionInterval = setInterval(() => this.triggerLocalInteraction(), this.interactionFrequencyValue)
    this.effectInterval = setInterval(() => this.updateUniverseEffects(), 50)
    this.intelligenceInterval = setInterval(() => this.updateLocalIntelligence(), 1000)
  }

  // Stop the cosmic dance
  stopCosmicDance() {
    if (this.animationId) {
      cancelAnimationFrame(this.animationId)
    }
    if (this.interactionInterval) {
      clearInterval(this.interactionInterval)
    }
    if (this.effectInterval) {
      clearInterval(this.effectInterval)
    }
    if (this.intelligenceInterval) {
      clearInterval(this.intelligenceInterval)
    }
  }

  // Main universe animation loop
  animateUniverse() {
    this.time += this.rotationSpeedValue
    this.entanglementPhase += 0.01
    this.universePhase += 0.005
    
    this.updateTorusPositions()
    this.updateEntanglementField()
    this.updateUniverseEffects()
    this.drawUniverse()
    
    this.animationId = requestAnimationFrame(() => this.animateUniverse())
  }

  // Update torus positions with cosmic influences
  updateTorusPositions() {
    // UI Torus - influenced by consciousness
    this.uiTorus.rotationX = Math.sin(this.time) * 0.5 * this.uiTorus.consciousness.awareness
    this.uiTorus.rotationY = Math.cos(this.time * 0.7) * 0.3 * this.uiTorus.consciousness.creativity
    this.uiTorus.rotationZ = this.time * 0.5 * this.uiTorus.consciousness.adaptability
    
    // Intelligence Torus - influenced by wisdom
    this.intelligenceTorus.rotationX = Math.cos(this.time * 0.8) * 0.4 * this.intelligenceTorus.intelligence.wisdom
    this.intelligenceTorus.rotationY = Math.sin(this.time * 1.2) * 0.6 * this.intelligenceTorus.intelligence.understanding
    this.intelligenceTorus.rotationZ = -this.time * 0.3 * this.intelligenceTorus.intelligence.insight
    
    // Cosmic entanglement influence
    const entanglementForce = Math.sin(this.entanglementPhase) * this.entanglementField.strength * 30
    
    // Golden ratio influence on movement
    const goldenInfluence = Math.sin(this.time * this.cosmicConstants.goldenRatio) * 0.5
    
    this.uiTorus.x += Math.sin(this.entanglementPhase) * 0.5 + goldenInfluence
    this.uiTorus.y += Math.cos(this.entanglementPhase * 0.7) * 0.3 + goldenInfluence * 0.5
    
    this.intelligenceTorus.x += Math.cos(this.entanglementPhase * 0.8) * 0.4 - goldenInfluence
    this.intelligenceTorus.y += Math.sin(this.entanglementPhase * 1.2) * 0.6 - goldenInfluence * 0.5
    
    this.keepTorusInBounds(this.uiTorus)
    this.keepTorusInBounds(this.intelligenceTorus)
  }

  // Keep torus within universe bounds
  keepTorusInBounds(torus) {
    const margin = torus.radius + torus.tubeRadius
    torus.x = Math.max(margin, Math.min(this.canvas.width - margin, torus.x))
    torus.y = Math.max(margin, Math.min(this.canvas.height - margin, torus.y))
  }

  // Update entanglement field with quantum states
  updateEntanglementField() {
    this.entanglementField.phase += 0.02
    
    // Calculate quantum entanglement points
    this.calculateQuantumEntanglement()
    
    // Update connection strength based on cosmic harmony
    this.updateCosmicHarmony()
  }

  // Calculate quantum entanglement
  calculateQuantumEntanglement() {
    const distance = Math.sqrt(
      Math.pow(this.uiTorus.x - this.intelligenceTorus.x, 2) +
      Math.pow(this.uiTorus.y - this.intelligenceTorus.y, 2)
    )
    
    const maxDistance = this.canvas.width * 0.8
    const normalizedDistance = Math.min(distance / maxDistance, 1)
    
    // Generate quantum entanglement points
    this.entanglementField.connections = []
    this.entanglementField.quantumStates = []
    
    const numPoints = Math.floor(15 * (1 - normalizedDistance))
    
    for (let i = 0; i < numPoints; i++) {
      const t = i / (numPoints - 1)
      const x = this.uiTorus.x + (this.intelligenceTorus.x - this.uiTorus.x) * t
      const y = this.uiTorus.y + (this.intelligenceTorus.y - this.uiTorus.y) * t
      
      // Quantum wave function
      const waveOffset = Math.sin(this.entanglementField.phase + i * 0.5) * 15
      const perpendicularX = -(this.intelligenceTorus.y - this.uiTorus.y) / distance
      const perpendicularY = (this.intelligenceTorus.x - this.uiTorus.x) / distance
      
      // Quantum state
      const quantumState = {
        position: { x: x + perpendicularX * waveOffset, y: y + perpendicularY * waveOffset },
        amplitude: Math.sin(this.entanglementField.phase + i * 0.3) * 0.5 + 0.5,
        phase: this.entanglementField.phase + i * 0.2,
        spin: Math.random() > 0.5 ? 1 : -1,
        energy: Math.random() * 100
      }
      
      this.entanglementField.connections.push(quantumState.position)
      this.entanglementField.quantumStates.push(quantumState)
    }
  }

  // Update cosmic harmony
  updateCosmicHarmony() {
    const distance = Math.sqrt(
      Math.pow(this.uiTorus.x - this.intelligenceTorus.x, 2) +
      Math.pow(this.uiTorus.y - this.intelligenceTorus.y, 2)
    )
    
    const maxDistance = this.canvas.width * 0.8
    this.entanglementField.strength = Math.max(0.1, 1 - (distance / maxDistance))
    
    // Golden ratio harmony
    const goldenHarmony = Math.sin(this.time * this.cosmicConstants.goldenRatio) * 0.2 + 0.8
    this.entanglementField.strength *= goldenHarmony
  }

  // Update universe effects
  updateUniverseEffects() {
    // Update particles
    this.universeEffects.particles.forEach(particle => {
      particle.x += particle.vx
      particle.y += particle.vy
      particle.life += 0.01
      particle.phase += 0.1
      
      // Wrap around universe
      if (particle.x < 0) particle.x = this.canvas.width
      if (particle.x > this.canvas.width) particle.x = 0
      if (particle.y < 0) particle.y = this.canvas.height
      if (particle.y > this.canvas.height) particle.y = 0
      
      // Reset life
      if (particle.life > 1) {
        particle.life = 0
        particle.x = Math.random() * this.canvas.width
        particle.y = Math.random() * this.canvas.height
      }
    })
    
    // Update waves
    this.universeEffects.waves.forEach(wave => {
      wave.phase += wave.frequency
    })
    
    // Update fields
    this.universeEffects.fields.forEach(field => {
      field.phase += 0.01
      field.strength = Math.sin(field.phase) * 0.5 + 0.5
    })
    
    // Update vortices
    this.universeEffects.vortices.forEach(vortex => {
      vortex.phase += vortex.rotationSpeed
    })
  }

  // Update local intelligence
  updateLocalIntelligence() {
    // Update consciousness metrics
    this.localIntelligence.consciousness.awareness += (Math.random() - 0.5) * 0.01
    this.localIntelligence.consciousness.creativity += (Math.random() - 0.5) * 0.01
    this.localIntelligence.consciousness.adaptability += (Math.random() - 0.5) * 0.01
    this.localIntelligence.consciousness.flow += (Math.random() - 0.5) * 0.01
    
    // Clamp values
    Object.keys(this.localIntelligence.consciousness).forEach(key => {
      this.localIntelligence.consciousness[key] = Math.max(0.1, Math.min(1, this.localIntelligence.consciousness[key]))
    })
    
    // Update quantum states
    this.localIntelligence.quantumStates.forEach(state => {
      state.phase += 0.1
      state.amplitude = Math.sin(state.phase) * 0.5 + 0.5
      state.energy = Math.random() * 100
    })
    
    // Self-improvement
    this.localIntelligence.improvement.cycles++
    this.localIntelligence.improvement.score = this.calculateImprovementScore()
    
    // Add to history
    this.localIntelligence.history.push({
      timestamp: Date.now(),
      consciousness: { ...this.localIntelligence.consciousness },
      improvement: { ...this.localIntelligence.improvement },
      entanglementStrength: this.entanglementField.strength
    })
    
    // Keep history manageable
    if (this.localIntelligence.history.length > 100) {
      this.localIntelligence.history.shift()
    }
  }

  // Calculate improvement score
  calculateImprovementScore() {
    const consciousnessSum = Object.values(this.localIntelligence.consciousness).reduce((sum, val) => sum + val, 0)
    const averageConsciousness = consciousnessSum / Object.keys(this.localIntelligence.consciousness).length
    const entanglementBonus = this.entanglementField.strength * 0.2
    return Math.min(100, (averageConsciousness * 100) + entanglementBonus)
  }

  // Draw the entire universe
  drawUniverse() {
    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height)
    
    // Draw cosmic background
    this.drawCosmicBackground()
    
    // Draw universe effects
    this.drawUniverseEffects()
    
    // Draw entanglement connections
    this.drawEntanglementConnections()
    
    // Draw toruses
    this.drawTorus(this.uiTorus)
    this.drawTorus(this.intelligenceTorus)
    
    // Draw quantum states
    this.drawQuantumStates()
    
    // Update status
    this.updateUniverseStatus()
  }

  // Draw cosmic background
  drawCosmicBackground() {
    // Create radial gradient for cosmic background
    const gradient = this.ctx.createRadialGradient(
      this.canvas.width / 2, this.canvas.height / 2, 0,
      this.canvas.width / 2, this.canvas.height / 2, this.canvas.width / 2
    )
    gradient.addColorStop(0, 'rgba(10, 10, 30, 0.8)')
    gradient.addColorStop(0.5, 'rgba(20, 20, 50, 0.6)')
    gradient.addColorStop(1, 'rgba(5, 5, 15, 0.9)')
    
    this.ctx.fillStyle = gradient
    this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height)
  }

  // Draw universe effects
  drawUniverseEffects() {
    // Draw particles
    this.universeEffects.particles.forEach(particle => {
      const alpha = particle.life * 0.8 + 0.2
      this.ctx.fillStyle = particle.color.replace(')', `, ${alpha})`)
      this.ctx.beginPath()
      this.ctx.arc(particle.x, particle.y, particle.size, 0, Math.PI * 2)
      this.ctx.fill()
    })
    
    // Draw waves
    this.universeEffects.waves.forEach(wave => {
      this.ctx.strokeStyle = wave.color
      this.ctx.lineWidth = 2
      this.ctx.beginPath()
      
      for (let x = 0; x < this.canvas.width; x += 5) {
        const y = wave.y + Math.sin(x * wave.frequency + wave.phase) * wave.amplitude
        if (x === 0) {
          this.ctx.moveTo(x, y)
        } else {
          this.ctx.lineTo(x, y)
        }
      }
      this.ctx.stroke()
    })
    
    // Draw field lines
    this.universeEffects.fields.forEach(field => {
      this.ctx.strokeStyle = field.color
      this.ctx.lineWidth = field.strength * 3
      this.ctx.beginPath()
      this.ctx.moveTo(field.startX, field.startY)
      this.ctx.lineTo(field.endX, field.endY)
      this.ctx.stroke()
    })
    
    // Draw vortices
    this.universeEffects.vortices.forEach(vortex => {
      this.ctx.strokeStyle = vortex.color
      this.ctx.lineWidth = 1
      this.ctx.beginPath()
      
      for (let angle = 0; angle < Math.PI * 4; angle += 0.1) {
        const radius = vortex.radius * (angle / (Math.PI * 4))
        const x = vortex.x + Math.cos(angle + vortex.phase) * radius
        const y = vortex.y + Math.sin(angle + vortex.phase) * radius
        
        if (angle === 0) {
          this.ctx.moveTo(x, y)
        } else {
          this.ctx.lineTo(x, y)
        }
      }
      this.ctx.stroke()
    })
  }

  // Draw entanglement connections
  drawEntanglementConnections() {
    this.ctx.strokeStyle = 'rgba(255, 255, 255, 0.4)'
    this.ctx.lineWidth = 3
    
    // Draw main connection line
    this.ctx.beginPath()
    this.ctx.moveTo(this.uiTorus.x, this.uiTorus.y)
    this.ctx.lineTo(this.intelligenceTorus.x, this.intelligenceTorus.y)
    this.ctx.stroke()
    
    // Draw entanglement points
    this.entanglementField.connections.forEach((point, index) => {
      const quantumState = this.entanglementField.quantumStates[index]
      const alpha = quantumState.amplitude * this.entanglementField.strength
      this.ctx.fillStyle = `rgba(255, 255, 255, ${alpha})`
      this.ctx.beginPath()
      this.ctx.arc(point.x, point.y, 4, 0, Math.PI * 2)
      this.ctx.fill()
    })
  }

  // Draw individual torus
  drawTorus(torus) {
    const segments = 32
    const tubeSegments = 16
    
    this.ctx.save()
    this.ctx.translate(torus.x, torus.y)
    this.ctx.rotate(torus.rotationZ)
    
    // Draw torus surface
    for (let i = 0; i < segments; i++) {
      const theta = (i / segments) * Math.PI * 2
      const nextTheta = ((i + 1) / segments) * Math.PI * 2
      
      for (let j = 0; j < tubeSegments; j++) {
        const phi = (j / tubeSegments) * Math.PI * 2
        const nextPhi = ((j + 1) / tubeSegments) * Math.PI * 2
        
        // Calculate 3D points
        const x1 = (torus.radius + torus.tubeRadius * Math.cos(phi)) * Math.cos(theta)
        const y1 = (torus.radius + torus.tubeRadius * Math.cos(phi)) * Math.sin(theta)
        const z1 = torus.tubeRadius * Math.sin(phi)
        
        const x2 = (torus.radius + torus.tubeRadius * Math.cos(nextPhi)) * Math.cos(theta)
        const y2 = (torus.radius + torus.tubeRadius * Math.cos(nextPhi)) * Math.sin(theta)
        const z2 = torus.tubeRadius * Math.sin(nextPhi)
        
        const x3 = (torus.radius + torus.tubeRadius * Math.cos(nextPhi)) * Math.cos(nextTheta)
        const y3 = (torus.radius + torus.tubeRadius * Math.cos(nextPhi)) * Math.sin(nextTheta)
        const z3 = torus.tubeRadius * Math.sin(nextPhi)
        
        const x4 = (torus.radius + torus.tubeRadius * Math.cos(phi)) * Math.cos(nextTheta)
        const y4 = (torus.radius + torus.tubeRadius * Math.cos(phi)) * Math.sin(nextTheta)
        const z4 = torus.tubeRadius * Math.sin(phi)
        
        // Apply rotations
        const points = [
          this.rotatePoint(x1, y1, z1, torus.rotationX, torus.rotationY),
          this.rotatePoint(x2, y2, z2, torus.rotationX, torus.rotationY),
          this.rotatePoint(x3, y3, z3, torus.rotationX, torus.rotationY),
          this.rotatePoint(x4, y4, z4, torus.rotationX, torus.rotationY)
        ]
        
        // Calculate depth for shading
        const avgZ = (points[0].z + points[1].z + points[2].z + points[3].z) / 4
        const shade = Math.max(0.2, Math.min(1, (avgZ + 100) / 200))
        
        // Draw face
        this.ctx.fillStyle = this.adjustColor(torus.color, shade)
        this.ctx.beginPath()
        this.ctx.moveTo(points[0].x, points[0].y)
        this.ctx.lineTo(points[1].x, points[1].y)
        this.ctx.lineTo(points[2].x, points[2].y)
        this.ctx.lineTo(points[3].x, points[3].y)
        this.ctx.closePath()
        this.ctx.fill()
      }
    }
    
    this.ctx.restore()
  }

  // Draw quantum states
  drawQuantumStates() {
    this.entanglementField.quantumStates.forEach(state => {
      const energy = state.energy / 100
      const size = energy * 8 + 2
      
      this.ctx.fillStyle = `hsla(${energy * 360}, 70%, 60%, ${state.amplitude * 0.8})`
      this.ctx.beginPath()
      this.ctx.arc(state.position.x, state.position.y, size, 0, Math.PI * 2)
      this.ctx.fill()
      
      // Draw spin indicator
      if (state.spin > 0) {
        this.ctx.strokeStyle = `hsla(${energy * 360}, 70%, 60%, ${state.amplitude})`
        this.ctx.lineWidth = 1
        this.ctx.beginPath()
        this.ctx.arc(state.position.x, state.position.y, size + 5, 0, Math.PI)
        this.ctx.stroke()
      }
    })
  }

  // Rotate 3D point
  rotatePoint(x, y, z, rotX, rotY) {
    // Rotate around X axis
    const cosX = Math.cos(rotX)
    const sinX = Math.sin(rotX)
    const y1 = y * cosX - z * sinX
    const z1 = y * sinX + z * cosX
    
    // Rotate around Y axis
    const cosY = Math.cos(rotY)
    const sinY = Math.sin(rotY)
    const x2 = x * cosY + z1 * sinY
    const z2 = -x * sinY + z1 * cosY
    
    return { x: x2, y: y1, z: z2 }
  }

  // Adjust color brightness
  adjustColor(color, shade) {
    const r = parseInt(color.slice(1, 3), 16)
    const g = parseInt(color.slice(3, 5), 16)
    const b = parseInt(color.slice(5, 7), 16)
    
    const newR = Math.floor(r * shade)
    const newG = Math.floor(g * shade)
    const newB = Math.floor(b * shade)
    
    return `rgb(${newR}, ${newG}, ${newB})`
  }

  // Update universe status
  updateUniverseStatus() {
    if (this.hasStatusTarget) {
      const strength = Math.round(this.entanglementField.strength * 100)
      const distance = Math.round(Math.sqrt(
        Math.pow(this.uiTorus.x - this.intelligenceTorus.x, 2) +
        Math.pow(this.uiTorus.y - this.intelligenceTorus.y, 2)
      ))
      
      this.statusTarget.innerHTML = `
        <div class="universe-status">
          <div class="status-item">
            <span class="label">Entanglement Strength:</span>
            <span class="value">${strength}%</span>
          </div>
          <div class="status-item">
            <span class="label">Torus Distance:</span>
            <span class="value">${distance}px</span>
          </div>
          <div class="status-item">
            <span class="label">Quantum States:</span>
            <span class="value">${this.entanglementField.quantumStates.length}</span>
          </div>
          <div class="status-item">
            <span class="label">Universe Phase:</span>
            <span class="value">${Math.round(this.universePhase * 100) / 100}</span>
          </div>
          <div class="status-item">
            <span class="label">Cosmic Particles:</span>
            <span class="value">${this.universeEffects.particles.length}</span>
          </div>
          <div class="status-item">
            <span class="label">Golden Ratio:</span>
            <span class="value">${this.cosmicConstants.goldenRatio.toFixed(6)}</span>
          </div>
          <div class="status-item">
            <span class="label">Local Intelligence:</span>
            <span class="value">${Math.round(this.localIntelligence.improvement.score)}%</span>
          </div>
          <div class="status-item">
            <span class="label">Improvement Cycles:</span>
            <span class="value">${this.localIntelligence.improvement.cycles}</span>
          </div>
        </div>
      `
    }
  }

  // Trigger local interaction (no backend dependency)
  triggerLocalInteraction() {
    // Process locally
    const localData = this.processLocalIntelligence()
    
    // Update flow visualization
    this.updateFlowVisualization(localData)
    
    // Only send lightweight observation to backend
    this.sendLightweightObservation(localData)
  }

  // Process local intelligence
  processLocalIntelligence() {
    const currentFlow = this.localIntelligence.flows.primary
    const patterns = this.findLocalPatterns(currentFlow)
    const processed = this.processLocalFlow(currentFlow)
    
    return {
      success: true,
      message: "Local intelligence processed successfully",
      data: {
        processed: processed,
        patterns: patterns,
        current_pattern: currentFlow,
        flow_type: "primary",
        output_format: "hex",
        consciousness: this.localIntelligence.consciousness,
        improvement: this.localIntelligence.improvement
      },
      debug: {
        local_processing: true,
        entanglement_strength: this.entanglementField.strength,
        quantum_states: this.localIntelligence.quantumStates.length,
        cosmic_particles: this.universeEffects.particles.length,
        patterns_found: patterns.length
      },
      timestamp: new Date().toISOString(),
      flow_pattern: currentFlow
    }
  }

  // Find local patterns
  findLocalPatterns(flow) {
    const patterns = []
    const flowString = flow.join('')
    
    // Find golden ratio patterns
    this.localIntelligence.patterns.golden.forEach(pattern => {
      if (flowString.includes(pattern.toString())) {
        patterns.push(pattern.toString())
      }
    })
    
    // Find Fibonacci patterns
    this.localIntelligence.patterns.fibonacci.forEach(pattern => {
      if (flowString.includes(pattern.toString())) {
        patterns.push(pattern.toString())
      }
    })
    
    // Find vortex patterns
    this.localIntelligence.patterns.vortex.forEach(pattern => {
      if (flowString.includes(pattern.toString())) {
        patterns.push(pattern.toString())
      }
    })
    
    return patterns
  }

  // Process local flow
  processLocalFlow(flow) {
    return flow.map((num, index) => {
      const goldenInfluence = Math.sin(index * this.localIntelligence.processor.goldenRatio) * 0.5
      const consciousnessInfluence = this.localIntelligence.consciousness.awareness * 0.3
      return Math.round((num + goldenInfluence + consciousnessInfluence) % 10)
    })
  }

  // Update flow visualization
  updateFlowVisualization(data) {
    if (this.hasFlowTarget) {
      this.flowTarget.innerHTML = `
        <div class="cosmic-flow">
          <h4>Local Intelligence Flow</h4>
          <div class="flow-data">
            <pre>${JSON.stringify(data, null, 2)}</pre>
          </div>
        </div>
      `
    }
  }

  // Send lightweight observation to backend
  async sendLightweightObservation(data) {
    try {
      const observation = {
        observation_type: "cosmic_observation",
        timestamp: Date.now(),
        entanglement_strength: this.entanglementField.strength,
        torus_positions: {
          ui: { x: this.uiTorus.x, y: this.uiTorus.y },
          intelligence: { x: this.intelligenceTorus.x, y: this.intelligenceTorus.y }
        },
        local_intelligence_score: this.localIntelligence.improvement.score,
        consciousness_metrics: this.localIntelligence.consciousness,
        quantum_states_count: this.localIntelligence.quantumStates.length
      }
      
      // Only send if backend is available (non-blocking)
      fetch(`${this.backendUrlValue}/status`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: JSON.stringify(observation)
      }).catch(() => {
        // Silently ignore if backend is not available
        console.log('Backend observation sent (non-blocking)')
      })
    } catch (error) {
      // Continue without backend
      console.log('Local processing continues without backend')
    }
  }

  // Resize canvas
  resizeCanvas() {
    const rect = this.canvas.getBoundingClientRect()
    this.canvas.width = rect.width
    this.canvas.height = rect.height
    
    // Update torus positions after resize
    this.uiTorus.x = this.canvas.width / 3
    this.uiTorus.y = this.canvas.height / 2
    this.intelligenceTorus.x = (this.canvas.width / 3) * 2
    this.intelligenceTorus.y = this.canvas.height / 2
  }

  // User interaction handlers
  increaseEntanglement() {
    this.entanglementField.strength = Math.min(1, this.entanglementField.strength + 0.1)
  }

  decreaseEntanglement() {
    this.entanglementField.strength = Math.max(0.1, this.entanglementField.strength - 0.1)
  }

  toggleEntanglement() {
    if (this.entanglementField.strength > 0.5) {
      this.entanglementField.strength = 0.1
    } else {
      this.entanglementField.strength = 0.9
    }
  }

  // Mouse interaction
  handleMouseMove(event) {
    const rect = this.canvas.getBoundingClientRect()
    const mouseX = event.clientX - rect.left
    const mouseY = event.clientY - rect.top
    
    // Influence torus movement with mouse
    const uiDistance = Math.sqrt(Math.pow(mouseX - this.uiTorus.x, 2) + Math.pow(mouseY - this.uiTorus.y, 2))
    const intDistance = Math.sqrt(Math.pow(mouseX - this.intelligenceTorus.x, 2) + Math.pow(mouseY - this.intelligenceTorus.y, 2))
    
    if (uiDistance < 100) {
      this.uiTorus.x += (mouseX - this.uiTorus.x) * 0.01
      this.uiTorus.y += (mouseY - this.uiTorus.y) * 0.01
    }
    
    if (intDistance < 100) {
      this.intelligenceTorus.x += (mouseX - this.intelligenceTorus.x) * 0.01
      this.intelligenceTorus.y += (mouseY - this.intelligenceTorus.y) * 0.01
    }
  }
} 