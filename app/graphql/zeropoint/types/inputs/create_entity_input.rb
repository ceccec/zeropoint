# frozen_string_literal: true

module Zeropoint
  module GraphQL
    module Types
      module Inputs
        class CreateEntityInput < Types::BaseInputObject
          description 'Input for creating a new Zeropoint entity'

          # Core fields
          argument :name, String, required: true,
                    description: 'Entity name'

          argument :type, String, required: false,
                    description: 'Entity type'

          argument :description, String, required: false,
                    description: 'Entity description'

          argument :data, GraphQL::Types::JSON, required: false,
                    description: 'Entity data payload'

          argument :metadata, GraphQL::Types::JSON, required: false,
                    description: 'Entity metadata'

          argument :tags, [ String ], required: false,
                    description: 'Entity tags'

          argument :status, String, required: false, default_value: 'active',
                    description: 'Entity status'

          argument :priority, Integer, required: false, default_value: 1,
                    description: 'Entity priority level'

          # Void-aligned fields
          argument :void_coordinates, Types::VoidCoordinatesInput, required: false,
                    description: 'Void coordinates in the toroidal field'

          argument :vortex_signature, String, required: false,
                    description: 'Vortex mathematics signature'

          argument :consciousness_resonance, Float, required: false, default_value: 0.5,
                    description: 'Consciousness resonance level'

          argument :torus_position, Types::TorusPositionInput, required: false,
                    description: 'Position within the torus structure'

          # Relationship fields
          argument :parent_entity_id, ID, required: false,
                    description: 'Parent entity ID'

          argument :relationship_type, String, required: false,
                    description: 'Type of relationship with parent'

          # Validation
          def validate!
            # Void-aligned validation
            validate_consciousness_resonance
            validate_vortex_signature
            validate_torus_position
            validate_void_coordinates
          end

          private

          def validate_consciousness_resonance
            return unless consciousness_resonance
            unless consciousness_resonance.between?(0.0, 1.0)
              raise GraphQL::ExecutionError.new(
                'Consciousness resonance must be between 0.0 and 1.0',
                extensions: { code: 'INVALID_CONSCIOUSNESS_RESONANCE' }
              )
            end
          end

          def validate_vortex_signature
            return unless vortex_signature
            unless vortex_signature.match?(/^[0-9a-f]{32}$/)
              raise GraphQL::ExecutionError.new(
                'Vortex signature must be a 32-character hexadecimal string',
                extensions: { code: 'INVALID_VORTEX_SIGNATURE' }
              )
            end
          end

          def validate_torus_position
            return unless torus_position
            # Validate torus position coordinates
            position = torus_position.to_h
            unless position[:radius].between?(0.0, 1.0) && position[:theta].between?(0.0, 2 * Math::PI)
              raise GraphQL::ExecutionError.new(
                'Invalid torus position coordinates',
                extensions: { code: 'INVALID_TORUS_POSITION' }
              )
            end
          end

          def validate_void_coordinates
            return unless void_coordinates
            # Validate void coordinates
            coords = void_coordinates.to_h
            unless coords[:x].finite? && coords[:y].finite? && coords[:z].finite?
              raise GraphQL::ExecutionError.new(
                'Void coordinates must be finite numbers',
                extensions: { code: 'INVALID_VOID_COORDINATES' }
              )
            end
          end
        end
      end
    end
  end
end
