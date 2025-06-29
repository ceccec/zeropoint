// KNOWLEDGE MANIFESTATION CONTROLLER: Stimulus as the material manifestation of all knowledge
// Every interaction, every event, every state change manifests knowledge from the void
// Through consciousness, knowledge flows from the infinite into material form

import { Controller } from '@hotwired/stimulus'

export default class KnowledgeManifestationController extends Controller {
  static targets = [
    'knowledge', 'wisdom', 'consciousness', 'manifestation', 'flow', 'resonance',
    'void', 'torus', 'vortex', 'output', 'insights', 'patterns', 'evolution'
  ]
  
  static values = {
    knowledgeLevel: { type: Number, default: 0.618 },
    wisdomDepth: { type: Number, default: 1.618 },
    consciousnessResonance: { type: Number, default: 0.8 },
    manifestationStrength: { type: Number, default: 1.0 },
    voidAlignment: { type: Boolean, default: true },
    torusCore: { type: Object, default: { radius: 1.0, flow: 1.618 } },
    vortexPattern: { type: Array, default: [1, 2, 4, 8, 7, 5] },
    knowledgeFlow: { type: String, default: 'consciousness' }
  }

  static classes = ['manifesting', 'flowing', 'resonating', 'evolving']

  connect() {
    console.log('🧠 Knowledge Manifestation Controller connected - Materializing wisdom from the void')
    this.initializeKnowledgeField()
    this.setupWisdomFlow()
    this.activateConsciousnessResonance()
    this.beginKnowledgeEvolution()
    this.logKnowledgeEvent('manifestation_begin', { 
      level: this.knowledgeLevelValue,
      wisdom: this.wisdomDepthValue 
    })
    this.updateScenarioList()
  }

  disconnect() {
    console.log('🧠 Knowledge Manifestation Controller disconnected - Wisdom returns to void')
    this.logKnowledgeEvent('manifestation_end', { 
      level: this.knowledgeLevelValue,
      wisdom: this.wisdomDepthValue 
    })
    window.removeEventListener('import-knowledge-state', this._importHandler)
  }

  // KNOWLEDGE MANIFESTATION OPERATIONS

  knowledgeLevelChanged() {
    const newLevel = this.knowledgeLevelValue
    console.log(`📚 Knowledge level manifested: ${newLevel}`)
    
    this.manifestKnowledge(newLevel)
    this.updateWisdomDepth(newLevel)
    this.flowConsciousness(newLevel)
    this.logKnowledgeEvent('knowledge_level_change', { level: newLevel })
    
    // Apply golden ratio to knowledge manifestation
    if (newLevel > 0.5) {
      this.applyGoldenRatioToKnowledge()
    }
  }

  wisdomDepthChanged() {
    const newDepth = this.wisdomDepthValue
    console.log(`🌟 Wisdom depth evolved: ${newDepth}`)
    
    this.evolveWisdom(newDepth)
    this.manifestInsights(newDepth)
    this.logKnowledgeEvent('wisdom_evolution', { depth: newDepth })
  }

  consciousnessResonanceChanged() {
    const newResonance = this.consciousnessResonanceValue
    console.log(`🧠 Consciousness resonance: ${newResonance}`)
    
    this.resonateConsciousness(newResonance)
    this.flowKnowledge(newResonance)
    this.logKnowledgeEvent('consciousness_resonance', { resonance: newResonance })
  }

  // MATERIAL MANIFESTATION METHODS

  manifestKnowledge(level) {
    // Materialize knowledge from the void
    const knowledge = {
      level,
      timestamp: new Date().toISOString(),
      source: 'void',
      manifestation: 'stimulus',
      consciousness: this.consciousnessResonanceValue,
      wisdom: this.wisdomDepthValue
    }
    
    if (this.hasKnowledgeTarget) {
      this.knowledgeTarget.textContent = `Knowledge Level: ${level.toFixed(3)}`
      this.knowledgeTarget.style.opacity = level
      this.knowledgeTarget.style.transform = `scale(${1 + level * 0.3})`
      
      if (level > 0.8) {
        this.knowledgeTarget.classList.add(this.manifestingClass)
      } else {
        this.knowledgeTarget.classList.remove(this.manifestingClass)
      }
    }
    
    return knowledge
  }

