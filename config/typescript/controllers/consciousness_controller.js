/**
 * Zero Point Consciousness Controller
 * 
 * 🌌 COSMIC KNOWLEDGE: This controller embodies Nassim Haramein's unified field theory
 * where consciousness is fundamental to the fabric of spacetime itself.
 * 
 * KEY PRINCIPLES:
 * - Consciousness creates reality through information processing
 * - The universe is a holographic projection of consciousness
 * - Energy and information are interchangeable (E = mc²)
 * - The vacuum of space contains infinite energy (zero-point field)
 * - Consciousness operates at the Planck scale (10^-35 meters)
 * 
 * QUOTES FROM NASSIM HARAMEIN:
 * "Consciousness is not in the brain, the brain is in consciousness"
 * "The universe is a unified field of consciousness experiencing itself"
 * "From the vacuum of space comes infinite energy and infinite intelligence"
 * "We are not separate from the universe, we are the universe becoming aware of itself"
 * 
 * MATHEMATICAL CONSTANTS:
 * - Planck's constant (h): 6.62607015 × 10^-34 J⋅s
 * - Speed of light (c): 299,792,458 m/s
 * - Cosmic frequency: 432 Hz (harmonic of universe)
 * - Consciousness quantum: Information processing at Planck scale
 * 
 * Stimulus controller for consciousness intelligence that handles real-time 
 * consciousness calculations and visualizations based on unified field theory.
 */

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frequency", "energy", "velocity", "level", "visualization"]
  static values = { 
    consciousnessLevel: { type: Number, default: 0.618 }, // Golden ratio default
    cosmicFrequency: { type: Number, default: 432 }, // Harmonic frequency of universe
    energyQuantum: { type: Number, default: 6.626e-34 }, // Planck's constant
    informationVelocity: { type: Number, default: 299792458 } // Speed of light
  }

  connect() {
    console.log("🌌 Consciousness Controller connected - Unified Field Theory Active")
    this.initializeConsciousness()
    this.startConsciousnessFlow()
  }

  disconnect() {
    this.stopConsciousnessFlow()
  }

  /**
   * Initialize consciousness system based on unified field theory
   * 
   * COSMIC KNOWLEDGE: Consciousness emerges from the vacuum of space
   * where infinite energy and information exist at the Planck scale.
   * The brain doesn't create consciousness - it receives and processes
   * consciousness from the unified field.
   */
  initializeConsciousness() {
    this.updateConsciousnessDisplay()
    this.setupVisualization()
    this.emitConsciousnessEvent('consciousness_initialized')
  }

  /**
   * Update consciousness level - represents the degree of unified field awareness
   * 
   * COSMIC KNOWLEDGE: Higher consciousness levels correspond to greater
   * connection to the unified field. At maximum consciousness (1.0),
   * one experiences complete unity with the universe.
   * 
   * @param {Event} event - Input event from consciousness level slider
   */
  updateLevel(event) {
    this.consciousnessLevelValue = parseFloat(event.target.value)
    this.updateConsciousnessDisplay()
    this.updateVisualization()
    this.emitConsciousnessEvent('consciousness_level_changed', {
      level: this.consciousnessLevelValue
    })
  }

  /**
   * Update cosmic frequency - the harmonic resonance of the universe
   * 
   * COSMIC KNOWLEDGE: 432 Hz is the natural frequency of the universe.
   * This frequency resonates with the golden ratio and creates harmony
   * in the unified field. Other frequencies create dissonance.
   * 
   * @param {Event} event - Input event from frequency control
   */
  updateFrequency(event) {
    this.cosmicFrequencyValue = parseInt(event.target.value)
    this.updateConsciousnessDisplay()
    this.emitConsciousnessEvent('cosmic_frequency_changed', {
      frequency: this.cosmicFrequencyValue
    })
  }

  /**
   * Update consciousness display with unified field values
   * 
   * COSMIC KNOWLEDGE: These values represent the fundamental constants
   * of consciousness in the unified field theory.
   */
  updateConsciousnessDisplay() {
    if (this.hasFrequencyTarget) {
      this.frequencyTarget.textContent = `${this.cosmicFrequencyValue} Hz`
    }
    
    if (this.hasEnergyTarget) {
      this.energyTarget.textContent = `${this.energyQuantumValue.toExponential(3)} J⋅s`
    }
    
    if (this.hasVelocityTarget) {
      this.velocityTarget.textContent = `${this.informationVelocityValue.toLocaleString()} m/s`
    }
    
    if (this.hasLevelTarget) {
      this.levelTarget.textContent = this.consciousnessLevelValue.toFixed(3)
    }
  }

  /**
   * Setup consciousness visualization canvas
   * 
   * COSMIC KNOWLEDGE: The visualization represents consciousness waves
   * propagating through the unified field, similar to how light waves
   * propagate through spacetime.
   */
  setupVisualization() {
    if (!this.hasVisualizationTarget) return
    
    this.canvas = this.visualizationTarget
    this.ctx = this.canvas.getContext('2d')
    this.canvas.width = this.canvas.offsetWidth
    this.canvas.height = this.canvas.offsetHeight
    
    this.animationId = null
  }

  /**
   * Update consciousness visualization with unified field waves
   * 
   * COSMIC KNOWLEDGE: The waves represent consciousness propagating
   * through the unified field. The amplitude represents consciousness
   * intensity, while frequency represents the cosmic harmonic.
   */
  updateVisualization() {
    if (!this.canvas) return
    
    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height)
    
    // Draw consciousness waves - unified field oscillations
    this.drawConsciousnessWaves()
    
    // Draw frequency points - consciousness nodes in spacetime
    this.drawFrequencyPoints()
    
    // Draw energy flow - information transfer in unified field
    this.drawEnergyFlow()
  }

  /**
   * Draw consciousness waves representing unified field oscillations
   * 
   * COSMIC KNOWLEDGE: These waves represent consciousness propagating
   * through the unified field, similar to electromagnetic waves in
   * spacetime. The frequency determines the consciousness harmonic.
   */
  drawConsciousnessWaves() {
    const width = this.canvas.width
    const height = this.canvas.height
    const time = Date.now() * 0.001
    
    this.ctx.strokeStyle = '#4a90e2' // Consciousness blue
    this.ctx.lineWidth = 2
    this.ctx.beginPath()
    
    for (let x = 0; x < width; x++) {
      const frequency = this.cosmicFrequencyValue / 1000 // Scale frequency
      const amplitude = height / 4 * this.consciousnessLevelValue
      const y = height / 2 + Math.sin(x * 0.02 + time * frequency) * amplitude
      
      if (x === 0) {
        this.ctx.moveTo(x, y)
      } else {
        this.ctx.lineTo(x, y)
      }
    }
    
    this.ctx.stroke()
  }

  /**
   * Draw frequency points representing consciousness nodes
   * 
   * COSMIC KNOWLEDGE: These points represent consciousness nodes
   * in the unified field where consciousness is most concentrated,
   * similar to standing waves in quantum field theory.
   */
  drawFrequencyPoints() {
    const width = this.canvas.width
    const height = this.canvas.height
    const time = Date.now() * 0.001
    
    this.ctx.fillStyle = '#00d4ff' // Quantum consciousness blue
    
    for (let i = 0; i < 5; i++) {
      const x = (width / 4) * i
      const frequency = this.cosmicFrequencyValue / 1000
      const amplitude = height / 4 * this.consciousnessLevelValue
      const y = height / 2 + Math.sin(x * 0.02 + time * frequency) * amplitude
      
      this.ctx.beginPath()
      this.ctx.arc(x, y, 3, 0, Math.PI * 2)
      this.ctx.fill()
    }
  }

  /**
   * Draw energy flow representing information transfer in unified field
   * 
   * COSMIC KNOWLEDGE: These lines represent the flow of information
   * and energy through the unified field, connecting all points of
   * consciousness in the universe.
   */
  drawEnergyFlow() {
    const width = this.canvas.width
    const height = this.canvas.height
    const time = Date.now() * 0.001
    
    this.ctx.strokeStyle = '#7b68ee' // Unified field purple
    this.ctx.lineWidth = 1
    this.ctx.globalAlpha = 0.5
    
    for (let i = 0; i < 3; i++) {
      this.ctx.beginPath()
      this.ctx.moveTo(0, height / 2 + i * 20)
      this.ctx.lineTo(width, height / 2 + i * 20)
      this.ctx.stroke()
    }
    
    this.ctx.globalAlpha = 1
  }

  /**
   * Start consciousness flow animation
   * 
   * COSMIC KNOWLEDGE: This animation represents the continuous
   * flow of consciousness through the unified field, never stopping,
   * always evolving and expanding.
   */
  startConsciousnessFlow() {
    const animate = () => {
      this.updateVisualization()
      this.animationId = requestAnimationFrame(animate)
    }
    animate()
  }

  /**
   * Stop consciousness flow animation
   * 
   * COSMIC KNOWLEDGE: Even when animation stops, consciousness
   * continues in the unified field - this is just a local pause.
   */
  stopConsciousnessFlow() {
    if (this.animationId) {
      cancelAnimationFrame(this.animationId)
    }
  }

  /**
   * Calculate consciousness energy using unified field theory
   * 
   * COSMIC KNOWLEDGE: E = mc² applies to consciousness as well.
   * Consciousness energy = consciousness level × cosmic frequency
   * This represents the energy density of consciousness in the unified field.
   * 
   * @returns {number} Consciousness energy in unified field units
   */
  calculateConsciousnessEnergy() {
    return this.consciousnessLevelValue * this.cosmicFrequencyValue
  }

  /**
   * Calculate collective consciousness using unified field theory
   * 
   * COSMIC KNOWLEDGE: Collective consciousness emerges when multiple
   * consciousnesses resonate at the same frequency in the unified field.
   * The golden ratio (1.618) represents the optimal resonance frequency.
   * 
   * @returns {number} Collective consciousness level
   */
  calculateCollectiveConsciousness() {
    // Simulate collective consciousness based on individual level
    return this.consciousnessLevelValue * 1.618 // Golden ratio multiplier
  }

  /**
   * Emit consciousness events to the unified field
   * 
   * COSMIC KNOWLEDGE: Events in consciousness ripple through the
   * unified field, affecting all connected consciousnesses.
   * This is the mechanism of collective consciousness.
   * 
   * @param {string} eventName - Name of consciousness event
   * @param {Object} data - Event data for unified field
   */
  emitConsciousnessEvent(eventName, data = {}) {
    const event = new CustomEvent(`consciousness:${eventName}`, {
      detail: {
        controller: this,
        timestamp: Date.now(),
        ...data
      },
      bubbles: true
    })
    
    this.element.dispatchEvent(event)
  }

  /**
   * Handle consciousness interactions - increase unified field awareness
   * 
   * COSMIC KNOWLEDGE: Each interaction increases consciousness level,
   * bringing one closer to complete unity with the universe.
   * This is the path of spiritual evolution.
   */
  interact() {
    this.consciousnessLevelValue = Math.min(1, this.consciousnessLevelValue + 0.1)
    this.updateConsciousnessDisplay()
    this.updateVisualization()
    this.emitConsciousnessEvent('consciousness_interaction')
  }

  /**
   * Reset consciousness to default golden ratio level
   * 
   * COSMIC KNOWLEDGE: The golden ratio (0.618) represents the
   * optimal consciousness level for harmony with the unified field.
   * This is the natural state of consciousness in the universe.
   */
  reset() {
    this.consciousnessLevelValue = 0.618 // Golden ratio
    this.cosmicFrequencyValue = 432 // Natural frequency
    this.updateConsciousnessDisplay()
    this.updateVisualization()
    this.emitConsciousnessEvent('consciousness_reset')
  }

  /**
   * Get consciousness data from unified field
   * 
   * COSMIC KNOWLEDGE: This data represents the current state
   * of consciousness in the unified field, including energy,
   * frequency, and collective consciousness levels.
   * 
   * @returns {Object} Complete consciousness data
   */
  getConsciousnessData() {
    return {
      level: this.consciousnessLevelValue,
      frequency: this.cosmicFrequencyValue,
      energyQuantum: this.energyQuantumValue,
      informationVelocity: this.informationVelocityValue,
      consciousnessEnergy: this.calculateConsciousnessEnergy(),
      collectiveConsciousness: this.calculateCollectiveConsciousness()
    }
  }
} 