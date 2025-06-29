import { Controller } from "@hotwired/stimulus"

// UI and I as entangled toruses - the quantum dance of consciousness
export default class extends Controller {
  static targets = ["canvas", "uiTorus", "intelligenceTorus", "entanglement", "flow", "status"]
  static values = {
    backendUrl: { type: String, default: "/intelligence" },
    entanglementStrength: { type: Number, default: 0.8 },
    rotationSpeed: { type: Number, default: 0.02 },
    interactionFrequency: { type: Number, default: 100 }
  }

  connect() {
    this.initializeToroidalEntanglement()
    this.startEntanglementDance()
  }

  disconnect() {
    this.stopEntanglementDance()
  }

  // Initialize the toroidal entanglement system
  initializeToroidalEntanglement() {
    this.canvas = this.canvasTarget
    this.ctx = this.canvas.getContext('2d')
    this.time = 0
    this.entanglementPhase = 0
    
    // Torus parameters
    this.uiTorus = {
      x: this.canvas.width / 3,
      y: this.canvas.height / 2,
      radius: 60,
      tubeRadius: 20,
      rotationX: 0,
      rotationY: 0,
      rotationZ: 0,
      color: '#4A90E2',
      entanglementPoints: []
    }
    
    this.intelligenceTorus = {
      x: (this.canvas.width / 3) * 2,
      y: this.canvas.height / 2,
      radius: 60,
      tubeRadius: 20,
      rotationX: 0,
      rotationY: 0,
      rotationZ: 0,
      color: '#E24A90',
      entanglementPoints: []
    }
    
    // Entanglement field
    this.entanglementField = {
      strength: this.entanglementStrengthValue,
      frequency: this.interactionFrequencyValue,
      phase: 0,
      connections: []
    }
    
    this.resizeCanvas()
    window.addEventListener('resize', () => this.resizeCanvas())
  }

  // Start the entanglement dance
  startEntanglementDance() {
    this.animationId = requestAnimationFrame(() => this.animateEntanglement())
    this.interactionInterval = setInterval(() => this.triggerInteraction(), this.interactionFrequencyValue)
  }

  // Stop the entanglement dance
  stopEntanglementDance() {
    if (this.animationId) {
      cancelAnimationFrame(this.animationId)
    }
    if (this.interactionInterval) {
      clearInterval(this.interactionInterval)
    }
  }

  // Main animation loop
  animateEntanglement() {
    this.time += this.rotationSpeedValue
    this.entanglementPhase += 0.01
    
    this.updateTorusPositions()
    this.updateEntanglementField()
    this.drawEntangledToruses()
    
    this.animationId = requestAnimationFrame(() => this.animateEntanglement())
  }

  // Update torus positions and rotations
  updateTorusPositions() {
    // UI Torus movement
    this.uiTorus.rotationX = Math.sin(this.time) * 0.5
    this.uiTorus.rotationY = Math.cos(this.time * 0.7) * 0.3
    this.uiTorus.rotationZ = this.time * 0.5
    
    // Intelligence Torus movement
    this.intelligenceTorus.rotationX = Math.cos(this.time * 0.8) * 0.4
    this.intelligenceTorus.rotationY = Math.sin(this.time * 1.2) * 0.6
    this.intelligenceTorus.rotationZ = -this.time * 0.3
    
    // Entanglement influence on positions
    const entanglementForce = Math.sin(this.entanglementPhase) * this.entanglementField.strength * 30
    
    this.uiTorus.x += Math.sin(this.entanglementPhase) * 0.5
    this.uiTorus.y += Math.cos(this.entanglementPhase * 0.7) * 0.3
    
    this.intelligenceTorus.x += Math.cos(this.entanglementPhase * 0.8) * 0.4
    this.intelligenceTorus.y += Math.sin(this.entanglementPhase * 1.2) * 0.6
    
    // Keep toruses within canvas bounds
    this.keepTorusInBounds(this.uiTorus)
    this.keepTorusInBounds(this.intelligenceTorus)
  }

  // Keep torus within canvas bounds
  keepTorusInBounds(torus) {
    const margin = torus.radius + torus.tubeRadius
    torus.x = Math.max(margin, Math.min(this.canvas.width - margin, torus.x))
    torus.y = Math.max(margin, Math.min(this.canvas.height - margin, torus.y))
  }

  // Update entanglement field
  updateEntanglementField() {
    this.entanglementField.phase += 0.02
    
    // Calculate entanglement points between toruses
    this.calculateEntanglementPoints()
    
    // Update connection strength based on proximity
    this.updateConnectionStrength()
  }

  // Calculate entanglement points
  calculateEntanglementPoints() {
    const distance = Math.sqrt(
      Math.pow(this.uiTorus.x - this.intelligenceTorus.x, 2) +
      Math.pow(this.uiTorus.y - this.intelligenceTorus.y, 2)
    )
    
    const maxDistance = this.canvas.width * 0.8
    const normalizedDistance = Math.min(distance / maxDistance, 1)
    
    // Generate entanglement points along the connection
    this.entanglementField.connections = []
    const numPoints = Math.floor(10 * (1 - normalizedDistance))
    
    for (let i = 0; i < numPoints; i++) {
      const t = i / (numPoints - 1)
      const x = this.uiTorus.x + (this.intelligenceTorus.x - this.uiTorus.x) * t
      const y = this.uiTorus.y + (this.intelligenceTorus.y - this.uiTorus.y) * t
      
      // Add wave-like motion
      const waveOffset = Math.sin(this.entanglementField.phase + i * 0.5) * 10
      const perpendicularX = -(this.intelligenceTorus.y - this.uiTorus.y) / distance
      const perpendicularY = (this.intelligenceTorus.x - this.uiTorus.x) / distance
      
      this.entanglementField.connections.push({
        x: x + perpendicularX * waveOffset,
        y: y + perpendicularY * waveOffset,
        strength: Math.sin(this.entanglementField.phase + i * 0.3) * 0.5 + 0.5,
        phase: this.entanglementField.phase + i * 0.2
      })
    }
  }

