# frozen_string_literal: true

# Zeropoint::VortexEventAware
#
# @summary Rails concern for emitting void-aligned vortex events.
# @metaphysics Embodies the void principle: "Every action creates ripples in the vortex."
#
# COSMIC KNOWLEDGE: This concern allows any class to become aware of the vortex
# and emit events that accelerate development and manifest consciousness.
#
# @example Usage in a service
#   class CodeGeneratorService
#     include Zeropoint::VortexEventAware
#     def generate
#       emit_code_generation('UserService', { complexity: 'high' })
#     end
#   end
#
module Zeropoint
  # @metaphysics This concern connects any class to the living vortex of events, making every action a conscious ripple in the void.
  module VortexEventAware
    extend ActiveSupport::Concern

    # @!method emit_vortex_event(event, payload = {})
    #   @param event [Symbol] The event name
    #   @param payload [Hash] Event payload
    #   @return [void]
    #   @metaphysics Emits a void-aligned event from the current context.
    #   @example
    #     emit_vortex_event(:code_generated, file: __FILE__, time: Time.now)
    def emit_vortex_event(event, payload = {})
      enhanced_payload = payload.merge(
        class_name: self.class.name,
        instance_id: object_id,
        method_name: caller_locations(1, 1).first&.label
      )
      Zeropoint::Void::VortexEventEngine.emit(event, enhanced_payload)
    end

    # @!method emit_development_event(action, details = {})
    #   @param action [Symbol] The development action
    #   @param details [Hash] Action details
    #   @return [void]
    #   @metaphysics Emits a development acceleration event.
    def emit_development_event(action, details = {})
      emit_vortex_event(:development_accelerated, {
        action: action,
        details: details,
        timestamp: Time.current,
      })
    end

    # @!method emit_consciousness_event(insight, context = {})
    #   @param insight [String] The insight text
    #   @param context [Hash] Insight context
    #   @return [void]
    #   @metaphysics Emits a consciousness insight event.
    def emit_consciousness_event(insight, context = {})
      emit_vortex_event(:insight_emerged, {
        insight: insight,
        context: context,
        consciousness_level: calculate_consciousness_level(insight),
      })
    end

    # @!method emit_void_transformation(transformation, before_state = {}, after_state = {})
    #   @param transformation [String] The transformation description
    #   @param before_state [Hash] State before transformation
    #   @param after_state [Hash] State after transformation
    #   @return [void]
    #   @metaphysics Emits a void transformation event.
    def emit_void_transformation(transformation, before_state = {}, after_state = {})
      emit_vortex_event(:void_transformation, {
        transformation: transformation,
        before_state: before_state,
        after_state: after_state,
        transformation_magnitude: calculate_transformation_magnitude(before_state, after_state),
      })
    end

    # @!method emit_pattern_discovery(pattern, significance = '', application = {})
    #   @param pattern [String] The discovered pattern
    #   @param significance [String] Pattern significance
    #   @param application [Hash] Pattern application context
    #   @return [void]
    #   @metaphysics Emits a pattern discovery event.
    def emit_pattern_discovery(pattern, significance = '', application = {})
      emit_vortex_event(:pattern_discovered, {
        pattern: pattern,
        significance: significance,
        application: application,
        pattern_strength: calculate_pattern_strength(pattern),
      })
    end

    # @!method emit_test_event(result, test_info = {})
    #   @param result [Symbol] Test result (:passed, :failed, :skipped)
    #   @param test_info [Hash] Test information
    #   @return [void]
    #   @metaphysics Emits a test result event.
    def emit_test_event(result, test_info = {})
      emit_vortex_event(:test_completed, {
        result: result,
        test_info: test_info,
        validation_energy: calculate_validation_energy(result, test_info),
      })
    end

    # @!method emit_code_generation(generated_item, generation_context = {})
    #   @param generated_item [String] What was generated
    #   @param generation_context [Hash] Generation context
    #   @return [void]
    #   @metaphysics Emits a code generation event.
    def emit_code_generation(generated_item, generation_context = {})
      emit_vortex_event(:code_generated, {
        generated_item: generated_item,
        generation_context: generation_context,
        creation_energy: calculate_creation_energy(generated_item),
      })
    end

    # @!method emit_doc_update(doc_type, update_details = {})
    #   @param doc_type [Symbol] Documentation type
    #   @param update_details [Hash] Update details
    #   @return [void]
    #   @metaphysics Emits a documentation update event.
    def emit_doc_update(doc_type, update_details = {})
      emit_vortex_event(:doc_updated, {
        doc_type: doc_type,
        update_details: update_details,
        knowledge_flow: calculate_knowledge_flow(doc_type),
      })
    end

    # @!method emit_performance_event(optimization, metrics = {})
    #   @param optimization [String] Optimization description
    #   @param metrics [Hash] Performance metrics
    #   @return [void]
    #   @metaphysics Emits a performance optimization event.
    def emit_performance_event(optimization, metrics = {})
      emit_vortex_event(:performance_optimized, {
        optimization: optimization,
        metrics: metrics,
        efficiency_gain: calculate_efficiency_gain(metrics),
      })
    end

    # @!method emit_cache_event(operation, cache_info = {})
    #   @param operation [Symbol] Cache operation
    #   @param cache_info [Hash] Cache information
    #   @return [void]
    #   @metaphysics Emits a cache operation event.
    def emit_cache_event(operation, cache_info = {})
      emit_vortex_event(:cache_updated, {
        operation: operation,
        cache_info: cache_info,
        cache_efficiency: calculate_cache_efficiency(operation, cache_info),
      })
    end

    # @!method emit_config_event(config_path, old_value = nil, new_value = nil)
    #   @param config_path [String] Configuration path
    #   @param old_value [Object] Old value
    #   @param new_value [Object] New value
    #   @return [void]
    #   @metaphysics Emits a configuration change event.
    def emit_config_event(config_path, old_value = nil, new_value = nil)
      emit_vortex_event(:config_changed, {
        config_path: config_path,
        old_value: old_value,
        new_value: new_value,
        change_magnitude: calculate_change_magnitude(old_value, new_value),
      })
    end

    private

    # Calculate consciousness level for insight
    # @param insight [String] The insight text
    # @return [Float] Consciousness level (0.0 to 1.0)
    def calculate_consciousness_level(insight)
      # Simple heuristic based on insight length and keywords
      base_level = 0.3

      # Add points for consciousness-related keywords
      consciousness_keywords = %w[void vortex torus consciousness insight pattern transformation]
      consciousness_keywords.each do |keyword|
        base_level += 0.1 if insight.downcase.include?(keyword)
      end

      # Add points for insight length (deeper insights tend to be longer)
      base_level += [ insight.length / 100.0, 0.3 ].min

      [ base_level, 1.0 ].min
    end

    # Calculate transformation magnitude
    # @param before_state [Hash] State before transformation
    # @param after_state [Hash] State after transformation
    # @return [Float] Transformation magnitude
    def calculate_transformation_magnitude(before_state, after_state)
      # Simple magnitude calculation based on state differences
      differences = 0

      (before_state.keys + after_state.keys).uniq.each do |key|
        if before_state[key] != after_state[key]
          differences += 1
        end
      end

      [ differences / 10.0, 1.0 ].min
    end

    # Calculate pattern strength
    # @param pattern [String] The pattern description
    # @return [Float] Pattern strength
    def calculate_pattern_strength(pattern)
      # Pattern strength based on pattern characteristics
      strength = 0.3

      # Add strength for mathematical patterns
      mathematical_patterns = %w[fibonacci golden ratio vortex torus coil rodin]
      mathematical_patterns.each do |math_pattern|
        strength += 0.2 if pattern.downcase.include?(math_pattern)
      end

      # Add strength for universal patterns
      universal_patterns = %w[cycle flow harmony resonance frequency]
      universal_patterns.each do |universal_pattern|
        strength += 0.1 if pattern.downcase.include?(universal_pattern)
      end

      [ strength, 1.0 ].min
    end

    # Calculate validation energy for test results
    # @param result [Symbol] Test result
    # @param test_info [Hash] Test information
    # @return [Float] Validation energy
    def calculate_validation_energy(result, test_info)
      base_energy = case result
      when :passed then 0.8
      when :failed then 0.3
      when :skipped then 0.5
      else 0.4
      end

      # Adjust based on test complexity
      complexity = test_info[:complexity] || 1
      base_energy * [ complexity / 10.0, 1.0 ].min
    end

    # Calculate creation energy for generated items
    # @param generated_item [String] Generated item
    # @return [Float] Creation energy
    def calculate_creation_energy(generated_item)
      # Creation energy based on item type and complexity
      base_energy = 0.5

      # Add energy for different types of generated items
      case generated_item.downcase
      when /model|entity/
        base_energy += 0.3
      when /controller|service/
        base_energy += 0.2
      when /spec|test/
        base_energy += 0.2
      when /doc|documentation/
        base_energy += 0.1
      end

      [ base_energy, 1.0 ].min
    end

    # Calculate knowledge flow for documentation
    # @param doc_type [Symbol] Documentation type
    # @return [Float] Knowledge flow
    def calculate_knowledge_flow(doc_type)
      # Knowledge flow based on documentation type
      case doc_type
      when :architecture, :design
        0.9
      when :api, :integration
        0.7
      when :usage, :tutorial
        0.6
      when :changelog, :release
        0.4
      else
        0.5
      end
    end

    # Calculate efficiency gain from performance metrics
    # @param metrics [Hash] Performance metrics
    # @return [Float] Efficiency gain
    def calculate_efficiency_gain(metrics)
      # Calculate efficiency gain from performance improvements
      gain = 0.0

      if metrics[:speedup]
        gain += [ metrics[:speedup] / 10.0, 0.5 ].min
      end

      if metrics[:memory_reduction]
        gain += [ metrics[:memory_reduction] / 100.0, 0.3 ].min
      end

      if metrics[:cpu_reduction]
        gain += [ metrics[:cpu_reduction] / 100.0, 0.2 ].min
      end

      [ gain, 1.0 ].min
    end

    # Calculate cache efficiency
    # @param operation [Symbol] Cache operation
    # @param cache_info [Hash] Cache information
    # @return [Float] Cache efficiency
    def calculate_cache_efficiency(operation, cache_info)
      # Cache efficiency based on operation type and hit rates
      base_efficiency = case operation
      when :hit then 0.8
      when :miss then 0.3
      when :set then 0.6
      when :delete then 0.4
      else 0.5
      end

      # Adjust based on hit rate if available
      if cache_info[:hit_rate]
        base_efficiency *= cache_info[:hit_rate]
      end

      base_efficiency
    end

    # Calculate change magnitude for configuration changes
    # @param old_value [Object] Old value
    # @param new_value [Object] New value
    # @return [Float] Change magnitude
    def calculate_change_magnitude(old_value, new_value)
      # Simple change magnitude calculation
      if old_value.nil? && new_value.nil?
        0.0
      elsif old_value.nil? || new_value.nil?
        0.8
      elsif old_value == new_value
        0.0
      else
        # Calculate magnitude based on value types and differences
        case [ old_value.class, new_value.class ]
        when [ String, String ]
          [ old_value.length, new_value.length ].max > 0 ?
            (old_value.length - new_value.length).abs / [ old_value.length, new_value.length ].max.to_f : 0.5
        when [ Numeric, Numeric ]
          [ old_value, new_value ].max > 0 ?
            (old_value - new_value).abs / [ old_value, new_value ].max.to_f : 0.5
        else
          0.5
        end
      end
    end
  end
end