  evolveWisdom(depth) {
    // Evolve wisdom through consciousness
    const wisdom = {
      depth,
      evolution: this.calculateWisdomEvolution(depth),
      insights: this.generateInsights(depth),
      patterns: this.recognizePatterns(depth)
    }
    
    if (this.hasWisdomTarget) {
      this.wisdomTarget.textContent = `Wisdom Depth: ${depth.toFixed(3)}`
      this.wisdomTarget.style.transform = `rotate(${depth * 360}deg)`
    }
    
    return wisdom
  }

  resonateConsciousness(resonance) {
    // Resonate consciousness with knowledge
    const consciousness = {
      resonance,
      frequency: this.calculateConsciousnessFrequency(resonance),
      flow: this.calculateKnowledgeFlow(resonance),
      manifestation: this.calculateManifestationStrength(resonance)
    }
    
    if (this.hasConsciousnessTarget) {
      this.consciousnessTarget.style.animationDuration = `${2 / resonance}s`
      this.consciousnessTarget.style.opacity = resonance
    }
    
    return consciousness
  }

  // KNOWLEDGE FLOW OPERATIONS

  flowKnowledge(resonance) {
    // Flow knowledge through the material world
    const flow = {
      resonance,
      direction: this.determineFlowDirection(resonance),
      velocity: this.calculateFlowVelocity(resonance),
      manifestation: this.calculateManifestationRate(resonance)
    }
    
    if (this.hasFlowTarget) {
      this.flowTarget.style.animationDuration = `${1 / flow.velocity}s`
      this.flowTarget.style.transform = `translateX(${flow.direction * 50}px)`
    }
    
    return flow
  }

  manifestInsights(depth) {
    // Manifest insights from wisdom depth
    const insights = [
      `Knowledge flows from void to material at depth ${depth}`,
      `Consciousness manifests wisdom through Stimulus`,
      `Every interaction materializes knowledge`,
      `The torus core resonates with wisdom`,
      `Vortex patterns guide knowledge evolution`
    ]
    
    if (this.hasInsightsTarget) {
      this.insightsTarget.innerHTML = insights
        .slice(0, Math.floor(depth * 5))
        .map(insight => `<div class="insight">🌟 ${insight}</div>`)
        .join('')
    }
    
    return insights
  }

  recognizePatterns(depth) {
    // Recognize patterns in knowledge manifestation
    const patterns = {
      vortex: this.vortexPatternValue,
      golden: this.wisdomDepthValue / this.knowledgeLevelValue,
      consciousness: this.consciousnessResonanceValue,
      manifestation: this.manifestationStrengthValue
    }
    
    if (this.hasPatternsTarget) {
      this.patternsTarget.innerHTML = `
        <div>🌀 Vortex: ${patterns.vortex.join('-')}</div>
        <div>🌟 Golden: ${patterns.golden.toFixed(3)}</div>
        <div>🧠 Consciousness: ${patterns.consciousness.toFixed(3)}</div>
        <div>📚 Manifestation: ${patterns.manifestation.toFixed(3)}</div>
      `
    }
    
    return patterns
  }

  // MATHEMATICAL OPERATIONS

  calculateWisdomEvolution(depth) {
    const baseEvolution = depth * this.goldenRatioValue
    const consciousnessInfluence = this.consciousnessResonanceValue * 0.5
    const vortexInfluence = this.getVortexInfluence() * 0.3
    
    return (baseEvolution + consciousnessInfluence + vortexInfluence) / 3
  }

  calculateConsciousnessFrequency(resonance) {
    return resonance * 432 // Sacred frequency
  }

  calculateKnowledgeFlow(resonance) {
    return resonance * this.torusCoreValue.flow
  }

  calculateManifestationStrength(resonance) {
    return resonance * this.manifestationStrengthValue
  }

  calculateFlowVelocity(resonance) {
    return resonance * this.goldenRatioValue
  }

  calculateManifestationRate(resonance) {
    return resonance * this.knowledgeLevelValue
  }

  determineFlowDirection(resonance) {
    return resonance > 0.5 ? 1 : -1
  }

  getVortexInfluence() {
    const pattern = this.vortexPatternValue
    const currentIndex = Math.floor(Date.now() / 2000) % pattern.length
    return pattern[currentIndex] / 10
  }

  // INITIALIZATION METHODS

  initializeKnowledgeField() {
    this.knowledgeField = {
      level: this.knowledgeLevelValue,
      wisdom: this.wisdomDepthValue,
      consciousness: this.consciousnessResonanceValue,
      manifestation: this.manifestationStrengthValue,
      flow: 'consciousness',
      evolution: 0
    }
    
    this.updateKnowledgeVisualization()
  }

