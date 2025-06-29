# frozen_string_literal: true

module Zeropoint
  class SessionOptimizer
    include Singleton

    def initialize
      @golden_ratio_config = Zeropoint.config.golden_ratio_config
      @self_healing_enabled = Zeropoint.config.self_healing_enabled
      @cache = Cache::RedisCache.instance
      initialize_golden_ratio_session_settings
    end

    # Optimize session data using golden ratio principles
    def optimize_session_data(session_data, user_id = nil)
      return session_data unless Zeropoint.config.golden_ratio_optimization

      optimized_data = {
        user_id: user_id,
        timestamp: Time.current,
        data: apply_golden_ratio_to_session_data(session_data),
        metadata: generate_session_metadata(session_data),
      }

      # Apply golden ratio to session size
      optimized_data = apply_golden_ratio_to_session_size(optimized_data)

      optimized_data
    end

    # Store optimized session data
    def store_session(session_id, session_data, user_id = nil)
      optimized_data = optimize_session_data(session_data, user_id)
      optimized_ttl = calculate_golden_ratio_session_timeout(1800) # 30 minutes default

      cache_key = generate_golden_ratio_session_key(session_id)
      @cache.set(cache_key, optimized_data, optimized_ttl)

      # Store session metadata for tracking
      store_session_metadata(session_id, optimized_data)

      true
    rescue StandardError => e
      handle_session_error(e, 'store', session_id)
      false
    end

    # Retrieve and optimize session data
    def retrieve_session(session_id)
      cache_key = generate_golden_ratio_session_key(session_id)
      session_data = @cache.get(cache_key)

      return nil unless session_data

      # Apply golden ratio optimizations to retrieved data
      apply_golden_ratio_to_retrieved_session(session_data)
    rescue StandardError => e
      handle_session_error(e, 'retrieve', session_id)
      nil
    end

    # Batch session operations with golden ratio optimization
    def batch_store_sessions(session_pairs)
      return false if session_pairs.empty?

      # Apply golden ratio batching
      batched_pairs = apply_golden_ratio_batching(session_pairs)
      optimized_ttl = calculate_golden_ratio_session_timeout(1800)

      batched_pairs.each_slice(golden_ratio_batch_size) do |batch|
        batch.each do |session_id, session_data|
          optimized_data = optimize_session_data(session_data)
          cache_key = generate_golden_ratio_session_key(session_id)
          @cache.set(cache_key, optimized_data, optimized_ttl)
        end
      end

      true
    rescue StandardError => e
      handle_session_error(e, 'batch_store', session_pairs.first&.first)
      false
    end

    # Clean up expired sessions with golden ratio optimization
    def cleanup_expired_sessions
      return unless @self_healing_enabled

      # Get all session keys
      session_keys = get_all_session_keys

      # Apply golden ratio to cleanup batch size
      cleanup_batch_size = calculate_golden_ratio_batch_size(100)

      session_keys.each_slice(cleanup_batch_size) do |batch|
        batch.each do |key|
          # Check if session is expired
          if session_expired?(key)
            @cache.delete(key)
          end
        end
      end

      true
    rescue StandardError => e
      handle_session_error(e, 'cleanup', nil)
      false
    end

    # Self-healing session operations
    def self_heal_sessions
      return unless @self_healing_enabled

      # Apply golden ratio corrections
      @golden_ratio_config = Zeropoint.config.golden_ratio_config

      # Optimize session settings
      optimize_session_settings

      # Clean up expired sessions
      cleanup_expired_sessions

      # Rebalance session distribution
      rebalance_session_distribution

      true
    rescue StandardError => e
      handle_session_error(e, 'self_heal', nil)
      false
    end

    # Get session statistics with golden ratio optimization
    def session_stats
      stats = {
        total_sessions: count_total_sessions,
        active_sessions: count_active_sessions,
        expired_sessions: count_expired_sessions,
        average_session_size: calculate_average_session_size,
        golden_ratio_optimizations: @golden_ratio_config[:sessions],
      }

      apply_golden_ratio_to_session_stats(stats)
    rescue StandardError => e
      handle_session_error(e, 'stats', nil)
      {}
    end

    private

    def initialize_golden_ratio_session_settings
      @golden_ratio_batch_size = calculate_golden_ratio_batch_size(50)
      @golden_ratio_session_timeout = calculate_golden_ratio_session_timeout(1800)
      @golden_ratio_session_key_length = calculate_golden_ratio_key_length(32)
    end

    def apply_golden_ratio_to_session_data(data)
      return data unless data.is_a?(Hash)

      # Defensive: ensure data is not frozen before modifying
      data = data.dup if data.frozen?

      optimized_data = {}
      data.each do |key, value|
        optimized_key = apply_golden_ratio_to_session_key(key)
        optimized_value = apply_golden_ratio_to_session_value(value)
        optimized_data[optimized_key] = optimized_value
      end
      optimized_data
    end

    def apply_golden_ratio_to_session_key(key)
      return key unless key.is_a?(String)

      # Apply golden ratio to session key length
      optimal_length = (key.length * Zeropoint::Configuration::MAJOR_RATIO).round
      key[0, [ optimal_length, @golden_ratio_session_key_length ].max]
    end

    def apply_golden_ratio_to_session_value(value)
      case value
      when Array
        apply_golden_ratio_to_array(value)
      when Hash
        apply_golden_ratio_to_hash(value)
      when String
        apply_golden_ratio_to_string(value)
      else
        value
      end
    end

    def apply_golden_ratio_to_array(array)
      return array unless array.is_a?(Array)

      # Apply golden ratio to array size
      optimal_size = (array.length * Zeropoint::Configuration::MAJOR_RATIO).round
      optimal_size = [ optimal_size, 10 ].max

      if array.length > optimal_size
        array.first(optimal_size)
      else
        array
      end
    end

    def apply_golden_ratio_to_hash(hash)
      return hash unless hash.is_a?(Hash)

      # Apply golden ratio to hash size
      optimal_size = (hash.length * Zeropoint::Configuration::MAJOR_RATIO).round
      optimal_size = [ optimal_size, 5 ].max

      if hash.length > optimal_size
        hash.slice(*hash.keys.first(optimal_size))
      else
        hash
      end
    end

    def apply_golden_ratio_to_string(string)
      return string unless string.is_a?(String)

      # Apply golden ratio to string length
      optimal_length = (string.length * Zeropoint::Configuration::MAJOR_RATIO).round
      string[0, [ optimal_length, 1000 ].max]
    end

    def apply_golden_ratio_to_hash_size(hash)
      return hash unless hash.is_a?(Hash)

      # Apply golden ratio to hash size
      optimal_size = (hash.length * Zeropoint::Configuration::MAJOR_RATIO).round
      optimal_size = [ optimal_size, 5 ].max

      if hash.length > optimal_size
        hash.slice(*hash.keys.first(optimal_size))
      else
        hash
      end
    end

    def apply_golden_ratio_to_session_size(session_data)
      return session_data unless session_data.is_a?(Hash)

      # Apply golden ratio to session data size
      optimal_size = (session_data.length * Zeropoint::Configuration::MAJOR_RATIO).round
      optimal_size = [ optimal_size, 10 ].max

      if session_data.length > optimal_size
        session_data.slice(*session_data.keys.first(optimal_size))
      else
        session_data
      end
    end

    def apply_golden_ratio_to_retrieved_session(session_data)
      return session_data unless session_data.is_a?(Hash)

      # Apply golden ratio optimizations to retrieved data
      optimized_data = session_data.dup

      if optimized_data[:data].is_a?(Hash)
        optimized_data[:data] = apply_golden_ratio_to_session_data(optimized_data[:data])
      end

      optimized_data
    end

    def apply_golden_ratio_batching(collection)
      return collection unless Zeropoint.config.golden_ratio_optimization

      # Apply golden ratio batching
      batch_size = golden_ratio_batch_size
      collection.each_slice(batch_size).to_a
    end

    def apply_golden_ratio_to_session_stats(stats)
      return stats unless stats.is_a?(Hash)

      # Defensive: ensure stats is not frozen before modifying
      stats = stats.dup if stats.frozen?

      optimized_stats = {}
      stats.each do |key, value|
        if value.is_a?(Numeric)
          optimized_stats[key] = apply_golden_ratio_to_numeric(value)
        else
          optimized_stats[key] = value
        end
      end
      optimized_stats
    end

    def calculate_golden_ratio_batch_size(base_size)
      return base_size unless Zeropoint.config.golden_ratio_optimization

      optimal_size = (base_size * Zeropoint::Configuration::GOLDEN_RATIO).round
      [ optimal_size, 1000 ].min
    end

    def calculate_golden_ratio_session_timeout(base_timeout)
      return base_timeout unless Zeropoint.config.golden_ratio_optimization

      optimal_timeout = (base_timeout * Zeropoint::Configuration::GOLDEN_RATIO).round
      [ [ optimal_timeout, 300 ].max, 86400 ].min # 5 minutes to 24 hours
    end

    def calculate_golden_ratio_key_length(base_length)
      return base_length unless Zeropoint.config.golden_ratio_optimization

      optimal_length = (base_length * Zeropoint::Configuration::MAJOR_RATIO).round
      [ optimal_length, 32 ].max
    end

    def apply_golden_ratio_to_numeric(value)
      return value unless value.is_a?(Numeric)

      if value > 1000
        (value * Zeropoint::Configuration::MAJOR_RATIO).round
      elsif value < 0.1
        (value * Zeropoint::Configuration::GOLDEN_RATIO).round(3)
      else
        value
      end
    end

    def generate_golden_ratio_session_key(session_id)
      # Apply golden ratio to session key
      optimized_id = apply_golden_ratio_to_session_key(session_id.to_s)
      hash = Digest::MD5.hexdigest(session_id.to_s)
      "session:#{optimized_id}:#{hash[0, 8]}"
    end

    def generate_session_metadata(session_data)
      {
        size: session_data.to_json.bytesize,
        keys_count: session_data.keys.length,
        created_at: Time.current,
        optimized: true,
      }
    end

    def store_session_metadata(session_id, session_data)
      metadata_key = "session_metadata:#{session_id}"
      @cache.set(metadata_key, session_data[:metadata], 3600)
    end

    def get_all_session_keys
      # This would typically use Redis SCAN for production
      @cache.instance_variable_get(:@redis).keys('session:*')
    end

    def session_expired?(key)
      ttl = @cache.instance_variable_get(:@redis).ttl(key)
      ttl <= 0
    end

    def count_total_sessions
      get_all_session_keys.length
    end

    def count_active_sessions
      get_all_session_keys.count { |key| !session_expired?(key) }
    end

    def count_expired_sessions
      get_all_session_keys.count { |key| session_expired?(key) }
    end

    def calculate_average_session_size
      sessions = get_all_session_keys
      return 0 if sessions.empty?

      total_size = sessions.sum do |key|
        session_data = @cache.get(key)
        session_data ? session_data.to_json.bytesize : 0
      end

      total_size / sessions.length
    end

    def golden_ratio_batch_size
      @golden_ratio_batch_size
    end

    def optimize_session_settings
      # Optimize session settings with golden ratio
      @golden_ratio_batch_size = calculate_golden_ratio_batch_size(50)
      @golden_ratio_session_timeout = calculate_golden_ratio_session_timeout(1800)
    end

    def rebalance_session_distribution
      # Rebalance session distribution using golden ratio
      sessions = get_all_session_keys
      optimal_count = (sessions.length * Zeropoint::Configuration::MAJOR_RATIO).round

      if sessions.length > optimal_count
        # Remove oldest sessions to maintain golden ratio
        sessions_to_remove = sessions.length - optimal_count
        sessions.first(sessions_to_remove).each do |key|
          @cache.delete(key)
        end
      end
    end

    def handle_session_error(error, operation, session_id)
      Rails.logger.error "Session Optimizer Error (#{operation}): #{error.message} for session: #{session_id}"

      # Apply self-healing if enabled
      self_heal_sessions if @self_healing_enabled
    end
  end
end
