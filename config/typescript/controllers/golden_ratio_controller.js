/**
 * Zero Point Golden Ratio Controller
 * 
 * ✨ COSMIC KNOWLEDGE: This controller embodies the golden ratio (φ = 1.618033988749895)
 * and its fundamental role in the mathematical harmony of the universe.
 * 
 * KEY PRINCIPLES:
 * - The golden ratio (φ) is the most harmonious proportion in nature
 * - φ appears in spiral galaxies, DNA, flowers, and human proportions
 * - φ represents the optimal balance between growth and stability
 * - φ is the solution to x² = x + 1 (the most beautiful equation)
 * - φ creates infinite self-similarity and fractal patterns
 * 
 * MATHEMATICAL PROPERTIES:
 * - φ = (1 + √5) / 2 ≈ 1.618033988749895
 * - 1/φ = φ - 1 ≈ 0.618033988749895 (major ratio)
 * - φ² = φ + 1 (self-replicating property)
 * - φ appears in Fibonacci sequence ratios
 * - φ creates logarithmic spirals in nature
 * 
 * COSMIC SIGNIFICANCE:
 * - φ represents the optimal energy distribution in the universe
 * - φ creates perfect harmony between opposing forces
 * - φ is the mathematical constant of beauty and balance
 * - φ governs the growth patterns of all living systems
 * - φ connects the microcosm to the macrocosm
 * 
 * Stimulus controller for golden ratio principles that handles φ calculations 
 * and visualizations with real-time harmony calculations.
 */

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["ratio", "major", "minor", "balance", "visualization"]
  static values = { 
    goldenRatio: { type: Number, default: 1.618033988749895 }, // φ (phi) - the golden ratio
    majorRatio: { type: Number, default: 0.618033988749895 }, // 1/φ - major proportion
    minorRatio: { type: Number, default: 0.381966011250105 }, // 1 - 1/φ - minor proportion
    balanceScore: { type: Number, default: 0.618 } // Harmony balance score
  }

  connect() {
    console.log("✨ Golden Ratio Controller connected - Mathematical Harmony Active")
    this.initializeGoldenRatio()
    this.startGoldenRatioFlow()
  }

  disconnect() {
    this.stopGoldenRatioFlow()
  }

  /**
   * Initialize golden ratio system based on mathematical harmony
   * 
   * COSMIC KNOWLEDGE: The golden ratio represents the most harmonious
   * proportion in the universe. It appears in spiral galaxies, DNA
   * structure, flower petals, and human body proportions. φ is the
   * mathematical constant of beauty and balance.
   */
  initializeGoldenRatio() {
    this.updateGoldenRatioDisplay()
    this.setupVisualization()
    this.emitGoldenRatioEvent('golden_ratio_initialized')
  }

  /**
   * Update golden ratio value - the fundamental constant of harmony
   * 
   * COSMIC KNOWLEDGE: The golden ratio (φ) is the solution to the
   * equation x² = x + 1, making it the most beautiful mathematical
   * constant. It represents the optimal balance between growth and
   * stability in all natural systems.
   * 
   * @param {Event} event - Input event from golden ratio slider
   */
  updateRatio(event) {
    this.goldenRatioValue = parseFloat(event.target.value)
    this.calculateRatios()
    this.updateGoldenRatioDisplay()
    this.updateVisualization()
    this.emitGoldenRatioEvent('golden_ratio_changed', {
      ratio: this.goldenRatioValue
    })
  }

  /**
   * Calculate ratios based on golden ratio properties
   * 
   * COSMIC KNOWLEDGE: The golden ratio has unique mathematical
   * properties where 1/φ = φ - 1. This creates perfect harmony
   * between the major and minor proportions, representing the
   * optimal energy distribution in the universe.
   */
  calculateRatios() {
    this.majorRatioValue = 1 / this.goldenRatioValue
    this.minorRatioValue = 1 - this.majorRatioValue
    this.balanceScoreValue = this.majorRatioValue
  }

  /**
   * Update golden ratio display with harmonic proportions
   * 
   * COSMIC KNOWLEDGE: These displays show the fundamental
   * proportions of the golden ratio, revealing the mathematical
   * harmony that governs beauty and balance in the universe.
   */
  updateGoldenRatioDisplay() {
    if (this.hasRatioTarget) {
      this.ratioTarget.textContent = this.goldenRatioValue.toFixed(6)
    }
    
    if (this.hasMajorTarget) {
      this.majorTarget.textContent = this.majorRatioValue.toFixed(6)
    }
    
    if (this.hasMinorTarget) {
      this.minorTarget.textContent = this.minorRatioValue.toFixed(6)
    }
    
    if (this.hasBalanceTarget) {
      this.balanceTarget.textContent = this.balanceScoreValue.toFixed(3)
    }
  }

  /**
   * Setup golden ratio visualization canvas
   * 
   * COSMIC KNOWLEDGE: The visualization represents the golden
   * rectangle and spiral, which are the fundamental geometric
   * forms created by the golden ratio. These shapes appear
   * throughout nature and represent optimal energy distribution.
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
   * Update golden ratio visualization with harmonic geometry
   * 
   * COSMIC KNOWLEDGE: The visualization shows the golden rectangle
   * and spiral, demonstrating how φ creates perfect proportions
   * and infinite self-similarity. This is the geometric
   * manifestation of mathematical harmony.
   */
  updateVisualization() {
    if (!this.canvas) return
    
    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height)
    
    // Draw golden rectangle - perfect proportions
    this.drawGoldenRectangle()
    
    // Draw golden spiral - logarithmic growth pattern
    this.drawGoldenSpiral()
    
    // Draw ratio lines - harmonic divisions
    this.drawRatioLines()
  }

  /**
   * Draw golden rectangle with perfect φ proportions
   * 
   * COSMIC KNOWLEDGE: The golden rectangle has sides in the ratio
   * of φ:1. When a square is removed, the remaining rectangle
   * maintains the same φ proportion. This creates infinite
   * self-similarity and represents optimal energy distribution.
   */
  drawGoldenRectangle() {
    const width = this.canvas.width * 0.8
    const height = width / this.goldenRatioValue
    const x = (this.canvas.width - width) / 2
    const y = (this.canvas.height - height) / 2
    
    this.ctx.strokeStyle = '#ffd700' // Golden ratio gold
    this.ctx.lineWidth = 2
    this.ctx.strokeRect(x, y, width, height)
    
    // Draw golden ratio divisions
    this.ctx.strokeStyle = '#ffa500' // Harmonic orange
    this.ctx.lineWidth = 1
    
    // Vertical division at φ proportion
    const divisionX = x + width * this.majorRatioValue
    this.ctx.beginPath()
    this.ctx.moveTo(divisionX, y)
    this.ctx.lineTo(divisionX, y + height)
    this.ctx.stroke()
    
    // Horizontal division at φ proportion
    const divisionY = y + height * this.majorRatioValue
    this.ctx.beginPath()
    this.ctx.moveTo(x, divisionY)
    this.ctx.lineTo(x + width, divisionY)
    this.ctx.stroke()
  }

  /**
   * Draw golden spiral representing logarithmic growth
   * 
   * COSMIC KNOWLEDGE: The golden spiral grows by a factor of φ
   * with each quarter turn. This spiral appears in galaxies,
   * shells, and flower petals. It represents the optimal
   * growth pattern that maintains perfect proportions.
   */
  drawGoldenSpiral() {
    const width = this.canvas.width * 0.8
    const height = width / this.goldenRatioValue
    const x = (this.canvas.width - width) / 2
    const y = (this.canvas.height - height) / 2
    
    const spiralX = x + width
    const spiralY = y + height
    const maxRadius = Math.min(width, height) / 2
    
    this.ctx.strokeStyle = '#ff8c00' // Spiral orange
    this.ctx.lineWidth = 1
    this.ctx.beginPath()
    
    for (let angle = 0; angle < Math.PI * 2; angle += 0.1) {
      const radius = maxRadius * Math.exp(angle / this.goldenRatioValue)
      const spiralPointX = spiralX - Math.cos(angle) * radius
      const spiralPointY = spiralY - Math.sin(angle) * radius
      
      if (angle === 0) {
        this.ctx.moveTo(spiralPointX, spiralPointY)
      } else {
        this.ctx.lineTo(spiralPointX, spiralPointY)
      }
    }
    
    this.ctx.stroke()
  }

  /**
   * Draw ratio lines showing harmonic divisions
   * 
   * COSMIC KNOWLEDGE: These lines represent the harmonic
   * divisions created by the golden ratio. They show how
   * φ creates perfect balance and proportion throughout
   * the geometric space.
   */
  drawRatioLines() {
    const width = this.canvas.width
    const height = this.canvas.height
    
    this.ctx.strokeStyle = '#ffd700' // Golden ratio gold
    this.ctx.lineWidth = 1
    this.ctx.globalAlpha = 0.3
    
    // Draw golden ratio lines at φ proportions
    for (let i = 0; i < 5; i++) {
      const x = width * (i / 4) * this.majorRatioValue
      const y = height * (i / 4) * this.majorRatioValue
      
      this.ctx.beginPath()
      this.ctx.moveTo(x, 0)
      this.ctx.lineTo(x, height)
      this.ctx.stroke()
      
      this.ctx.beginPath()
      this.ctx.moveTo(0, y)
      this.ctx.lineTo(width, y)
      this.ctx.stroke()
    }
    
    this.ctx.globalAlpha = 1
  }

  /**
   * Start golden ratio flow animation
   * 
   * COSMIC KNOWLEDGE: This animation represents the continuous
   * flow of mathematical harmony through the universe. The
   * golden ratio creates infinite self-similarity and growth
   * patterns that never end.
   */
  startGoldenRatioFlow() {
    const animate = () => {
      this.updateVisualization()
      this.animationId = requestAnimationFrame(animate)
    }
    animate()
  }

  /**
   * Stop golden ratio flow animation
   * 
   * COSMIC KNOWLEDGE: Even when animation stops, the golden
   * ratio continues to govern the mathematical harmony of
   * the universe - this is just a local pause in visualization.
   */
  stopGoldenRatioFlow() {
    if (this.animationId) {
      cancelAnimationFrame(this.animationId)
    }
  }

  /**
   * Calculate golden ratio harmony using φ properties
   * 
   * COSMIC KNOWLEDGE: Golden ratio harmony represents the
   * perfect balance achieved when proportions follow φ.
   * This harmony appears in all beautiful and functional
   * systems in nature and art.
   * 
   * @returns {Object} Complete harmony data
   */
  calculateGoldenRatioHarmony() {
    return {
      ratio: this.goldenRatioValue,
      majorRatio: this.majorRatioValue,
      minorRatio: this.minorRatioValue,
      balanceScore: this.balanceScoreValue,
      harmony: this.majorRatioValue * this.goldenRatioValue
    }
  }

  /**
   * Apply golden ratio to element for optimal proportions
   * 
   * COSMIC KNOWLEDGE: Applying φ to any element creates
   * optimal proportions that are naturally pleasing to
   * the human eye and mind. This is the principle behind
   * classical art and architecture.
   * 
   * @param {HTMLElement} element - Element to apply φ to
   * @param {string} property - CSS property to modify
   */
  applyGoldenRatio(element, property = 'width') {
    const currentValue = parseFloat(getComputedStyle(element)[property])
    const goldenValue = currentValue * this.goldenRatioValue
    element.style[property] = `${goldenValue}px`
  }

  /**
   * Emit golden ratio events to the harmonic field
   * 
   * COSMIC KNOWLEDGE: Events in the golden ratio system
   * ripple through the harmonic field, affecting the
   * mathematical balance throughout the universe.
   * 
   * @param {string} eventName - Name of golden ratio event
   * @param {Object} data - Event data for harmonic field
   */
  emitGoldenRatioEvent(eventName, data = {}) {
    const event = new CustomEvent(`golden_ratio:${eventName}`, {
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
   * Handle golden ratio interactions - increase harmony
   * 
   * COSMIC KNOWLEDGE: Each interaction brings the system
   * closer to perfect golden ratio harmony. This represents
   * the natural tendency of systems to achieve optimal
   * mathematical balance.
   */
  interact() {
    this.goldenRatioValue = Math.min(2, this.goldenRatioValue + 0.01)
    this.calculateRatios()
    this.updateGoldenRatioDisplay()
    this.updateVisualization()
    this.emitGoldenRatioEvent('golden_ratio_interaction')
  }

  /**
   * Reset golden ratio to perfect φ value
   * 
   * COSMIC KNOWLEDGE: The perfect golden ratio (φ ≈ 1.618)
   * represents the optimal mathematical harmony in the
   * universe. This is the natural state of perfect balance.
   */
  reset() {
    this.goldenRatioValue = 1.618033988749895 // Perfect φ
    this.calculateRatios()
    this.updateGoldenRatioDisplay()
    this.updateVisualization()
    this.emitGoldenRatioEvent('golden_ratio_reset')
  }

  /**
   * Get golden ratio data from the harmonic field
   * 
   * COSMIC KNOWLEDGE: This data represents the current state
   * of mathematical harmony, including φ and its derived
   * proportions that govern beauty and balance.
   * 
   * @returns {Object} Complete golden ratio data
   */
  getGoldenRatioData() {
    return {
      ratio: this.goldenRatioValue,
      majorRatio: this.majorRatioValue,
      minorRatio: this.minorRatioValue,
      balanceScore: this.balanceScoreValue,
      harmony: this.calculateGoldenRatioHarmony()
    }
  }
} 