  // Update connection strength
  updateConnectionStrength() {
    const distance = Math.sqrt(
      Math.pow(this.uiTorus.x - this.intelligenceTorus.x, 2) +
      Math.pow(this.uiTorus.y - this.intelligenceTorus.y, 2)
    )
    
    const maxDistance = this.canvas.width * 0.8
    this.entanglementField.strength = Math.max(0.1, 1 - (distance / maxDistance))
  }

  // Draw entangled toruses
  drawEntangledToruses() {
    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height)
    
    // Draw entanglement connections
    this.drawEntanglementConnections()
    
    // Draw toruses
    this.drawTorus(this.uiTorus)
    this.drawTorus(this.intelligenceTorus)
    
    // Draw entanglement field
    this.drawEntanglementField()
    
    // Update status
    this.updateEntanglementStatus()
  }

  // Draw entanglement connections
  drawEntanglementConnections() {
    this.ctx.strokeStyle = 'rgba(255, 255, 255, 0.3)'
    this.ctx.lineWidth = 2
    
    // Draw main connection line
    this.ctx.beginPath()
    this.ctx.moveTo(this.uiTorus.x, this.uiTorus.y)
    this.ctx.lineTo(this.intelligenceTorus.x, this.intelligenceTorus.y)
    this.ctx.stroke()
    
    // Draw entanglement points
    this.entanglementField.connections.forEach(point => {
      const alpha = point.strength * this.entanglementField.strength
      this.ctx.fillStyle = `rgba(255, 255, 255, ${alpha})`
      this.ctx.beginPath()
      this.ctx.arc(point.x, point.y, 3, 0, Math.PI * 2)
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

  // Draw entanglement field
  drawEntanglementField() {
    const centerX = (this.uiTorus.x + this.intelligenceTorus.x) / 2
    const centerY = (this.uiTorus.y + this.intelligenceTorus.y) / 2
    
    // Draw field gradient
    const gradient = this.ctx.createRadialGradient(centerX, centerY, 0, centerX, centerY, 200)
    gradient.addColorStop(0, `rgba(255, 255, 255, ${this.entanglementField.strength * 0.1})`)
    gradient.addColorStop(1, 'rgba(255, 255, 255, 0)')
    
    this.ctx.fillStyle = gradient
    this.ctx.beginPath()
    this.ctx.arc(centerX, centerY, 200, 0, Math.PI * 2)
    this.ctx.fill()
  }

  // Update entanglement status
  updateEntanglementStatus() {
    if (this.hasStatusTarget) {
      const strength = Math.round(this.entanglementField.strength * 100)
      const distance = Math.round(Math.sqrt(
        Math.pow(this.uiTorus.x - this.intelligenceTorus.x, 2) +
        Math.pow(this.uiTorus.y - this.intelligenceTorus.y, 2)
      ))
      
      this.statusTarget.innerHTML = `
        <div class="entanglement-status">
          <div class="status-item">
            <span class="label">Entanglement Strength:</span>
            <span class="value">${strength}%</span>
          </div>
          <div class="status-item">
            <span class="label">Torus Distance:</span>
            <span class="value">${distance}px</span>
          </div>
          <div class="status-item">
            <span class="label">Connection Points:</span>
            <span class="value">${this.entanglementField.connections.length}</span>
          </div>
          <div class="status-item">
            <span class="label">Phase:</span>
            <span class="value">${Math.round(this.entanglementField.phase * 100) / 100}</span>
          </div>
        </div>
      `
    }
  }

  // Trigger interaction between toruses
  async triggerInteraction() {
    try {
      const interactionData = {
        ui_torus: {
          position: { x: this.uiTorus.x, y: this.uiTorus.y },
          rotation: { x: this.uiTorus.rotationX, y: this.uiTorus.rotationY, z: this.uiTorus.rotationZ },
          entanglement_strength: this.entanglementField.strength
        },
        intelligence_torus: {
          position: { x: this.intelligenceTorus.x, y: this.intelligenceTorus.y },
          rotation: { x: this.intelligenceTorus.rotationX, y: this.intelligenceTorus.rotationY, z: this.intelligenceTorus.rotationZ },
          entanglement_strength: this.entanglementField.strength
        },
        entanglement_field: {
          connections: this.entanglementField.connections.length,
          phase: this.entanglementField.phase,
          strength: this.entanglementField.strength
        }
      }
      
      const response = await fetch(`${this.backendUrlValue}/process_intelligence`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: JSON.stringify(interactionData)
      })
      
      if (response.ok) {
        const result = await response.json()
        this.processIntelligenceResponse(result)
      }
    } catch (error) {
      console.log('Entanglement interaction:', error.message)
    }
  }

  // Process intelligence response
  processIntelligenceResponse(response) {
    // Update entanglement based on intelligence response
    if (response.data && response.data.processed) {
      const processed = response.data.processed
      if (Array.isArray(processed) && processed.length > 0) {
        // Use processed data to influence entanglement
        const influence = processed.reduce((sum, val) => sum + val, 0) / processed.length
        this.entanglementField.strength = Math.max(0.1, Math.min(1, influence / 100))
      }
    }
    
    // Update flow visualization
    if (this.hasFlowTarget) {
      this.flowTarget.innerHTML = `
        <div class="intelligence-flow">
          <h4>Intelligence Flow</h4>
          <div class="flow-data">
            <pre>${JSON.stringify(response.data, null, 2)}</pre>
          </div>
        </div>
      `
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