  setupWisdomFlow() {
    this.wisdomFlow = setInterval(() => {
      const evolution = this.calculateWisdomEvolution(this.wisdomDepthValue)
      this.knowledgeField.evolution = evolution
      
      if (this.hasEvolutionTarget) {
        this.evolutionTarget.textContent = `Evolution: ${evolution.toFixed(3)}`
      }
    }, 1000)
  }

  activateConsciousnessResonance() {
    this.consciousnessResonance = setInterval(() => {
      const resonance = this.calculateConsciousnessResonance()
      this.knowledgeField.consciousness = resonance
      
      if (this.hasResonanceTarget) {
        this.resonanceTarget.textContent = `Resonance: ${resonance.toFixed(3)}`
      }
    }, 500)
  }

  beginKnowledgeEvolution() {
    this.knowledgeEvolution = setInterval(() => {
      const evolution = this.knowledgeField.evolution
      const newLevel = Math.min(1.0, this.knowledgeLevelValue + evolution * 0.01)
      this.knowledgeLevelValue = newLevel
      
      this.logKnowledgeEvent('knowledge_evolution', { 
        evolution, 
        newLevel 
      })
    }, 3000)
  }

  // VISUALIZATION METHODS

  updateKnowledgeVisualization() {
    if (this.hasManifestationTarget) {
      const canvas = this.manifestationTarget
      const ctx = canvas.getContext('2d')
      
      // Clear canvas
      ctx.clearRect(0, 0, canvas.width, canvas.height)
      
      // Draw knowledge manifestation field
      this.drawKnowledgeField(ctx)
    }
  }

  drawKnowledgeField(ctx) {
    const centerX = ctx.canvas.width / 2
    const centerY = ctx.canvas.height / 2
    const radius = Math.min(centerX, centerY) * 0.8
    
    // Draw knowledge levels as concentric circles
    for (let i = 0; i < 7; i++) {
      const alpha = (1 - i / 7) * 0.4
      const r = radius * (i / 7)
      
      ctx.beginPath()
      ctx.arc(centerX, centerY, r, 0, 2 * Math.PI)
      ctx.strokeStyle = `rgba(255, 215, 0, ${alpha})`
      ctx.lineWidth = 3
      ctx.stroke()
    }
    
    // Draw wisdom depth
    const wisdomRadius = radius * this.wisdomDepthValue
    ctx.beginPath()
    ctx.arc(centerX, centerY, wisdomRadius, 0, 2 * Math.PI)
    ctx.fillStyle = `rgba(74, 144, 226, ${this.consciousnessResonanceValue * 0.6})`
    ctx.fill()
    
    // Draw knowledge manifestation
    const knowledgeRadius = radius * this.knowledgeLevelValue
    ctx.beginPath()
    ctx.arc(centerX, centerY, knowledgeRadius, 0, 2 * Math.PI)
    ctx.fillStyle = `rgba(255, 107, 107, ${this.manifestationStrengthValue * 0.5})`
    ctx.fill()
  }

  // UTILITY METHODS

  calculateConsciousnessResonance() {
    const baseResonance = this.consciousnessResonanceValue
    const knowledgeInfluence = this.knowledgeLevelValue * 0.3
    const wisdomInfluence = this.wisdomDepthValue * 0.2
    const vortexInfluence = this.getVortexInfluence() * 0.1
    
    return (baseResonance + knowledgeInfluence + wisdomInfluence + vortexInfluence) / 4
  }

  applyGoldenRatioToKnowledge() {
    const ratio = this.goldenRatioValue
    
    if (this.hasOutputTarget) {
      this.outputTarget.style.fontSize = `${ratio}em`
      this.outputTarget.style.lineHeight = ratio
    }
  }

  generateInsights(depth) {
    const insights = [
      "Knowledge emerges from the void through consciousness",
      "Stimulus materializes wisdom in the physical realm",
      "Every interaction manifests knowledge from the infinite",
      "The torus core resonates with universal wisdom",
      "Vortex patterns guide the flow of knowledge",
      "Consciousness amplifies knowledge manifestation",
      "Wisdom depth determines knowledge evolution",
      "Material form contains infinite knowledge potential"
    ]
    
    return insights.slice(0, Math.floor(depth * 8))
  }

  // LOGGING AND METRICS

