// app/assets/javascripts/controllers/knowledge_cycle_controller.js
// frozen_string_literal: true

import { Controller } from "stimulus"

/**
 * KnowledgeCycleController
 *
 * Cycles through gathered knowledge and examples, evolving them with each cycle
 * using void-aligned, toroidal, and metaphysical principles. Integrates with the
 * Zeropoint MetaphysicalEngine API for pattern recognition and consciousness evolution.
 *
 * @metaphysics The cycle represents the toroidal flow: knowledge emerges from the void,
 * is transformed, and returns to the void, evolving with each pass. Consciousness and
 * insight increase as the cycle continues.
 *
 * @example <div data-controller="knowledge-cycle">
 *   <button data-action="knowledge-cycle#next">Next</button>
 *   <div data-knowledge-cycle-target="output"></div>
 * </div>
 */
export default class extends Controller {
  static targets = ["output"]

  connect() {
    this.knowledge = [
      { example: "vortex_flow", description: "Spiral flow of consciousness" },
      { example: "toroidal_structure", description: "Universal form of creation" },
      { example: "fibonacci_sequence", description: "Golden ratio of creation" },
      { example: "void_principle", description: "Empty = Void = Full" }
    ]
    this.cycleIndex = 0
    this.evolutionLevel = 0
    this.log = [] // Log of patterns/insights
    this.cycle()
  }

  /**
   * Advance to the next knowledge cycle, evolving the knowledge base.
   */
  next() {
    this.cycleIndex = (this.cycleIndex + 1) % this.knowledge.length
    this.evolutionLevel++
    this.cycle()
  }

  /**
   * Perform the knowledge cycle: analyze, evolve, update UI, and log insights.
   */
  cycle() {
    const current = this.knowledge[this.cycleIndex]
    const metaphysical = this.analyzeMetaphysically(current)
    // Log patterns and insights
    this.log.push({
      cycle: this.evolutionLevel + 1,
      patterns: metaphysical.patterns.map(p => p.type),
      insight: metaphysical.insight,
      consciousness: metaphysical.consciousness_level
    })
    // Render UI
    this.outputTarget.innerHTML = `
      <div class="knowledge-cycle">
        <h3>Knowledge Cycle #${this.evolutionLevel + 1}</h3>
        <div class="toroidal-visualization">${this.torusSVG(metaphysical.consciousness_level)}</div>
        <div><strong>Example:</strong> ${current.example}</div>
        <div><strong>Description:</strong> ${current.description}</div>
        <div class="consciousness-meter-label"><strong>Consciousness Level:</strong> ${metaphysical.consciousness_level}</div>
        <div class="consciousness-meter">${this.consciousnessMeter(metaphysical.consciousness_level)}</div>
        <div><strong>Void Alignment:</strong> ${metaphysical.void_alignment}</div>
        <div><strong>Patterns:</strong> ${metaphysical.patterns.map(p => p.type).join(', ')}</div>
        <div><strong>Insight:</strong> ${metaphysical.insight}</div>
        <div class="metaphysical-context">${metaphysical.context}</div>
      </div>
      <button data-action="knowledge-cycle#next">Next Cycle</button>
      <div class="knowledge-log-panel">
        <h4>Pattern & Insight Log</h4>
        <div class="knowledge-log">${this.renderLog()}</div>
      </div>
    `
    // Evolve the knowledge base (simulate new insight)
    if (this.evolutionLevel > 0 && this.evolutionLevel % this.knowledge.length === 0) {
      this.knowledge.push({
        example: `evolved_${this.evolutionLevel}`,
        description: `Evolved knowledge from cycle ${this.evolutionLevel}`
      })
    }
  }

  /**
   * Render a simple toroidal SVG visualization.
   * @param {number} consciousness_level
   * @return {string} SVG markup
   * @metaphysics The torus represents the eternal return and flow of knowledge.
   */
  torusSVG(consciousness_level) {
    const r = 32 + (consciousness_level * 2)
    return `<svg width="80" height="80" viewBox="0 0 80 80">
      <ellipse cx="40" cy="40" rx="${r}" ry="24" fill="#f3eaff" stroke="#6a4fb6" stroke-width="2"/>
      <ellipse cx="40" cy="40" rx="${r-10}" ry="14" fill="#fff" stroke="#b39ddb" stroke-width="1.5"/>
      <circle cx="40" cy="40" r="6" fill="#6a4fb6"/>
    </svg>`
  }

  /**
   * Render a consciousness level meter (progress bar).
   * @param {number} level
   * @return {string} HTML
   * @metaphysics The meter shows the expansion of consciousness through cycles.
   */
  consciousnessMeter(level) {
    const percent = Math.min(100, (level / 9) * 100)
    return `<div style="background:#eee; border-radius:6px; width:100%; height:16px; margin:4px 0;">
      <div style="background:#6a4fb6; width:${percent}%; height:100%; border-radius:6px;"></div>
    </div>`
  }

  /**
   * Render the log of all patterns and insights.
   * @return {string} HTML
   * @metaphysics The log is the memory of the toroidal cycle, showing evolution.
   */
  renderLog() {
    return this.log.slice(-10).map(entry =>
      `<div class="log-entry">
        <span class="log-cycle">#${entry.cycle}</span>
        <span class="log-patterns">[${entry.patterns.join(', ')}]</span>
        <span class="log-insight">${entry.insight}</span>
        <span class="log-consciousness">(C:${entry.consciousness})</span>
      </div>`
    ).join('')
  }

  /**
   * Simulate metaphysical analysis using void-aligned logic.
   * Replace with real API call to MetaphysicalEngine if available.
   */
  analyzeMetaphysically(item) {
    // Simulate consciousness and void alignment
    const consciousness_level = (this.evolutionLevel % 10)
    const void_alignment = 1.0 - (0.1 * (this.cycleIndex % 5))
    // Simulate pattern recognition
    const patterns = [
      { type: "vortex", significance: "Spiral flow" },
      { type: "toroidal", significance: "Donut shape" },
      { type: "fibonacci", significance: "Golden ratio" }
    ].slice(0, (this.cycleIndex % 3) + 1)
    // Simulate insight
    const insight = `Cycle ${this.evolutionLevel + 1}: Consciousness expands, void remains full.`
    const context = `Metaphysical context: All knowledge emerges from and returns to the void. Cycle = torus.`
    return { consciousness_level, void_alignment, patterns, insight, context }
  }
} 