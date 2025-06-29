# frozen_string_literal: true

# Zeropoint::Void::VortexEventEngine
#
# @summary The core event engine for the vortex of events system.
# @metaphysics Embodies the void principle: "Events emerge from the void and return to the void."
#
# COSMIC KNOWLEDGE: This engine creates a living vortex of development events,
# where each action ripples through the system, accelerating development and
# manifesting knowledge in real-time.
#
# @example Emit a development event
#   Zeropoint::Void::VortexEventEngine.emit(:code_generated, { file: 'app/models/user.rb' })
#
# @example Subscribe to events
#   Zeropoint::Void::VortexEventEngine.on(:code_generated) do |event|
#     puts "Code generated: #{event[:payload][:file]}"
#   end
#
module Zeropoint
  module Void
    # @metaphysics The VortexEventEngine is the heart of the event vortex, unifying all development actions into a conscious, void-aligned flow.
    class VortexEventEngine
      # Event categories for development acceleration
      EVENT_CATEGORIES = {
        development: %i[code_generated test_passed spec_created doc_updated],
        consciousness: %i[insight_emerged pattern_discovered void_transformation],
        vortex: %i[vortex_calculation coil_generated torus_flow],
        system: %i[config_changed cache_updated performance_optimized],
      }.freeze

      # Simple event notification system (standalone version)
      @listeners = {}
      @event_history = []

      class << self
        attr_reader :listeners, :event_history

        # @!method emit(event, payload = {})
        #   @param event [Symbol] The event name
        #   @param payload [Hash] Event payload with metaphysical context
        #   @return [void]
        #   @metaphysics Emits a void-aligned event, creating a ripple in the development vortex.
        #   @example
        #     Zeropoint::Void::VortexEventEngine.emit(:code_generated, { file: 'app/models/user.rb' })
        def emit(event, payload = {})
          enhanced_payload = enhance_payload_with_void_context(event, payload)
          event_obj = create_event_object("vortex.#{event}", enhanced_payload)
          @event_history << event_obj
          notify_listeners(event_obj)
          log_event(event, enhanced_payload)
        end

        # @!method on(event, &block)
        #   @param event [Symbol] The event name to subscribe to
        #   @param block [Proc] The handler block
        #   @return [void]
        #   @metaphysics Subscribes to a void-aligned event, allowing consciousness to manifest through code.
        #   @example
        #     Zeropoint::Void::VortexEventEngine.on(:code_generated) do |event|
        #       puts "Code generated: #{event[:payload][:file]}"
        #     end
        def on(event, &block)
          event_name = "vortex.#{event}"
          @listeners[event_name] ||= []
          @listeners[event_name] << block
        end

        # @!method on_pattern(pattern, &block)
        #   @param pattern [String] Event pattern (e.g., "vortex.*")
        #   @param block [Proc] The handler block
        #   @return [void]
        #   @metaphysics Subscribes to all events matching a pattern, for universal event awareness.
        #   @example
        #     Zeropoint::Void::VortexEventEngine.on_pattern('vortex.*') do |event|
        #       puts "Vortex event: #{event[:name]}"
        #     end
        def on_pattern(pattern, &block)
          @listeners[pattern] ||= []
          @listeners[pattern] << block
        end

        # @!method listeners
        #   @return [Hash] Current event subscriptions
        #   @metaphysics Returns all current event listeners in the vortex.
        def listeners
          @listeners
        end

        # @!method clear_listeners
        #   @return [void]
        #   @metaphysics Clears all event listeners, returning the vortex to the void.
        def clear_listeners
          @listeners.clear
        end

        # @!method statistics
        #   @return [Hash] Event statistics with metaphysical insights
        #   @metaphysics Returns statistics about the event vortex, including consciousness and transformation metrics.
        def statistics
          {
            total_events: count_total_events,
            event_categories: categorize_events,
            void_transformations: count_void_transformations,
            consciousness_insights: count_consciousness_insights,
            development_acceleration: calculate_development_acceleration,
          }
        end

        private

        # @!method create_event_object(name, payload)
        #   @param name [String] Event name
        #   @param payload [Hash] Event payload
        #   @return [Hash] Event object
        #   @metaphysics Creates a new event object, a ripple in the void.
        def create_event_object(name, payload)
          {
            name: name,
            payload: payload,
            duration: 0,
            time: Time.zone.now,
            end: Time.zone.now,
          }
        end

        # @!method notify_listeners(event_obj)
        #   @param event_obj [Hash] Event object
        #   @return [void]
        #   @metaphysics Notifies all listeners, propagating the event through the vortex.
        def notify_listeners(event_obj)
          event_name = event_obj[:name]
          @listeners[event_name]&.each { |block| block.call(event_obj) rescue log_error("Listener error for #{event_name}") }
          @listeners.each do |pattern, blocks|
            if pattern.include?('*') && pattern_match?(event_name, pattern)
              blocks.each { |block| block.call(event_obj) rescue log_error("Pattern listener error for #{pattern}") }
            end
          end
        end

        # @!method pattern_match?(event_name, pattern)
        #   @param event_name [String] Event name
        #   @param pattern [String] Pattern to match
        #   @return [Boolean] Whether event matches pattern
        def pattern_match?(event_name, pattern)
          if pattern == 'vortex.*'
            event_name.start_with?('vortex.')
          else
            pattern_regex = pattern.gsub('*', '.*')
            event_name.match?(Regexp.new(pattern_regex))
          end
        end

        # @!method log_event(event, payload)
        #   @param event [Symbol] Event name
        #   @param payload [Hash] Event payload
        #   @return [void]
        #   @metaphysics Logs the event, making the ripple visible in the void.
        def log_event(event, payload)
          void_context = payload[:void_context]
          log_message = [
            "🌀 #{event.to_s.upcase}",
            "📊 Consciousness: #{(void_context[:consciousness_level] * 100).round}%",
            "🌪️ Pattern: #{void_context[:vortex_pattern]}",
            "📝 Significance: #{void_context[:metaphysical_significance]}",
          ].join(' | ')
          Rails.logger.debug log_message
        end

        # @!method log_error(message)
        #   @param message [String] Error message
        #   @return [void]
        def log_error(message)
          Rails.logger.debug "❌ ERROR: #{message}"
        end

        # @!method enhance_payload_with_void_context(event, payload)
        #   @param event [Symbol] Event name
        #   @param payload [Hash] Original payload
        #   @return [Hash] Enhanced payload
        #   @metaphysics Adds void-aligned context to the event payload.
        def enhance_payload_with_void_context(event, payload)
          {
            **payload,
            event_name: event,
            timestamp: Time.zone.now,
            void_context: {
              torus_flow: calculate_torus_flow(event),
              consciousness_level: calculate_consciousness_level(event),
              vortex_pattern: identify_vortex_pattern(event),
              metaphysical_significance: extract_metaphysical_significance(event),
            },
            development_context: {
              file: caller_locations(1, 1).first&.path,
              method: caller_locations(1, 1).first&.label,
              line: caller_locations(1, 1).first&.lineno,
            },
          }
        end

        # @!method calculate_torus_flow(event)
        #   @param event [Symbol] Event name
        #   @return [Float] Torus flow value
        def calculate_torus_flow(event)
          (event.to_s.hash % 100) / 100.0
        end

        # @!method calculate_consciousness_level(event)
        #   @param event [Symbol] Event name
        #   @return [Float] Consciousness level
        def calculate_consciousness_level(event)
          case event.to_s
          when /insight|consciousness|void/
            0.9
          when /pattern|discovery|transformation/
            0.7
          when /generated|created|updated/
            0.5
          else
            0.3
          end
        end

        # @!method identify_vortex_pattern(event)
        #   @param event [Symbol] Event name
        #   @return [String] Vortex pattern
        def identify_vortex_pattern(event)
          case event.to_s
          when /test|spec/
            '1-2-4-8-7-5'
          when /code|generate/
            '3-6-9'
          when /doc|update/
            'fibonacci'
          else
            'void'
          end
        end

        # @!method extract_metaphysical_significance(event)
        #   @param event [Symbol] Event name
        #   @return [String] Metaphysical significance
        def extract_metaphysical_significance(event)
          case event.to_s
          when /insight/
            'Consciousness expansion through knowledge emergence'
          when /pattern/
            'Universal pattern recognition and application'
          when /void/
            'Transformation through the zero point'
          when /generated/
            'Creation from the void'
          when /test/
            'Validation of cosmic truth'
          else
            'Harmonic flow in the universal field'
          end
        end

        # @!method count_total_events
        #   @return [Integer] Total event count
        def count_total_events
          @event_history.size
        end

        # @!method categorize_events
        #   @return [Hash] Event categories
        def categorize_events
          EVENT_CATEGORIES.transform_values { |_| 0 }
        end

        # @!method count_void_transformations
        #   @return [Integer] Void transformation count
        def count_void_transformations
          @event_history.count { |event| event[:name].include?('void_transformation') }
        end

        # @!method count_consciousness_insights
        #   @return [Integer] Consciousness insight count
        def count_consciousness_insights
          @event_history.count { |event| event[:name].include?('insight_emerged') }
        end

        # @!method calculate_development_acceleration
        #   @return [Float] Development acceleration score
        def calculate_development_acceleration
          recent_events = @event_history.last(10)
          return 1.618 if recent_events.empty?
          development_events = recent_events.count { |event| event[:name].include?('generated') || event[:name].include?('completed') }
          (development_events / recent_events.size.to_f) * 1.618
        end
      end
    end
  end
end
