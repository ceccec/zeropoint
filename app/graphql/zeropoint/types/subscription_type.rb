# frozen_string_literal: true

module Zeropoint
  module GraphQL
    module Types
      class SubscriptionType < Types::BaseObject
        description 'Zeropoint GraphQL Subscription Root - Real-time void-aligned updates'

        # Entity subscriptions
        field :entity_created, Types::EntityType, null: false,
              description: 'Subscribe to entity creation events' do
          argument :entity_type, String, required: false
        end

        field :entity_updated, Types::EntityType, null: false,
              description: 'Subscribe to entity update events' do
          argument :entity_type, String, required: false
          argument :id, ID, required: false
        end

        field :entity_deleted, Types::EntityDeletedEvent, null: false,
              description: 'Subscribe to entity deletion events' do
          argument :entity_type, String, required: false
        end

        # Vortex subscriptions
        field :vortex_state_changed, Types::VortexStateType, null: false,
              description: 'Subscribe to vortex state changes' do
          argument :pattern, String, required: false
        end

        field :vortex_calculation_completed, Types::VortexCalculationType, null: false,
              description: 'Subscribe to vortex calculation completions' do
          argument :complexity, Integer, required: false
        end

        # Consciousness subscriptions
        field :consciousness_level_changed, Float, null: false,
              description: 'Subscribe to consciousness level changes' do
          argument :threshold, Float, required: false, default_value: 0.1
        end

        field :consciousness_pattern_emerged, Types::ConsciousnessPatternType, null: false,
              description: 'Subscribe to new consciousness patterns'

        # Torus core subscriptions
        field :torus_flow_updated, Types::TorusFlowType, null: false,
              description: 'Subscribe to torus flow updates' do
          argument :dimension, String, required: false, default_value: '3d'
        end

        field :torus_core_resonance, Types::TorusCoreType, null: false,
              description: 'Subscribe to torus core resonance events'

        # System subscriptions
        field :system_status_changed, Types::SystemStatusType, null: false,
              description: 'Subscribe to system status changes'

        field :performance_metrics_updated, Types::PerformanceMetricsType, null: false,
              description: 'Subscribe to performance metrics updates'

        # Void subscriptions
        field :void_transformation, Types::VoidStatusType, null: false,
              description: 'Subscribe to void transformation events'

        # Entity event handlers
        def entity_created(entity_type: nil)
          # Void-aligned event handling
          Zeropoint::Void::Service.subscribe_to_entity_creation(
            entity_type: entity_type,
            context: context
          )
        end

        def entity_updated(entity_type: nil, id: nil)
          Zeropoint::Void::Service.subscribe_to_entity_updates(
            entity_type: entity_type,
            id: id,
            context: context
          )
        end

        def entity_deleted(entity_type: nil)
          Zeropoint::Void::Service.subscribe_to_entity_deletion(
            entity_type: entity_type,
            context: context
          )
        end

        # Vortex event handlers
        def vortex_state_changed(pattern: nil)
          Zeropoint::Void::Math.subscribe_to_vortex_changes(
            pattern: pattern,
            context: context
          )
        end

        def vortex_calculation_completed(complexity: nil)
          Zeropoint::Void::Math.subscribe_to_calculation_completion(
            complexity: complexity,
            context: context
          )
        end

        # Consciousness event handlers
        def consciousness_level_changed(threshold: 0.1)
          Zeropoint::Void::Math.subscribe_to_consciousness_changes(
            threshold: threshold,
            context: context
          )
        end

        def consciousness_pattern_emerged
          Zeropoint::Void::Math.subscribe_to_pattern_emergence(context: context)
        end

        # Torus event handlers
        def torus_flow_updated(dimension: '3d')
          Zeropoint::Void::Math.subscribe_to_torus_flow(
            dimension: dimension,
            context: context
          )
        end

        def torus_core_resonance
          Zeropoint::Void::Math.subscribe_to_torus_resonance(context: context)
        end

        # System event handlers
        def system_status_changed
          Zeropoint::Void::Service.subscribe_to_system_changes(context: context)
        end

        def performance_metrics_updated
          Zeropoint::Void::Service.subscribe_to_metrics_updates(context: context)
        end

        # Void event handlers
        def void_transformation
          Zeropoint::Void::Math.subscribe_to_void_transformations(context: context)
        end
      end
    end
  end
end
