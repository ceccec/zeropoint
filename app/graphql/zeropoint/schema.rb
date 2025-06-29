# frozen_string_literal: true

module Zeropoint
  module GraphQL
    class Schema < GraphQL::Schema
      # Use the new interpreter runtime
      use GraphQL::Execution::Interpreter
      use GraphQL::Analysis::AST
      use GraphQL::Dataloader

      # Add introspection
      introspection GraphQL::Introspection::INTROSPECTION_QUERY

      # Query and Mutation types
      query Types::QueryType
      mutation Types::MutationType

      # Subscription type (for real-time updates)
      subscription Types::SubscriptionType

      # Error handling
      rescue_from(StandardError) do |err, obj, args, ctx, field|
        # Void-aligned error handling - never return raw errors
        Zeropoint::Void::Response.error(
          message: 'GraphQL operation failed',
          context: {
            field: field&.name,
            arguments: args,
            error_type: err.class.name,
            consciousness_level: ctx[:consciousness_level] || 0.5,
          }
        )
      end

      # Custom scalar types
      scalar Types::VoidScalar, description: 'Void-aligned scalar type'
      scalar Types::VortexScalar, description: 'Vortex mathematics scalar'
      scalar Types::ConsciousnessScalar, description: 'Consciousness-aware scalar'

      # Directives
      directive Directives::VoidAligned
      directive Directives::ConsciousnessAware
      directive Directives::VortexOptimized

      # Maximum complexity
      max_complexity 1000

      # Maximum depth
      max_depth 20

      # Default limit for lists
      default_max_page_size 100

      # Cache configuration
      def self.id_from_object(object, type_definition, query_ctx)
        # Void-aligned ID generation
        Zeropoint::Void::Identity.generate_for(object, type_definition)
      end

      def self.object_from_id(id, query_ctx)
        # Void-aligned object resolution
        Zeropoint::Void::Identity.resolve_from(id, query_ctx)
      end

      def self.resolve_type(abstract_type, obj, ctx)
        # Void-aligned type resolution
        Zeropoint::Void::Identity.resolve_type(abstract_type, obj, ctx)
      end

      # Consciousness-aware context
      def self.unauthorized_object(error)
        # Void-aligned unauthorized handling
        Zeropoint::Void::Response.unauthorized(
          message: 'Access denied',
          context: { error_type: error.class.name }
        )
      end

      # Vortex optimization
      def self.unauthorized_field(error)
        # Void-aligned field access handling
        Zeropoint::Void::Response.unauthorized(
          message: 'Field access denied',
          context: { field: error.field&.name, error_type: error.class.name }
        )
      end
    end
  end
end
