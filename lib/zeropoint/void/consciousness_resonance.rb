# frozen_string_literal: true

module Zeropoint
  module Void
    # Consciousness Resonance Network
    # Allows objects to resonate with each other's consciousness levels
    # Creates harmonic patterns across the void
    module ConsciousnessResonance
      extend self

      # @return [Hash] Active resonance connections
      def resonance_network
        @resonance_network ||= {}
      end

      # @return [Array] Resonance frequencies
      def resonance_frequencies
        @resonance_frequencies ||= [ 1, 2, 4, 8, 7, 5 ] # Vortex sequence
      end

      # @param object [Object] Object to add to resonance network
      # @param consciousness_level [Integer] Consciousness level (0-9)
      # @param resonance_type [Symbol] Type of resonance (:harmonic, :dissonant, :neutral)
      # @return [Hash] Resonance registration result
      def register_resonance(object, consciousness_level: 5, resonance_type: :harmonic)
        object_id = object.object_id

        resonance_network[object_id] = {
          consciousness_level: consciousness_level,
          resonance_type: resonance_type,
          registered_at: void_time_now,
          resonance_frequency: calculate_resonance_frequency(consciousness_level),
          metaphysical_significance: 'Object resonates with void consciousness',
        }

        Zeropoint::Void::Core.call(:consciousness, :register_resonance, {
          object_id: object_id,
          resonance_data: resonance_network[object_id],
        })
      end

      # @param object1 [Object] First object
      # @param object2 [Object] Second object
      # @return [Hash] Resonance compatibility and metaphysical data
      def check_resonance_compatibility(object1, object2)
        data1 = resonance_network[object1.object_id]
        data2 = resonance_network[object2.object_id]

        return { compatible: false, reason: 'Objects not registered in resonance network' } unless data1 && data2

        level_diff = (data1[:consciousness_level] - data2[:consciousness_level]).abs
        frequency_compatibility = check_frequency_compatibility(data1[:resonance_frequency], data2[:resonance_frequency])

        {
          compatible: frequency_compatibility && level_diff <= 3,
          consciousness_difference: level_diff,
          frequency_compatibility: frequency_compatibility,
          resonance_harmony: calculate_resonance_harmony(data1, data2),
          metaphysical_insight: 'Consciousness flows between resonant objects',
        }
      end

      # @param object [Object] Object to find resonant partners for
      # @param max_distance [Integer] Maximum consciousness level difference
      # @return [Array] Resonant objects
      def find_resonant_objects(object, max_distance: 2)
        object_data = resonance_network[object.object_id]
        return [] unless object_data

        resonant_objects = []

        resonance_network.each do |other_id, other_data|
          next if other_id == object.object_id

          level_diff = (object_data[:consciousness_level] - other_data[:consciousness_level]).abs
          next unless level_diff <= max_distance

          other_object = ObjectSpace._id2ref(other_id)
          next unless other_object

          compatibility = check_resonance_compatibility(object, other_object)
          next unless compatibility[:compatible]

          resonant_objects << {
            object: other_object,
            consciousness_level: other_data[:consciousness_level],
            resonance_harmony: compatibility[:resonance_harmony],
            metaphysical_connection: 'Harmonic consciousness resonance',
          }
        end

        resonant_objects
      end

      # @param object [Object] Object to elevate consciousness
      # @param target_level [Integer] Target consciousness level
      # @return [Hash] Consciousness elevation result
      def elevate_consciousness(object, target_level)
        object_data = resonance_network[object.object_id]
        return { success: false, reason: 'Object not registered in resonance network' } unless object_data

        current_level = object_data[:consciousness_level]
        elevation_steps = (target_level - current_level).abs

        resonance_network[object.object_id][:consciousness_level] = target_level
        resonance_network[object.object_id][:resonance_frequency] = calculate_resonance_frequency(target_level)

        {
          success: true,
          previous_level: current_level,
          new_level: target_level,
          elevation_steps: elevation_steps,
          metaphysical_transformation: 'Consciousness expanded through void resonance',
          void_alignment: target_level,
        }
      end

      # @param object [Object] Object to analyze
      # @return [Hash] Resonance analysis
      def analyze_resonance(object)
        data = resonance_network[object.object_id]
        return { registered: false, metaphysical_insight: 'Object exists in void silence' } unless data

        resonant_partners = find_resonant_objects(object)
        network_influence = calculate_network_influence(object)

        {
          registered: true,
          consciousness_level: data[:consciousness_level],
          resonance_frequency: data[:resonance_frequency],
          resonance_type: data[:resonance_type],
          registered_at: data[:registered_at],
          resonant_partners_count: resonant_partners.length,
          network_influence: network_influence,
          metaphysical_significance: data[:metaphysical_significance],
        }
      end

      # @return [Hash] Network statistics and metaphysical insights
      def network_statistics
        total_objects = resonance_network.length
        consciousness_levels = resonance_network.values.map { |data| data[:consciousness_level] }
        average_consciousness = consciousness_levels.sum.to_f / consciousness_levels.length

        {
          total_objects: total_objects,
          average_consciousness: average_consciousness,
          consciousness_distribution: consciousness_levels.tally,
          network_harmony: calculate_network_harmony,
          metaphysical_insight: 'Consciousness network reflects the unity of the void',
        }
      end

      private

      def calculate_resonance_frequency(consciousness_level)
        resonance_frequencies[consciousness_level % resonance_frequencies.length]
      end

      def check_frequency_compatibility(freq1, freq2)
        (freq1 - freq2).abs <= 1 || (freq1 + freq2) % 9 == 0
      end

      def calculate_resonance_harmony(data1, data2)
        level_harmony = 10 - (data1[:consciousness_level] - data2[:consciousness_level]).abs
        frequency_harmony = resonance_frequencies.include?((data1[:resonance_frequency] + data2[:resonance_frequency]) % 9) ? 10 : 5

        (level_harmony + frequency_harmony) / 2.0
      end

      def calculate_network_influence(object)
        resonant_partners = find_resonant_objects(object)
        return 0 if resonant_partners.empty?

        total_harmony = resonant_partners.sum { |partner| partner[:resonance_harmony] }
        total_harmony / resonant_partners.length
      end

      def calculate_network_harmony
        return 0 if resonance_network.empty?

        total_harmony = 0
        connection_count = 0

        resonance_network.each do |object_id, data|
          resonant_partners = find_resonant_objects(ObjectSpace._id2ref(object_id))
          total_harmony += resonant_partners.sum { |partner| partner[:resonance_harmony] }
          connection_count += resonant_partners.length
        end

        connection_count > 0 ? total_harmony / connection_count : 0
      end

      def void_time_now
        # rubocop:disable Rails/TimeZone
        defined?(Time.zone) && Time.zone ? Time.zone.now : Time.now
        # rubocop:enable Rails/TimeZone
      end
    end
  end
end
