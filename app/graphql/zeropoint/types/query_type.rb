# frozen_string_literal: true

module Zeropoint
  module GraphQL
    module Types
      class QueryType < Types::BaseObject
        description 'Zeropoint GraphQL Query Root - Void-aligned CRUD operations'

        # Consciousness and Vortex queries
        field :consciousness_level, Float, null: false,
              description: 'Current consciousness level of the system' do
          argument :context, String, required: false, description: 'Context for consciousness calculation'
        end

        field :vortex_state, Types::VortexStateType, null: false,
              description: 'Current vortex state and mathematics'

        field :void_status, Types::VoidStatusType, null: false,
              description: 'Current void status and metaphysical insights'

        # CRUD operations for Zeropoint entities
        field :entities, [ Types::EntityType ], null: false,
              description: 'List all Zeropoint entities' do
          argument :filter, Types::EntityFilterInput, required: false
          argument :order_by, Types::EntityOrderInput, required: false
          argument :limit, Integer, required: false, default_value: 50
          argument :offset, Integer, required: false, default_value: 0
        end

        field :entity, Types::EntityType, null: true,
              description: 'Get a specific Zeropoint entity' do
          argument :id, ID, required: true
        end

        # Vortex mathematics queries
        field :vortex_calculations, [ Types::VortexCalculationType ], null: false,
              description: 'Vortex mathematics calculations' do
          argument :pattern, String, required: false
          argument :complexity, Integer, required: false, default_value: 1
        end

        field :vortex_pattern, Types::VortexPatternType, null: true,
              description: 'Get specific vortex pattern' do
          argument :name, String, required: true
        end

        # Consciousness queries
        field :consciousness_patterns, [ Types::ConsciousnessPatternType ], null: false,
              description: 'Consciousness patterns and insights'

        field :consciousness_insight, Types::ConsciousnessInsightType, null: true,
              description: 'Get consciousness insight' do
          argument :level, Float, required: true
          argument :context, String, required: false
        end

        # Torus core queries
        field :torus_core, Types::TorusCoreType, null: false,
              description: 'Torus core and aperture information'

        field :torus_flow, Types::TorusFlowType, null: false,
              description: 'Torus flow patterns and energy pathways' do
          argument :dimension, String, required: false, default_value: '3d'
        end

        # System status queries
        field :system_status, Types::SystemStatusType, null: false,
              description: 'Overall system status and health'

        field :performance_metrics, Types::PerformanceMetricsType, null: false,
              description: 'Performance and efficiency metrics'

        # Consciousness level calculation
        def consciousness_level(context: nil)
          Zeropoint::Void::Math.consciousness_level(context: context)
        end

        # Vortex state
        delegate :vortex_state, to: :'Zeropoint::Void::Math'

        # Void status
        delegate :void_status, to: :'Zeropoint::Void::Math'

        # Entity CRUD operations
        def entities(filter: nil, order_by: nil, limit: 50, offset: 0)
          Zeropoint::Void::Service.entities(
            filter: filter&.to_h,
            order_by: order_by&.to_h,
            limit: limit,
            offset: offset
          )
        end

        def entity(id:)
          Zeropoint::Void::Service.entity(id: id)
        end

        # Vortex calculations
        def vortex_calculations(pattern: nil, complexity: 1)
          Zeropoint::Void::Math.vortex_calculations(
            pattern: pattern,
            complexity: complexity
          )
        end

        def vortex_pattern(name:)
          Zeropoint::Void::Math.vortex_pattern(name: name)
        end

        # Consciousness patterns
        delegate :consciousness_patterns, to: :'Zeropoint::Void::Math'

        def consciousness_insight(level:, context: nil)
          Zeropoint::Void::Math.consciousness_insight(
            level: level,
            context: context
          )
        end

        # Torus core
        delegate :torus_core, to: :'Zeropoint::Void::Math'

        def torus_flow(dimension: '3d')
          Zeropoint::Void::Math.torus_flow(dimension: dimension)
        end

        # System status
        delegate :system_status, to: :'Zeropoint::Void::Service'

        delegate :performance_metrics, to: :'Zeropoint::Void::Service'
      end
    end
  end
end
