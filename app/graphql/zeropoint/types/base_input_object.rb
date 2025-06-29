# frozen_string_literal: true

module Zeropoint
  module GraphQL
    module Types
      class BaseInputObject < GraphQL::Schema::InputObject
        # Void-aligned base functionality
        include Zeropoint::Void::Response

        # Consciousness awareness
        argument :consciousness_level, Float, required: false,
                 description: 'Consciousness level for this operation'

        argument :vortex_state, String, required: false,
                 description: 'Vortex state for this operation'

        argument :void_aligned, Boolean, required: false, default_value: true,
                 description: 'Whether this operation should be void-aligned'

        # Validation hook
        def validate!
          # Void-aligned validation
          validate_consciousness_level
          validate_vortex_state
          super
        end

        private

        def validate_consciousness_level
          return unless consciousness_level
          unless consciousness_level.between?(0.0, 1.0)
            raise GraphQL::ExecutionError.new(
              'Consciousness level must be between 0.0 and 1.0',
              extensions: { code: 'INVALID_CONSCIOUSNESS_LEVEL' }
            )
          end
        end

        def validate_vortex_state
          return unless vortex_state
          valid_states = %w[consciousness flowing quantum vortex]
          unless valid_states.include?(vortex_state)
            raise GraphQL::ExecutionError.new(
              "Invalid vortex state. Must be one of: #{valid_states.join(', ')}",
              extensions: { code: 'INVALID_VORTEX_STATE' }
            )
          end
        end
      end
    end
  end
end
