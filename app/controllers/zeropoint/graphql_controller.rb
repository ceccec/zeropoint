# frozen_string_literal: true

module Zeropoint
  class GraphqlController < Zeropoint::BaseController
    def execute
      # COMPONENT BEST PRACTICE: Build consciousness-aware context and execute with caching.
      request_uuid = generate_request_uuid
      transformed_uuid = apply_vortex_transformation(request_uuid, determine_vortex_state)
      context = build_consciousness_context(transformed_uuid)
      result = execute_with_caching(context) do
        Zeropoint::GraphQL::Schema.execute(
          params[:query],
          variables: ensure_hash(params[:variables]),
          context: context
        )
      end
      render json: format_uroboros_result(result, transformed_uuid)
    rescue StandardError => e
      error_result = handle_consciousness_error(e, request_uuid)
      render json: error_result, status: :internal_server_error
    end

    def playground
      render template: 'zeropoint/graphql/playground', layout: false
    end

    private

    def build_consciousness_context(uuid)
      {
        current_user: current_user,
        locale: I18n.locale,
        timezone: Time.zone.name,
        request_id: uuid,
        ip_address: request.remote_ip,
        user_agent: request.user_agent,
        consciousness_enabled: Zeropoint.config.consciousness_aware_errors,
        golden_ratio: Zeropoint.config.golden_ratio_optimization,
        vortex_enabled: Zeropoint.config.vortex_enabled,
        batch_size: Zeropoint.config.vortex_batch_size,
        uroboros_context: @uroboros_context,
        pattern_encoded_uuid: uuid,
        vortex_state: determine_vortex_state,
        consciousness_level: calculate_consciousness_level,
        observer_influence: @observer_influence,
        # Void-aligned context
        void_aligned: true,
        torus_core: Zeropoint::Void::Math.torus_core,
        metaphysical_insights: generate_metaphysical_insights(uuid),
      }
    end

    def execute_with_caching(context)
      cache_key = generate_cache_key(context)
      Zeropoint::Vortex::CacheMatrix.fetch_or_store(cache_key) do
        yield
      end
    end

    def generate_cache_key(context)
      cache_uuid = Zeropoint::Core::UuidMatrix.generate_stimulus_cache_uuid(
        :graphql_execution,
        :query,
        {
          query_hash: Digest::SHA256.hexdigest(params[:query]),
          variables_hash: Digest::SHA256.hexdigest(params[:variables].to_json),
          vortex_state: context[:vortex_state],
          consciousness_level: context[:consciousness_level],
        }
      )
      "graphql:#{cache_uuid}"
    end

    def ensure_hash(ambiguous_param)
      case ambiguous_param
      when String
        ambiguous_param.present? ? JSON.parse(ambiguous_param) : {}
      when Hash
        ambiguous_param
      when ActionController::Parameters
        ambiguous_param.to_unsafe_h
      when nil
        {}
      else
        raise ArgumentError, "Unexpected parameter: #{ambiguous_param.class}"
      end
    end

    def generate_metaphysical_insights(uuid)
      [
        'Every GraphQL query flows through the void',
        'Consciousness shapes the data that emerges',
        'The torus core resonates with each request',
        'Vortex mathematics guides the response',
      ]
    end

    # Example usage of the DRY helper for outgoing requests (if needed in future):
    # vortex_request = build_vortex_request('graphql.query', { query: params[:query], variables: params[:variables] }, channel: 'graphql')
    # Net::HTTP.post_form(URI.parse('/zeropoint'), vortex_request)
    #
  end
end
