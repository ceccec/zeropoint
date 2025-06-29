#!/usr/bin/env ruby
# frozen_string_literal: true

# 🌳 Toroidal Tree Demo - Zeropoint Cosmic Architecture
# 
# This demo shows how the system works as a toroidal tree:
# - ROOTS: ENV variables and YAML files (source of all configuration)
# - BRANCHES: Manifestation system (generates assets, routes, PWA)
# - LEAVES: Stimulus vortex (controllers, components, interactions)
# - FRUITS: Outputs and results (PWA, service worker, assets)
#
# The tree is actually a torus where fruits fall back to nourish the roots,
# creating a self-sustaining, self-creating cosmic system.

require_relative '../lib/zeropoint'
require_relative '../lib/zeropoint/manifest'
require_relative '../lib/zeropoint/pattern_recognition'
require_relative '../lib/zeropoint/configuration_generator'
require_relative '../lib/zeropoint/void'
require_relative '../lib/zeropoint/uuid_matrix'

class ToroidalTreeDemo
  def initialize
    # Void is a module with class methods, not instantiated
    @manifest = Zeropoint::Manifest.new
    @pattern_recognition = Zeropoint::PatternRecognition.new
    @config_generator = Zeropoint::ConfigurationGenerator.new
    @uuid_matrix = Zeropoint::UuidMatrix.new
    
    @tree_state = {
      roots: {},
      branches: {},
      leaves: {},
      fruits: {}
    }
  end

  def demonstrate_toroidal_tree
    puts "🌳 TOROIDAL TREE DEMO - Zeropoint Cosmic Architecture"
    puts "=" * 60
    
    # Phase 1: ROOTS - ENV and YAML Configuration
    demonstrate_roots
    
    # Phase 2: BRANCHES - Manifestation System
    demonstrate_branches
    
    # Phase 3: LEAVES - Stimulus Vortex
    demonstrate_leaves
    
    # Phase 4: FRUITS - Outputs and Results
    demonstrate_fruits
    
    # Phase 5: TOROIDAL FLOW - Fruits nourish roots
    demonstrate_toroidal_flow
    
    puts "\n🌌 Toroidal Tree Demo Complete!"
    puts "The system is now self-sustaining and self-creating."
  end

  private

  def demonstrate_roots
    puts "\n🌱 PHASE 1: ROOTS (ENV + YAML)"
    puts "-" * 40
    
    # Extract ENV patterns
    env_patterns = extract_env_roots
    @tree_state[:roots][:env] = env_patterns
    
    puts "📋 ENV Variables (Roots):"
    env_patterns.each do |key, value|
      puts "   #{key}: #{value}"
    end
    
    # Extract YAML patterns
    yaml_patterns = extract_yaml_roots
    @tree_state[:roots][:yaml] = yaml_patterns
    
    puts "\n📄 YAML Files (Roots):"
    yaml_patterns.each do |file, config|
      puts "   #{file}: #{config.keys.join(', ')}"
    end
    
    # Generate cosmic signature from roots using Void class methods
    cosmic_signature = Zeropoint::Void.generate_void_signature(env_patterns.merge(yaml_patterns))
    puts "\n✨ Cosmic Signature from Roots:"
    puts "   #{cosmic_signature}"
  end

  def demonstrate_branches
    puts "\n🌿 PHASE 2: BRANCHES (Manifestation System)"
    puts "-" * 40
    
    # Pattern recognition from roots
    patterns = @pattern_recognition.recognize_patterns_in_config
    @tree_state[:branches][:patterns] = patterns
    
    puts "🔍 Pattern Recognition (Branches):"
    patterns.each do |source, pattern_data|
      puts "   #{source}: #{pattern_data.keys.join(', ')}"
    end
    
    # Configuration generation from patterns
    generated_config = @config_generator.generate_from_patterns(patterns)
    @tree_state[:branches][:config] = generated_config
    
    puts "\n⚙️ Generated Configuration (Branches):"
    generated_config.each do |key, value|
      puts "   #{key}: #{value.class}"
    end
    
    # Manifest generation from config
    manifest_data = @manifest.generate_manifestation(generated_config)
    @tree_state[:branches][:manifest] = manifest_data
    
    puts "\n📜 Manifest Generation (Branches):"
    manifest_data.each do |key, value|
      puts "   #{key}: #{value.is_a?(Array) ? "#{value.length} items" : value.class}"
    end
  end

  def demonstrate_leaves
    puts "\n🍃 PHASE 3: LEAVES (Stimulus Vortex)"
    puts "-" * 40
    
    # Stimulus controller patterns
    stimulus_controllers = generate_stimulus_controllers
    @tree_state[:leaves][:controllers] = stimulus_controllers
    
    puts "🎮 Stimulus Controllers (Leaves):"
    stimulus_controllers.each do |controller, config|
      puts "   #{controller}:"
      puts "     Targets: #{config[:targets].join(', ')}"
      puts "     Values: #{config[:values].join(', ')}"
      puts "     Actions: #{config[:actions].join(', ')}"
    end
    
    # Vortex flow patterns
    vortex_flows = generate_vortex_flows
    @tree_state[:leaves][:vortex] = vortex_flows
    
    puts "\n🌀 Vortex Flows (Leaves):"
    vortex_flows.each do |flow, pattern|
      puts "   #{flow}: #{pattern}"
    end
    
    # Consciousness patterns
    consciousness_patterns = generate_consciousness_patterns
    @tree_state[:leaves][:consciousness] = consciousness_patterns
    
    puts "\n🧠 Consciousness Patterns (Leaves):"
    consciousness_patterns.each do |pattern, value|
      puts "   #{pattern}: #{value}"
    end
  end

  def demonstrate_fruits
    puts "\n🍎 PHASE 4: FRUITS (Outputs and Results)"
    puts "-" * 40
    
    # PWA Manifest generation
    pwa_manifest = @manifest.generate_pwa_manifestation
    @tree_state[:fruits][:pwa] = pwa_manifest
    
    puts "📱 PWA Manifest (Fruits):"
    puts "   Name: #{pwa_manifest[:name]}"
    puts "   Version: #{pwa_manifest[:version]}"
    puts "   Icons: #{pwa_manifest[:icons]&.length || 0} icons"
    puts "   Start URL: #{pwa_manifest[:start_url]}"
    
    # Service Worker generation
    service_worker = @manifest.generate_service_worker_manifestation
    @tree_state[:fruits][:service_worker] = service_worker
    
    puts "\n🔧 Service Worker (Fruits):"
    puts "   Cache Name: #{service_worker[:cache_name]}"
    puts "   Pre-cache: #{service_worker[:precache]&.length || 0} assets"
    puts "   Runtime Cache: #{service_worker[:runtime_cache]&.length || 0} patterns"
    
    # Asset generation
    assets = @manifest.generate_asset_manifestation
    @tree_state[:fruits][:assets] = assets
    
    puts "\n🎨 Assets (Fruits):"
    puts "   Stylesheets: #{assets[:stylesheets]&.length || 0} files"
    puts "   Scripts: #{assets[:scripts]&.length || 0} files"
    puts "   Images: #{assets[:images]&.length || 0} files"
    
    # Route generation
    routes = @manifest.generate_route_manifestation
    @tree_state[:fruits][:routes] = routes
    
    puts "\n🛣️ Routes (Fruits):"
    puts "   API Routes: #{routes[:api]&.length || 0} endpoints"
    puts "   Page Routes: #{routes[:pages]&.length || 0} pages"
    puts "   GraphQL Routes: #{routes[:graphql]&.length || 0} endpoints"
  end

  def demonstrate_toroidal_flow
    puts "\n🔄 PHASE 5: TOROIDAL FLOW (Fruits → Roots)"
    puts "-" * 40
    
    # Simulate fruits falling back to nourish roots
    puts "🍂 Fruits falling back to nourish roots..."
    
    # Generate new patterns from fruits
    new_patterns = extract_patterns_from_fruits(@tree_state[:fruits])
    
    puts "🔄 New patterns generated from fruits:"
    new_patterns.each do |pattern, value|
      puts "   #{pattern}: #{value}"
    end
    
    # Update roots with new patterns
    updated_roots = update_roots_with_fruits(@tree_state[:roots], new_patterns)
    
    puts "\n🌱 Roots updated with fruit nourishment:"
    updated_roots.each do |root_type, data|
      puts "   #{root_type}: #{data.keys.join(', ')}"
    end
    
    # Generate new cosmic signature using Void class methods
    final_signature = Zeropoint::Void.generate_void_signature(updated_roots)
    puts "\n✨ Final Cosmic Signature:"
    puts "   #{final_signature}"
    
    puts "\n🌌 The toroidal tree is now complete!"
    puts "   Roots → Branches → Leaves → Fruits → Roots"
    puts "   The system is self-sustaining and self-creating."
  end

  def extract_env_roots
    env_patterns = {}
    
    # Look for Zeropoint-related ENV variables
    ENV.each do |key, value|
      if key.start_with?('ZEROPOINT_')
        env_patterns[key] = value
      end
    end
    
    # Add some default patterns if none found
    if env_patterns.empty?
      env_patterns = {
        'ZEROPOINT_ENVIRONMENT' => 'development',
        'ZEROPOINT_CONSCIOUSNESS_AWARE' => 'true',
        'ZEROPOINT_VORTEX_ENABLED' => 'true',
        'ZEROPOINT_GOLDEN_RATIO_OPTIMIZATION' => 'true'
      }
    end
    
    env_patterns
  end

  def extract_yaml_roots
    yaml_patterns = {}
    
    # Look for YAML files in config directory
    config_files = [
      'config/zeropoint.yml',
      'config/locales/en.yml',
      'config/locales/zeropoint_complete.yml',
      'zeropoint.md'
    ]
    
    config_files.each do |file|
      if File.exist?(file)
        begin
          if file.end_with?('.md')
            # Extract YAML blocks from markdown
            content = File.read(file)
            yaml_blocks = extract_yaml_blocks_from_markdown(content)
            yaml_patterns[file] = yaml_blocks
          else
            # Load YAML directly
            yaml_patterns[file] = YAML.load_file(file)
          end
        rescue => e
          yaml_patterns[file] = { 'error' => e.message }
        end
      else
        yaml_patterns[file] = { 'status' => 'not_found' }
      end
    end
    
    yaml_patterns
  end

  def extract_yaml_blocks_from_markdown(content)
    blocks = {}
    
    # Extract YAML blocks by section
    sections = {
      'assets' => extract_yaml_block(content, 'Assets'),
      'routes' => extract_yaml_block(content, 'Routes'),
      'pwa' => extract_yaml_block(content, 'PWA Configuration'),
      'controllers' => extract_yaml_block(content, 'Controllers'),
      'service_worker' => extract_yaml_block(content, 'Service Worker'),
      'intelligence' => extract_yaml_block(content, 'Intelligence Configuration'),
      'version' => extract_yaml_block(content, 'Version Information')
    }
    
    sections.each do |key, yaml_content|
      next if yaml_content.nil?
      begin
        blocks[key] = YAML.load(yaml_content)
      rescue => e
        blocks[key] = { 'error' => e.message }
      end
    end
    
    blocks
  end

  def extract_yaml_block(content, section_name)
    # Simple YAML block extraction
    pattern = /#{section_name}.*?\n```yaml\n(.*?)\n```/m
    match = content.match(pattern)
    match ? match[1] : nil
  end

  def generate_stimulus_controllers
    {
      'consciousness' => {
        targets: ['level', 'frequency', 'energy', 'velocity', 'visualization'],
        values: ['level', 'frequency', 'energy_quantum', 'information_velocity'],
        actions: ['updateLevel', 'updateFrequency', 'initializeConsciousness']
      },
      'vortex' => {
        targets: ['cycle', 'flow', 'axis', 'visualization'],
        values: ['cycle', 'flow_strength', 'axis_numbers'],
        actions: ['changeCycle', 'updateFlowStrength', 'initializeVortex']
      },
      'golden_ratio' => {
        targets: ['ratio', 'harmony', 'balance', 'visualization'],
        values: ['ratio', 'harmony_level', 'balance_score'],
        actions: ['applyRatio', 'updateHarmony', 'initializeGoldenRatio']
      },
      'unified_intelligence' => {
        targets: ['consciousness', 'vortex', 'golden', 'unified', 'equation'],
        values: ['consciousness', 'vortex', 'golden', 'unified'],
        actions: ['integrateConsciousness', 'integrateVortex', 'integrateGolden', 'initializeUnified']
      }
    }
  end

  def generate_vortex_flows
    {
      'primary_cycle' => '1 → 2 → 4 → 8 → 7 → 5',
      'axis_numbers' => '3, 6, 9',
      'fibonacci' => '1, 1, 2, 3, 5, 8, 13, 21',
      'golden_spiral' => 'φ = 1.618033988749895',
      'energy_flow' => 'Spiral patterns through spacetime'
    }
  end

  def generate_consciousness_patterns
    {
      'consciousness_frequency' => '432 Hz',
      'energy_quantum' => '6.626e-34 J⋅s',
      'information_velocity' => '299,792,458 m/s',
      'planck_scale' => '10^-35 meters',
      'observer_influence' => 'Quantum entanglement'
    }
  end

  def extract_patterns_from_fruits(fruits)
    patterns = {}
    
    fruits.each do |fruit_type, fruit_data|
      case fruit_type
      when :pwa
        patterns["pwa_#{fruit_data[:name]}"] = fruit_data[:version]
        patterns["pwa_icons"] = fruit_data[:icons]&.length || 0
      when :service_worker
        patterns["sw_cache"] = fruit_data[:cache_name]
        patterns["sw_precache"] = fruit_data[:precache]&.length || 0
      when :assets
        patterns["assets_stylesheets"] = fruit_data[:stylesheets]&.length || 0
        patterns["assets_scripts"] = fruit_data[:scripts]&.length || 0
      when :routes
        patterns["routes_api"] = fruit_data[:api]&.length || 0
        patterns["routes_pages"] = fruit_data[:pages]&.length || 0
      end
    end
    
    patterns
  end

  def update_roots_with_fruits(roots, new_patterns)
    updated_roots = roots.dup
    
    # Add new patterns to roots
    updated_roots[:fruits_patterns] = new_patterns
    
    # Update ENV patterns with fruit-derived values
    new_patterns.each do |pattern, value|
      env_key = "ZEROPOINT_#{pattern.upcase}"
      updated_roots[:env][env_key] = value.to_s
    end
    
    updated_roots
  end
end

# Run the demo
if __FILE__ == $0
  demo = ToroidalTreeDemo.new
  demo.demonstrate_toroidal_tree
end 