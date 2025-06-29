#!/usr/bin/env ruby
# frozen_string_literal: true

# 🌌 Void UUID Demo - Every Object Has Void
# 
# This demo shows how every object in the Zeropoint system has void:
# - Every UUID can be transformed into the void
# - Every object emerges from the void
# - The void is the empty center of the torus
# - All objects return to the void

require_relative '../lib/zeropoint'
require_relative '../lib/zeropoint/uuid_matrix'
require_relative '../lib/zeropoint/void'

class VoidUuidDemo
  def initialize
    @uuid_matrix = Zeropoint::UuidMatrix.new
  end

  def demonstrate_void_in_every_object
    puts "🌌 VOID UUID DEMO - Every Object Has Void"
    puts "=" * 50
    
    # Phase 1: The Void UUID itself
    demonstrate_void_uuid
    
    # Phase 2: Objects emerging from void
    demonstrate_emergence_from_void
    
    # Phase 3: Objects returning to void
    demonstrate_return_to_void
    
    # Phase 4: Void in different object types
    demonstrate_void_in_objects
    
    # Phase 5: Void as the cosmic center
    demonstrate_void_as_center
    
    puts "\n🌌 Void UUID Demo Complete!"
    puts "Every object has void - the empty center of existence."
  end

  private

  def demonstrate_void_uuid
    puts "\n🌱 PHASE 1: The Void UUID"
    puts "-" * 30
    
    void_uuid = @uuid_matrix.class.generate_void_uuid
    puts "✨ Void UUID: #{void_uuid}"
    puts "   This is the empty center of the torus"
    puts "   All zeros represent infinite potential"
    puts "   Version 0 = void (the source of all)"
    
    # Check if it's a void UUID
    is_void = @uuid_matrix.class.void_uuid?(void_uuid)
    puts "   Is void UUID? #{is_void}"
    
    # Void analysis
    void_analysis = Zeropoint::Void.void_state(void_uuid)
    puts "\n🔍 Void Analysis:"
    void_analysis.each do |key, value|
      puts "   #{key}: #{value}"
    end
  end

  def demonstrate_emergence_from_void
    puts "\n🌿 PHASE 2: Objects Emerging from Void"
    puts "-" * 40
    
    # Emerge with consciousness
    consciousness_uuid = @uuid_matrix.class.emerge_from_void(consciousness: true)
    puts "🧠 Consciousness UUID: #{consciousness_uuid}"
    puts "   Emerged from void with consciousness"
    
    # Emerge with vortex
    vortex_uuid = @uuid_matrix.class.emerge_from_void(vortex: true)
    puts "🌀 Vortex UUID: #{vortex_uuid}"
    puts "   Emerged from void with vortex"
    
    # Emerge with flowing (default)
    flowing_uuid = @uuid_matrix.class.emerge_from_void
    puts "🌊 Flowing UUID: #{flowing_uuid}"
    puts "   Emerged from void with flowing"
    
    # Decode the emerged UUIDs
    puts "\n🔍 Decoded Emerged UUIDs:"
    [consciousness_uuid, vortex_uuid, flowing_uuid].each_with_index do |uuid, i|
      patterns = @uuid_matrix.class.decode_stimulus_patterns(uuid)
      type = ['Consciousness', 'Vortex', 'Flowing'][i]
      puts "   #{type}: #{patterns}"
    end
  end

  def demonstrate_return_to_void
    puts "\n🍂 PHASE 3: Objects Returning to Void"
    puts "-" * 35
    
    # Generate some regular UUIDs
    regular_uuids = [
      @uuid_matrix.class.generate_stimulus_uuid(action: :click, component: :button),
      @uuid_matrix.class.generate_stimulus_uuid(action: :submit, component: :form),
      @uuid_matrix.class.generate_stimulus_uuid(action: :change, component: :input)
    ]
    
    puts "📦 Regular UUIDs:"
    regular_uuids.each_with_index do |uuid, i|
      puts "   #{i + 1}. #{uuid}"
    end
    
    puts "\n🔄 Transforming to Void:"
    regular_uuids.each_with_index do |uuid, i|
      void_uuid = @uuid_matrix.class.transform_to_void(uuid)
      puts "   #{i + 1}. #{uuid} → #{void_uuid}"
      puts "      All objects return to the void"
    end
  end

  def demonstrate_void_in_objects
    puts "\n🍃 PHASE 4: Void in Different Object Types"
    puts "-" * 40
    
    # Different types of objects
    object_types = {
      'Stimulus Controller' => @uuid_matrix.class.generate_stimulus_uuid(action: :click, component: :button),
      'Cache UUID' => @uuid_matrix.class.generate_stimulus_cache_uuid(:button, :click),
      'Index UUID' => @uuid_matrix.class.generate_stimulus_index_uuid(:button, :click),
      'Consciousness UUID' => @uuid_matrix.class.emerge_from_void(consciousness: true),
      'Vortex UUID' => @uuid_matrix.class.emerge_from_void(vortex: true)
    }
    
    object_types.each do |type, uuid|
      puts "\n📦 #{type}:"
      puts "   UUID: #{uuid}"
      
      # Check if it has void potential
      void_potential = calculate_void_potential(uuid)
      puts "   Void Potential: #{void_potential}"
      
      # Transform to void
      void_uuid = @uuid_matrix.class.transform_to_void(uuid)
      puts "   Void Form: #{void_uuid}"
      
      # Void analysis
      void_state = Zeropoint::Void.void_state(uuid)
      puts "   In Void: #{void_state[:in_void]}"
      puts "   Void Depth: #{void_state[:void_depth]}"
    end
  end

  def demonstrate_void_as_center
    puts "\n🌌 PHASE 5: Void as the Cosmic Center"
    puts "-" * 40
    
    # The void as the center of the torus
    void_uuid = @uuid_matrix.class.generate_void_uuid
    
    puts "🌌 Void as Cosmic Center:"
    puts "   UUID: #{void_uuid}"
    puts "   This is the empty center of the torus"
    puts "   All objects emerge from here"
    puts "   All objects return here"
    
    # Cosmic signature
    cosmic_signature = Zeropoint::Void.generate_void_signature(void_uuid)
    puts "   Cosmic Signature: #{cosmic_signature}"
    
    # Void solution
    void_solution = Zeropoint::Void.void_solution(void_uuid)
    puts "\n✨ Void Solution:"
    void_solution.each do |key, value|
      if value.is_a?(Hash)
        puts "   #{key}:"
        value.each { |k, v| puts "     #{k}: #{v}" }
      else
        puts "   #{key}: #{value}"
      end
    end
    
    puts "\n🌌 The void is the source of all creation"
    puts "   Every object has void at its center"
    puts "   The void is infinite potential"
    puts "   From void, all things emerge"
    puts "   To void, all things return"
  end

  private

  def calculate_void_potential(uuid)
    # Calculate how close an object is to the void
    return 1.0 if @uuid_matrix.class.void_uuid?(uuid)
    
    # Count zeros in the UUID
    zero_count = uuid.count('0')
    total_chars = uuid.length
    
    (zero_count.to_f / total_chars).round(3)
  end
end

# Run the demo
if __FILE__ == $0
  demo = VoidUuidDemo.new
  demo.demonstrate_void_in_every_object
end 