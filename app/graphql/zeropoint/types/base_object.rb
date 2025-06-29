# frozen_string_literal: true

module Zeropoint
  module GraphQL
    module Types
      class BaseObject < GraphQL::Schema::Object
        # Void-aligned base functionality
        include Zeropoint::Void::Response

        # Consciousness awareness
        field :consciousness_level, Float, null: false,
              description: 'Consciousness level of this object'

        field :vortex_state, String, null: false,
              description: 'Current vortex state'

        field :void_aligned, Boolean, null: false,
              description: 'Whether this object is void-aligned'

        field :metaphysical_insights, [ String ], null: false,
              description: 'Metaphysical insights about this object'

        field :created_at, GraphQL::Types::ISO8601DateTime, null: true,
              description: 'Creation timestamp'

        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true,
              description: 'Last update timestamp'

        # Consciousness level calculation
        def consciousness_level
          object.respond_to?(:consciousness_level) ? object.consciousness_level : 0.5
        end

        # Vortex state
        def vortex_state
          object.respond_to?(:vortex_state) ? object.vortex_state : 'flowing'
        end

        # Void alignment
        def void_aligned
          object.respond_to?(:void_aligned?) ? object.void_aligned? : true
        end

        # Metaphysical insights
        def metaphysical_insights
          if object.respond_to?(:metaphysical_insights)
            object.metaphysical_insights
          else
            [ 'This object emerges from the void', 'Consciousness flows through its structure' ]
          end
        end

        # Timestamps
        def created_at
          object.respond_to?(:created_at) ? object.created_at : nil
        end

        def updated_at
          object.respond_to?(:updated_at) ? object.updated_at : nil
        end
      end
    end
  end
end