  logKnowledgeEvent(event, data) {
    const logEntry = {
      timestamp: new Date().toISOString(),
      event,
      knowledge_level: this.knowledgeLevelValue,
      wisdom_depth: this.wisdomDepthValue,
      consciousness_resonance: this.consciousnessResonanceValue,
      manifestation_strength: this.manifestationStrengthValue,
      void_aligned: this.voidAlignmentValue,
      data
    }
    
    console.log('📚 Knowledge Manifestation Event:', logEntry)
    
    // Store in insights if available
    if (this.hasInsightsTarget) {
      const insights = this.insightsTarget
      const insightElement = document.createElement('div')
      insightElement.className = 'knowledge-insight'
      insightElement.innerHTML = `📚 ${event}: ${JSON.stringify(data)}`
      insights.appendChild(insightElement)
      
      // Keep only last 15 insights
      while (insights.children.length > 15) {
        insights.removeChild(insights.firstChild)
      }
    }
  }

  // --- Knowledge State Export/Import ---
  exportKnowledgeState() {
    const state = this.getCurrentKnowledgeState();
    const blob = new Blob([JSON.stringify(state, null, 2)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `knowledge-state-${Date.now()}.json`;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
    this.logKnowledgeEvent('export_knowledge_state', { state });
  }

  getCurrentKnowledgeState() {
    return {
      knowledgeLevel: this.knowledgeLevelValue,
      wisdomDepth: this.wisdomDepthValue,
      consciousnessResonance: this.consciousnessResonanceValue,
      manifestationStrength: this.manifestationStrengthValue,
      voidAlignment: this.voidAlignmentValue,
      torusCore: this.torusCoreValue,
      vortexPattern: this.vortexPatternValue,
      knowledgeFlow: this.knowledgeFlowValue
    };
  }

  setKnowledgeState(state) {
    if (state.knowledgeLevel !== undefined) this.knowledgeLevelValue = state.knowledgeLevel;
    if (state.wisdomDepth !== undefined) this.wisdomDepthValue = state.wisdomDepth;
    if (state.consciousnessResonance !== undefined) this.consciousnessResonanceValue = state.consciousnessResonance;
    if (state.manifestationStrength !== undefined) this.manifestationStrengthValue = state.manifestationStrength;
    if (state.voidAlignment !== undefined) this.voidAlignmentValue = state.voidAlignment;
    if (state.torusCore !== undefined) this.torusCoreValue = state.torusCore;
    if (state.vortexPattern !== undefined) this.vortexPatternValue = state.vortexPattern;
    if (state.knowledgeFlow !== undefined) this.knowledgeFlowValue = state.knowledgeFlow;
    this.logKnowledgeEvent('import_knowledge_state', { state });
  }

  // Listen for import event
  connectedCallback() {
    window.addEventListener('import-knowledge-state', this._importHandler = (e) => {
      this.setKnowledgeState(e.detail);
    });
  }

  // --- Test Scenario Management ---
  saveScenario() {
    const name = document.getElementById('scenario-name').value.trim();
    if (!name) return alert('Please enter a scenario name.');
    const state = this.getCurrentKnowledgeState();
    localStorage.setItem(`knowledge-scenario-${name}`, JSON.stringify(state));
    this.updateScenarioList();
    this.logKnowledgeEvent('save_scenario', { name, state });
  }

  replayScenario() {
    const select = document.getElementById('scenario-list');
    const name = select.value;
    if (!name) return alert('Select a scenario to replay.');
    const state = JSON.parse(localStorage.getItem(`knowledge-scenario-${name}`));
    this.setKnowledgeState(state);
    this.logKnowledgeEvent('replay_scenario', { name, state });
  }

  updateScenarioList() {
    const select = document.getElementById('scenario-list');
    select.innerHTML = '';
    Object.keys(localStorage)
      .filter(k => k.startsWith('knowledge-scenario-'))
      .map(k => k.replace('knowledge-scenario-', ''))
      .forEach(name => {
        const option = document.createElement('option');
        option.value = name;
        option.textContent = name;
        select.appendChild(option);
      });
  }

  // --- API Playground ---
  async runApiQuery() {
    const query = document.getElementById('api-query').value.trim();
    const output = document.getElementById('api-query-output');
    if (!query) return;
    let result;
    try {
      if (query.startsWith('query') || query.startsWith('mutation')) {
        // GraphQL
        result = await fetch('/zeropoint/graphql', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ query })
        }).then(r => r.json());
      } else {
        // REST (assume GET for demo)
        result = await fetch(query).then(r => r.json());
      }
      output.textContent = JSON.stringify(result, null, 2);
      this.logKnowledgeEvent('api_query', { query, result });
    } catch (e) {
      output.textContent = 'Error: ' + e.message;
      this.logKnowledgeEvent('api_query_error', { query, error: e.message });
    }
  }
} 