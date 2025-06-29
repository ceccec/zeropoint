# frozen_string_literal: true

module Zeropoint
  module GraphQL
    module Types
      class MutationType < Types::BaseObject
        description 'Zeropoint GraphQL Mutation Root - Void-aligned CRUD operations'

        # Entity CRUD mutations
        field :create_entity, Types::EntityType, null: false,
              description: 'Create a new Zeropoint entity' do
          argument :input, Types::CreateEntityInput, required: true
        end

        field :update_entity, Types::EntityType, null: false,
              description: 'Update an existing Zeropoint entity' do
          argument :id, ID, required: true
          argument :input, Types::UpdateEntityInput, required: true
        end

        field :delete_entity, Types::DeleteEntityPayload, null: false,
              description: 'Delete a Zeropoint entity' do
          argument :id, ID, required: true
        end

        field :bulk_create_entities, [ Types::EntityType ], null: false,
              description: 'Create multiple entities in bulk' do
          argument :inputs, [ Types::CreateEntityInput ], required: true
        end

        field :bulk_update_entities, [ Types::EntityType ], null: false,
              description: 'Update multiple entities in bulk' do
          argument :updates, [ Types::BulkUpdateEntityInput ], required: true
        end

        field :bulk_delete_entities, Types::BulkDeletePayload, null: false,
              description: 'Delete multiple entities in bulk' do
          argument :ids, [ ID ], required: true
        end

        # Vortex mathematics mutations
        field :create_vortex_calculation, Types::VortexCalculationType, null: false,
              description: 'Create a new vortex calculation' do
          argument :input, Types::CreateVortexCalculationInput, required: true
        end

        field :update_vortex_calculation, Types::VortexCalculationType, null: false,
              description: 'Update a vortex calculation' do
          argument :id, ID, required: true
          argument :input, Types::UpdateVortexCalculationInput, required: true
        end

        field :delete_vortex_calculation, Types::DeleteVortexCalculationPayload, null: false,
              description: 'Delete a vortex calculation' do
          argument :id, ID, required: true
        end

        # Consciousness mutations
        field :create_consciousness_pattern, Types::ConsciousnessPatternType, null: false,
              description: 'Create a new consciousness pattern' do
          argument :input, Types::CreateConsciousnessPatternInput, required: true
        end

        field :update_consciousness_pattern, Types::ConsciousnessPatternType, null: false,
              description: 'Update a consciousness pattern' do
          argument :id, ID, required: true
          argument :input, Types::UpdateConsciousnessPatternInput, required: true
        end

        field :delete_consciousness_pattern, Types::DeleteConsciousnessPatternPayload, null: false,
              description: 'Delete a consciousness pattern' do
          argument :id, ID, required: true
        end

        # Torus core mutations
        field :update_torus_core, Types::TorusCoreType, null: false,
              description: 'Update torus core configuration' do
          argument :input, Types::UpdateTorusCoreInput, required: true
        end

        field :reset_torus_flow, Types::TorusFlowType, null: false,
              description: 'Reset torus flow patterns' do
          argument :dimension, String, required: false, default_value: '3d'
        end

        # System mutations
        field :update_system_config, Types::SystemStatusType, null: false,
              description: 'Update system configuration' do
          argument :input, Types::UpdateSystemConfigInput, required: true
        end

        field :clear_cache, Types::CacheClearPayload, null: false,
              description: 'Clear system cache' do
          argument :pattern, String, required: false
        end

        # Entity CRUD operations
        def create_entity(input:)
          Zeropoint::Void::Service.create_entity(input: input.to_h)
        end

        def update_entity(id:, input:)
          Zeropoint::Void::Service.update_entity(id: id, input: input.to_h)
        end

        def delete_entity(id:)
          Zeropoint::Void::Service.delete_entity(id: id)
        end

        def bulk_create_entities(inputs:)
          Zeropoint::Void::Service.bulk_create_entities(inputs: inputs.map(&:to_h))
        end

        def bulk_update_entities(updates:)
          Zeropoint::Void::Service.bulk_update_entities(updates: updates.map(&:to_h))
        end

        def bulk_delete_entities(ids:)
          Zeropoint::Void::Service.bulk_delete_entities(ids: ids)
        end

        # Vortex calculations
        def create_vortex_calculation(input:)
          Zeropoint::Void::Math.create_vortex_calculation(input: input.to_h)
        end

        def update_vortex_calculation(id:, input:)
          Zeropoint::Void::Math.update_vortex_calculation(id: id, input: input.to_h)
        end

        def delete_vortex_calculation(id:)
          Zeropoint::Void::Math.delete_vortex_calculation(id: id)
        end

        # Consciousness patterns
        def create_consciousness_pattern(input:)
          Zeropoint::Void::Math.create_consciousness_pattern(input: input.to_h)
        end

        def update_consciousness_pattern(id:, input:)
          Zeropoint::Void::Math.update_consciousness_pattern(id: id, input: input.to_h)
        end

        def delete_consciousness_pattern(id:)
          Zeropoint::Void::Math.delete_consciousness_pattern(id: id)
        end

        # Torus core
        def update_torus_core(input:)
          Zeropoint::Void::Math.update_torus_core(input: input.to_h)
        end

        def reset_torus_flow(dimension: '3d')
          Zeropoint::Void::Math.reset_torus_flow(dimension: dimension)
        end

        # System operations
        def update_system_config(input:)
          Zeropoint::Void::Service.update_system_config(input: input.to_h)
        end

        def clear_cache(pattern: nil)
          Zeropoint::Void::Service.clear_cache(pattern: pattern)
        end
      end
    end
  end
end
