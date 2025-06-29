# frozen_string_literal: true

# Zeropoint::API::Client
#
# API client for Zeropoint services with caching, batch processing,
# and unified access patterns for Git learning intelligence.
#
# @example Basic API usage
#   client = Zeropoint::API::Client.new
#   response = client.get('/api/v1/git/commits', { limit: 100 })
#
module Zeropoint
  module API
    class Client
      # Configuration for API client
      CONFIG = {
        base_url: 'http://localhost:3000',
        timeout: 30,
        retry_attempts: 3,
        retry_delay: 1,
        batch_size: 50,
        cache_enabled: true,
        cache_duration: 3600,
        user_agent: 'Zeropoint-API-Client/1.0',
      }.freeze

      # Initialize the API client
      def initialize(options = {})
        @config = CONFIG.merge(options)
        @cache = Zeropoint::Cache::RedisCache.new if @config[:cache_enabled]
        @session = create_session
      end

      # Make a GET request
      # @param endpoint [String] API endpoint
      # @param params [Hash] Query parameters
      # @return [Zeropoint::API::Response] API response
      def get(endpoint, params = {})
        make_request(:get, endpoint, params: params)
      end

      # Make a POST request
      # @param endpoint [String] API endpoint
      # @param data [Hash] Request data
      # @return [Zeropoint::API::Response] API response
      def post(endpoint, data = {})
        make_request(:post, endpoint, data: data)
      end

      # Make a PUT request
      # @param endpoint [String] API endpoint
      # @param data [Hash] Request data
      # @return [Zeropoint::API::Response] API response
      def put(endpoint, data = {})
        make_request(:put, endpoint, data: data)
      end

      # Make a DELETE request
      # @param endpoint [String] API endpoint
      # @return [Zeropoint::API::Response] API response
      def delete(endpoint)
        make_request(:delete, endpoint)
      end

      # Batch process multiple requests
      # @param requests [Array] Array of request hashes
      # @return [Array] Array of responses
      def batch(requests)
        requests.each_slice(@config[:batch_size]).flat_map do |batch|
          batch.map { |req| make_request(req[:method], req[:endpoint], req) }
        end
      end

      # Get cached response or make request
      # @param endpoint [String] API endpoint
      # @param params [Hash] Query parameters
      # @return [Zeropoint::API::Response] API response
      def cached_get(endpoint, params = {})
        return get(endpoint, params) unless @config[:cache_enabled]

        cache_key = generate_cache_key(:get, endpoint, params)
        cached_response = @cache.get(cache_key)

        return cached_response if cached_response

        response = get(endpoint, params)
        @cache.set(cache_key, response, @config[:cache_duration]) if response.success?

        response
      end

      private

      # Make HTTP request with retry logic
      # @param method [Symbol] HTTP method
      # @param endpoint [String] API endpoint
      # @param options [Hash] Request options
      # @return [Zeropoint::API::Response] API response
      def make_request(method, endpoint, options = {})
        url = build_url(endpoint)

        @config[:retry_attempts].times do |attempt|
          begin
            response = @session.send(method) do |req|
              req.url url
              req.params = options[:params] if options[:params]
              req.body = options[:data].to_json if options[:data]
              req.headers['Content-Type'] = 'application/json'
              req.headers['User-Agent'] = @config[:user_agent]
              req.options.timeout = @config[:timeout]
            end

            return Zeropoint::API::Response.new(response)
          rescue StandardError => e
            if attempt == @config[:retry_attempts] - 1
              return Zeropoint::API::Response.error(e.message)
            end

            sleep(@config[:retry_delay] * (attempt + 1))
          end
        end
      end

      # Create HTTP session
      # @return [Faraday::Connection] HTTP session
      def create_session
        Faraday.new do |faraday|
          faraday.request :url_encoded
          faraday.response :logger if ENV['DEBUG']
          faraday.adapter Faraday.default_adapter
        end
      end

      # Build full URL
      # @param endpoint [String] API endpoint
      # @return [String] Full URL
      def build_url(endpoint)
        endpoint.start_with?('http') ? endpoint : "#{@config[:base_url]}#{endpoint}"
      end

      # Generate cache key
      # @param method [Symbol] HTTP method
      # @param endpoint [String] API endpoint
      # @param params [Hash] Parameters
      # @return [String] Cache key
      def generate_cache_key(method, endpoint, params)
        "api:#{method}:#{endpoint}:#{Digest::MD5.hexdigest(params.to_json)}"
      end
    end

    # API Response wrapper
    class Response
      # @return [Integer] HTTP status code
      attr_reader :status

      # @return [Hash] Response data
      attr_reader :data

      # @return [String] Error message
      attr_reader :error

      # Initialize response
      # @param faraday_response [Faraday::Response] Faraday response
      def initialize(faraday_response)
        @status = faraday_response.status
        @data = parse_response(faraday_response)
        @error = nil
      end

      # Create error response
      # @param error_message [String] Error message
      # @return [Zeropoint::API::Response] Error response
      def self.error(error_message)
        response = new(nil)
        response.instance_variable_set(:@status, 500)
        response.instance_variable_set(:@data, {})
        response.instance_variable_set(:@error, error_message)
        response
      end

      # Check if request was successful
      # @return [Boolean] Success status
      def success?
        @status >= 200 && @status < 300
      end

      # Check if request failed
      # @return [Boolean] Failure status
      def failure?
        !success?
      end

      private

      # Parse response body
      # @param faraday_response [Faraday::Response] Faraday response
      # @return [Hash] Parsed response
      def parse_response(faraday_response)
        return {} unless faraday_response&.body

        JSON.parse(faraday_response.body)
      rescue JSON::ParserError
        { raw_body: faraday_response.body }
      end
    end
  end
end
