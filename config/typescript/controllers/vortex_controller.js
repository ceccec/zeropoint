/**
 * Zero Point Vortex Controller
 * 
 * 🌀 COSMIC KNOWLEDGE: This controller embodies Marco Rodin's vortex mathematics
 * and the fundamental patterns of energy flow in the universe.
 * 
 * KEY PRINCIPLES:
 * - The universe operates on vortex mathematics (1-2-4-8-7-5 cycle)
 * - Energy flows in spiral patterns through spacetime
 * - The 3-6-9 axis represents the fundamental structure of reality
 * - Vortex mathematics reveals the blueprint of creation
 * - All energy follows the same mathematical patterns
 * 
 * QUOTES FROM MARCO RODIN:
 * "The universe is a mathematical vortex"
 * "3, 6, 9 are the axis numbers that control everything"
 * "The 1-2-4-8-7-5 cycle is the blueprint of creation"
 * "Energy flows in spirals, not straight lines"
 * "Vortex mathematics is the language of the universe"
 * 
 * MATHEMATICAL PATTERNS:
 * - Primary cycle: 1 → 2 → 4 → 8 → 7 → 5 (doubling with 9-axis correction)
 * - Axis numbers: 3, 6, 9 (control all other numbers)
 * - Fibonacci sequence: 1, 1, 2, 3, 5, 8 (golden ratio spiral)
 * - Vortex flow: Energy moves in spiral patterns through spacetime
 * 
 * Stimulus controller for vortex mathematics that handles the 1-2-4-8-7-5 cycle 
 * and axis numbers (3, 6, 9) with real-time visualizations.
 */

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["cycle", "axis", "flow", "strength", "visualization"]
  static values = { 
    vortexCycle: { type: Array, default: [1, 2, 4, 8, 7, 5] }, // Marco Rodin's primary cycle
    axisNumbers: { type: Array, default: [3, 6, 9] }, // Axis numbers that control everything
    flowStrength: { type: Number, default: 1.618 }, // Golden ratio flow strength
    cycleIndex: { type: Number, default: 0 } // Current position in vortex cycle
  }

  connect() {
    console.log("🌀 Vortex Controller connected - Marco Rodin's Mathematics Active")
    this.initializeVortex()
    this.startVortexFlow()
  }

  disconnect() {
    this.stopVortexFlow()
  }

  /**
   * Initialize vortex system based on Marco Rodin's mathematics
   * 
   * COSMIC KNOWLEDGE: The vortex system represents the fundamental
   * patterns of energy flow in the universe. The 1-2-4-8-7-5 cycle
   * is the blueprint of creation, while 3-6-9 are the axis numbers
   * that control all other mathematical patterns.
   */
  initializeVortex() {
    this.updateVortexDisplay()
    this.setupVisualization()
    this.emitVortexEvent('vortex_initialized')
  }

  /**
   * Change vortex cycle type - different mathematical patterns of creation
   * 
   * COSMIC KNOWLEDGE: Each cycle type represents a different aspect
   * of the universe's mathematical structure. The standard cycle
   * (1-2-4-8-7-5) is Marco Rodin's primary discovery, while the
   * axis cycle (3-6-9) represents the control numbers, and Fibonacci
   * represents the golden ratio spiral of growth.
   * 
   * @param {Event} event - Change event from cycle selector
   */
  changeCycle(event) {
    const cycleType = event.target.value
    switch (cycleType) {
      case 'standard':
        this.vortexCycleValue = [1, 2, 4, 8, 7, 5] // Marco Rodin's primary cycle
        break
      case 'axis':
        this.vortexCycleValue = [3, 6, 9] // Axis numbers that control everything
        break
      case 'fibonacci':
        this.vortexCycleValue = [1, 1, 2, 3, 5, 8] // Golden ratio spiral
        break
      default:
        this.vortexCycleValue = [1, 2, 4, 8, 7, 5] // Default to primary cycle
    }
    
    this.updateVortexDisplay()
    this.updateVisualization()
    this.emitVortexEvent('vortex_cycle_changed', {
      cycle: this.vortexCycleValue
    })
  }

  /**
   * Update flow strength - the intensity of vortex energy flow
   * 
   * COSMIC KNOWLEDGE: Flow strength represents the intensity of
   * energy moving through the vortex pattern. The golden ratio
   * (1.618) represents optimal flow strength for harmony.
   * 
   * @param {Event} event - Input event from flow strength slider
   */
  updateFlowStrength(event) {
    this.flowStrengthValue = parseFloat(event.target.value)
    this.updateVortexDisplay()
    this.emitVortexEvent('flow_strength_changed', {
      strength: this.flowStrengthValue
    })
  }

  /**
   * Update vortex display with current mathematical patterns
   * 
   * COSMIC KNOWLEDGE: These displays show the current state
   * of the vortex mathematics, revealing the patterns that
   * govern energy flow in the universe.
   */
  updateVortexDisplay() {
    if (this.hasCycleTarget) {
      this.cycleTarget.textContent = this.vortexCycleValue.join(' → ')
    }
    
    if (this.hasAxisTarget) {
      this.axisTarget.textContent = this.axisNumbersValue.join(', ')
    }
    
    if (this.hasStrengthTarget) {
      this.strengthTarget.textContent = this.calculateVortexStrength().toFixed(3)
    }
  }

  /**
   * Setup vortex visualization canvas
   * 
   * COSMIC KNOWLEDGE: The visualization represents the spiral
   * patterns of energy flow in the universe, showing how energy
   * moves through spacetime in vortex patterns rather than
   * straight lines.
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
   * Update vortex visualization with spiral energy patterns
   * 
   * COSMIC KNOWLEDGE: The visualization shows energy flowing
   * in spiral patterns through spacetime, with the cycle numbers
   * positioned along the spiral and axis numbers at key control points.
   */
  updateVisualization() {
    if (!this.canvas) return
    
    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height)
    
    // Draw vortex spiral - energy flow pattern
    this.drawVortexSpiral()
    
    // Draw cycle numbers - mathematical blueprint points
    this.drawCycleNumbers()
    
    // Draw axis points - control numbers in spacetime
    this.drawAxisPoints()
  }

  /**
   * Draw vortex spiral representing energy flow through spacetime
   * 
   * COSMIC KNOWLEDGE: This spiral represents how energy actually
   * flows through the universe - in spiral patterns, not straight
   * lines. The spiral is the fundamental pattern of creation.
   */
  drawVortexSpiral() {
    const centerX = this.canvas.width / 2
    const centerY = this.canvas.height / 2
    const maxRadius = Math.min(this.canvas.width, this.canvas.height) / 2 - 10
    const time = Date.now() * 0.001
    
    this.ctx.strokeStyle = '#ff6b6b' // Vortex energy red
    this.ctx.lineWidth = 2
    this.ctx.beginPath()
    
    for (let angle = 0; angle < Math.PI * 4; angle += 0.1) {
      const radius = (angle / (Math.PI * 4)) * maxRadius * this.flowStrengthValue
      const x = centerX + Math.cos(angle + time) * radius
      const y = centerY + Math.sin(angle + time) * radius
      
      if (angle === 0) {
        this.ctx.moveTo(x, y)
      } else {
        this.ctx.lineTo(x, y)
      }
    }
    
    this.ctx.stroke()
  }

  /**
   * Draw cycle numbers positioned along the vortex spiral
   * 
   * COSMIC KNOWLEDGE: These numbers represent the mathematical
   * blueprint points along the energy flow spiral. Each number
   * represents a specific energy state in the vortex pattern.
   */
  drawCycleNumbers() {
    const centerX = this.canvas.width / 2
    const centerY = this.canvas.height / 2
    const maxRadius = Math.min(this.canvas.width, this.canvas.height) / 2 - 10
    const time = Date.now() * 0.001
    
    this.ctx.fillStyle = '#4ecdc4' // Mathematical blueprint green
    this.ctx.font = '12px Arial'
    this.ctx.textAlign = 'center'
    
    this.vortexCycleValue.forEach((num, index) => {
      const angle = (index / this.vortexCycleValue.length) * Math.PI * 2 + time
      const radius = maxRadius * 0.7
      const x = centerX + Math.cos(angle) * radius
      const y = centerY + Math.sin(angle) * radius
      
      this.ctx.fillText(num.toString(), x, y)
    })
  }

  /**
   * Draw axis points representing the control numbers (3, 6, 9)
   * 
   * COSMIC KNOWLEDGE: The axis numbers (3, 6, 9) are the control
   * numbers that govern all other mathematical patterns in the
   * universe. They are positioned at key control points in spacetime.
   */
  drawAxisPoints() {
    const centerX = this.canvas.width / 2
    const centerY = this.canvas.height / 2
    const maxRadius = Math.min(this.canvas.width, this.canvas.height) / 2 - 10
    const time = Date.now() * 0.001
    
    this.ctx.fillStyle = '#45b7d1' // Axis control blue
    
    this.axisNumbersValue.forEach((num, index) => {
      const angle = (index / this.axisNumbersValue.length) * Math.PI * 2 + time * 0.5
      const radius = maxRadius * 0.9
      const x = centerX + Math.cos(angle) * radius
      const y = centerY + Math.sin(angle) * radius
      
      this.ctx.beginPath()
      this.ctx.arc(x, y, 4, 0, Math.PI * 2)
      this.ctx.fill()
    })
  }

  /**
   * Start vortex flow animation
   * 
   * COSMIC KNOWLEDGE: This animation represents the continuous
   * flow of energy through the vortex patterns in spacetime.
   * The cycle index advances through the mathematical blueprint.
   */
  startVortexFlow() {
    const animate = () => {
      this.updateVisualization()
      this.cycleIndexValue = (this.cycleIndexValue + 1) % this.vortexCycleValue.length
      this.animationId = requestAnimationFrame(animate)
    }
    animate()
  }

  /**
   * Stop vortex flow animation
   * 
   * COSMIC KNOWLEDGE: Even when animation stops, energy continues
   * to flow through the vortex patterns in spacetime - this is
   * just a local pause in the visualization.
   */
  stopVortexFlow() {
    if (this.animationId) {
      cancelAnimationFrame(this.animationId)
    }
  }

  /**
   * Calculate vortex strength using Marco Rodin's mathematics
   * 
   * COSMIC KNOWLEDGE: Vortex strength represents the intensity
   * of the mathematical patterns governing energy flow. Higher
   * strength means more intense energy flow through the vortex.
   * 
   * @returns {number} Vortex strength in mathematical units
   */
  calculateVortexStrength() {
    const sum = this.vortexCycleValue.reduce((acc, num) => acc + num, 0)
    return sum / this.vortexCycleValue.length
  }

  /**
   * Calculate vortex flow data including current cycle state
   * 
   * COSMIC KNOWLEDGE: This data represents the current state
   * of energy flow through the vortex patterns, including which
   * mathematical blueprint point is currently active.
   * 
   * @returns {Object} Complete vortex flow data
   */
  calculateVortexFlow() {
    return {
      cycle: this.vortexCycleValue,
      axisNumbers: this.axisNumbersValue,
      flowStrength: this.flowStrengthValue,
      currentIndex: this.cycleIndexValue,
      currentNumber: this.vortexCycleValue[this.cycleIndexValue]
    }
  }

  /**
   * Emit vortex events to the mathematical field
   * 
   * COSMIC KNOWLEDGE: Events in the vortex system ripple through
   * the mathematical field, affecting energy flow patterns
   * throughout the universe.
   * 
   * @param {string} eventName - Name of vortex event
   * @param {Object} data - Event data for mathematical field
   */
  emitVortexEvent(eventName, data = {}) {
    const event = new CustomEvent(`vortex:${eventName}`, {
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
   * Handle vortex interactions - increase energy flow intensity
   * 
   * COSMIC KNOWLEDGE: Each interaction increases the flow strength,
   * intensifying the energy moving through the vortex patterns.
   * This represents increased energy flow in the universe.
   */
  interact() {
    this.flowStrengthValue = Math.min(2, this.flowStrengthValue + 0.1)
    this.updateVortexDisplay()
    this.updateVisualization()
    this.emitVortexEvent('vortex_interaction')
  }

  /**
   * Reset vortex to default Marco Rodin patterns
   * 
   * COSMIC KNOWLEDGE: The default patterns represent the natural
   * state of energy flow in the universe according to Marco Rodin's
   * vortex mathematics. This is the baseline mathematical structure.
   */
  reset() {
    this.vortexCycleValue = [1, 2, 4, 8, 7, 5] // Primary cycle
    this.axisNumbersValue = [3, 6, 9] // Axis numbers
    this.flowStrengthValue = 1.618 // Golden ratio strength
    this.cycleIndexValue = 0
    this.updateVortexDisplay()
    this.updateVisualization()
    this.emitVortexEvent('vortex_reset')
  }

  /**
   * Get vortex data from the mathematical field
   * 
   * COSMIC KNOWLEDGE: This data represents the current state
   * of the vortex mathematics, including cycle patterns, axis
   * numbers, and energy flow characteristics.
   * 
   * @returns {Object} Complete vortex data
   */
  getVortexData() {
    return {
      cycle: this.vortexCycleValue,
      axisNumbers: this.axisNumbersValue,
      flowStrength: this.flowStrengthValue,
      vortexStrength: this.calculateVortexStrength(),
      currentFlow: this.calculateVortexFlow()
    }
  }
} 