# frozen_string_literal: true

module Zeropoint
  module Vortex
    class CacheMatrix
      # Singleton removed for void-aligned minimalism
      # include Singleton

      def initialize
        @cache = Concurrent::Map.new
        @patterns = Concurrent::Map.new
      end

      def fetch_or_store(key, &block)
        @cache.fetch_or_store(key) do
          result = yield
          store_pattern(key, result)
          result
        end
      end

      def store(key, value)
        @cache[key] = value
        store_pattern(key, value)
        value
      end

      def fetch(key)
        @cache[key]
      end

      def delete(key)
        @cache.delete(key)
        @patterns.delete(key)
      end

      def clear
        @cache.clear
        @patterns.clear
      end

      delegate :keys, to: :@cache

      delegate :size, to: :@cache

      delegate :empty?, to: :@cache

      def include?(key)
        @cache.key?(key)
      end

      def pattern_for(key)
        @patterns[key]
      end

      private

      def store_pattern(key, value)
        @patterns[key] = {
          timestamp: Time.current,
          value_type: value.class.name,
          value_size: value.to_s.length,
          cache_efficiency: calculate_cache_efficiency(key),
        }
      end

      def calculate_cache_efficiency(key)
        # Calculate cache efficiency based on key characteristics
        return 0.8 if key.to_s.include?('uuid')
        return 0.9 if key.to_s.include?('cache')
        return 0.7 if key.to_s.include?('graphql')
        0.6
      end
    end
  end
end
