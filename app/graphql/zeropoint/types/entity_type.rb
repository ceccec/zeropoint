# frozen_string_literal: true

module Zeropoint
  module GraphQL
    module Types
      class EntityType < Types::BaseObject
        description 'Zeropoint Entity - Void-aligned data structure'

        # Core entity fields
        field :id, ID, null: false,
              description: 'Unique identifier'

        field :name, String, null: false,
              description: 'Entity name'

        field :type, String, null: false,
              description: 'Entity type'

        field :description, String, null: true,
              description: 'Entity description'

        field :data, GraphQL::Types::JSON, null: true,
              description: 'Entity data payload'

        field :metadata, GraphQL::Types::JSON, null: true,
              description: 'Entity metadata'

        field :tags, [ String ], null: false,
              description: 'Entity tags'

        field :status, String, null: false,
              description: 'Entity status'

        field :priority, Integer, null: false,
              description: 'Entity priority level'

        # Void-aligned fields
        field :void_coordinates, Types::VoidCoordinatesType, null: true,
              description: 'Void coordinates in the toroidal field'

        field :vortex_signature, String, null: true,
              description: 'Vortex mathematics signature'

        field :consciousness_resonance, Float, null: false,
              description: 'Consciousness resonance level'

        field :torus_position, Types::TorusPositionType, null: true,
              description: 'Position within the torus structure'

        # Relationships
        field :parent_entity, Types::EntityType, null: true,
              description: 'Parent entity'

        field :child_entities, [ Types::EntityType ], null: false,
              description: 'Child entities'

        field :related_entities, [ Types::EntityType ], null: false,
              description: 'Related entities' do
          argument :relationship_type, String, required: false
          argument :limit, Integer, required: false, default_value: 10
        end

        # Computed fields
        field :complexity_score, Float, null: false,
              description: 'Entity complexity score'

        field :energy_level, Float, null: false,
              description: 'Entity energy level'

        field :evolution_stage, String, null: false,
              description: 'Entity evolution stage'

        field :is_active, Boolean, null: false,
              description: 'Whether entity is active'

        field :can_be_modified, Boolean, null: false,
              description: 'Whether entity can be modified'

        # Core field resolvers
        def id
          object.id || Zeropoint::Void::Identity.generate_for(object)
        end

        def name
          object.name || 'Unnamed Entity'
        end

        def type
          object.type || object.class.name.demodulize
        end

        def description(*args, &block)
          object.description(*args, &block)
        end

        def data
          object.data || {}
        end

        def metadata
          object.metadata || {}
        end

        def tags
          object.tags || []
        end

        def status
          object.status || 'active'
        end

        def priority
          object.priority || 1
        end

        # Void-aligned field resolvers
        def void_coordinates
          return nil unless object.respond_to?(:void_coordinates)
          object.void_coordinates
        end

        def vortex_signature
          return nil unless object.respond_to?(:vortex_signature)
          object.vortex_signature
        end

        def consciousness_resonance
          object.respond_to?(:consciousness_resonance) ? object.consciousness_resonance : 0.5
        end

        def torus_position
          return nil unless object.respond_to?(:torus_position)
          object.torus_position
        end

        # Relationship resolvers
        def parent_entity
          return nil unless object.respond_to?(:parent_entity)
          object.parent_entity
        end

        def child_entities
          return [] unless object.respond_to?(:child_entities)
          object.child_entities
        end

        def related_entities(relationship_type: nil, limit: 10)
          return [] unless object.respond_to?(:related_entities)
          entities = object.related_entities
          entities = entities.where(relationship_type: relationship_type) if relationship_type
          entities.limit(limit)
        end

        # Computed field resolvers
        def complexity_score
          return 1.0 unless object.respond_to?(:complexity_score)
          object.complexity_score
        end

        def energy_level
          return 0.5 unless object.respond_to?(:energy_level)
          object.energy_level
        end

        def evolution_stage
          return 'emerging' unless object.respond_to?(:evolution_stage)
          object.evolution_stage
        end

        def is_active
          return true unless object.respond_to?(:is_active?)
          object.is_active?
        end

        def can_be_modified
          return true unless object.respond_to?(:can_be_modified?)
          object.can_be_modified?
        end
      end
    end
  end
end
