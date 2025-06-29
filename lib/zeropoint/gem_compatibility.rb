# frozen_string_literal: true

module Zeropoint
  # Gem Compatibility and Efficiency Improvement System
  # Provides intelligent detection, compatibility management, and efficiency optimization
  # for Rails-related gems in the Zeropoint ecosystem
  module GemCompatibility
    extend self

    # Gem compatibility matrix
    COMPATIBILITY_MATRIX = {
      # Rails Core
      rails: {
        versions: [ '>= 7.0', '< 9.0' ],
        features: [ :hotwire, :importmaps, :stimulus, :turbo ],
        conflicts: [],
        recommendations: [ :puma, :pg, :redis ],
      },

      # Database
      pg: {
        versions: [ '>= 1.5.0' ],
        features: [ :full_text_search, :json_queries, :trigram_similarity ],
        conflicts: [],
        recommendations: [ :pg_search, :strong_migrations ],
      },
      mysql2: {
        versions: [ '>= 0.5.0' ],
        features: [ :full_text_search, :json_queries ],
        conflicts: [ :pg ],
        recommendations: [ :strong_migrations ],
      },
      sqlite3: {
        versions: [ '>= 1.6.0' ],
        features: [],
        conflicts: [],
        recommendations: [],
      },

      # Search
      elasticsearch_model: {
        versions: [ '>= 7.0.0' ],
        features: [ :advanced_search, :aggregations, :suggestions ],
        conflicts: [],
        recommendations: [ :searchkick ],
      },
      searchkick: {
        versions: [ '>= 5.0.0' ],
        features: [ :elasticsearch_search, :analytics, :suggestions ],
        conflicts: [],
        recommendations: [ :elasticsearch_model ],
      },
      pg_search: {
        versions: [ '>= 2.3.0' ],
        features: [ :full_text_search, :trigram_similarity, :multisearch ],
        conflicts: [],
        recommendations: [ :pg ],
      },
      ransack: {
        versions: [ '>= 4.3.0' ],
        features: [ :filtering, :sorting, :search ],
        conflicts: [],
        recommendations: [],
      },

      # Caching
      redis: {
        versions: [ '>= 5.0.0' ],
        features: [ :caching, :sessions, :background_jobs ],
        conflicts: [],
        recommendations: [ :sidekiq, :connection_pool ],
      },
      dalli: {
        versions: [ '>= 3.2.0' ],
        features: [ :memcached_caching ],
        conflicts: [],
        recommendations: [],
      },

      # Background Jobs
      sidekiq: {
        versions: [ '>= 7.0.0' ],
        features: [ :background_jobs, :scheduled_jobs, :monitoring ],
        conflicts: [],
        recommendations: [ :redis, :sidekiq_scheduler ],
      },
      resque: {
        versions: [ '>= 2.7.0' ],
        features: [ :background_jobs, :monitoring ],
        conflicts: [ :sidekiq ],
        recommendations: [ :redis ],
      },

      # Authentication & Authorization
      devise: {
        versions: [ '>= 4.9.0' ],
        features: [ :authentication, :registration, :password_reset ],
        conflicts: [],
        recommendations: [ :pundit, :rolify ],
      },
      pundit: {
        versions: [ '>= 2.3.0' ],
        features: [ :authorization, :policies ],
        conflicts: [ :cancancan ],
        recommendations: [ :devise ],
      },
      cancancan: {
        versions: [ '>= 3.4.0' ],
        features: [ :authorization, :abilities ],
        conflicts: [ :pundit ],
        recommendations: [ :devise ],
      },
      rolify: {
        versions: [ '>= 6.0.0' ],
        features: [ :role_management ],
        conflicts: [],
        recommendations: [ :devise, :pundit ],
      },

      # File Storage
      carrierwave: {
        versions: [ '>= 2.2.0' ],
        features: [ :file_uploads, :image_processing ],
        conflicts: [ :shrine ],
        recommendations: [ :mini_magick, :aws_sdk_s3 ],
      },
      shrine: {
        versions: [ '>= 3.0.0' ],
        features: [ :file_uploads, :image_processing, :direct_uploads ],
        conflicts: [ :carrierwave ],
        recommendations: [ :aws_sdk_s3 ],
      },
      aws_sdk_s3: {
        versions: [ '>= 1.0.0' ],
        features: [ :cloud_storage, :cdn ],
        conflicts: [],
        recommendations: [ :carrierwave, :shrine ],
      },

      # API & Serialization
      graphql: {
        versions: [ '>= 2.0.0' ],
        features: [ :api_graphql, :schema, :queries ],
        conflicts: [],
        recommendations: [ :graphql_batch, :graphql_persisted_queries ],
      },
      active_model_serializers: {
        versions: [ '>= 0.10.0' ],
        features: [ :json_serialization ],
        conflicts: [],
        recommendations: [],
      },
      jbuilder: {
        versions: [ '>= 2.11.0' ],
        features: [ :json_building ],
        conflicts: [],
        recommendations: [],
      },

      # UI & Frontend
      stimulus_rails: {
        versions: [ '>= 1.0.0' ],
        features: [ :stimulus_integration ],
        conflicts: [],
        recommendations: [ :turbo_rails ],
      },
      turbo_rails: {
        versions: [ '>= 1.5.0' ],
        features: [ :turbo_drive, :turbo_frames ],
        conflicts: [],
        recommendations: [ :stimulus_rails ],
      },
      importmap_rails: {
        versions: [ '>= 1.1.0' ],
        features: [ :javascript_imports ],
        conflicts: [ :webpacker ],
        recommendations: [ :stimulus_rails ],
      },
      view_component: {
        versions: [ '>= 3.0.0' ],
        features: [ :ui_components ],
        conflicts: [],
        recommendations: [ :tailwindcss_rails ],
      },
      tailwindcss_rails: {
        versions: [ '>= 2.0.0' ],
        features: [ :css_framework, :utility_classes ],
        conflicts: [ :bootstrap ],
        recommendations: [ :view_component ],
      },

      # Testing
      rspec_rails: {
        versions: [ '>= 6.0.0' ],
        features: [ :testing_framework ],
        conflicts: [ :minitest ],
        recommendations: [ :factory_bot_rails, :capybara ],
      },
      factory_bot_rails: {
        versions: [ '>= 6.0.0' ],
        features: [ :test_data ],
        conflicts: [],
        recommendations: [ :rspec_rails, :faker ],
      },
      capybara: {
        versions: [ '>= 3.38.0' ],
        features: [ :integration_testing ],
        conflicts: [],
        recommendations: [ :rspec_rails, :selenium_webdriver ],
      },

      # Code Quality
      rubocop: {
        versions: [ '>= 1.75.0' ],
        features: [ :code_style, :linting ],
        conflicts: [],
        recommendations: [ :rubocop_rails, :rubocop_rspec ],
      },
      brakeman: {
        versions: [ '>= 5.4.0' ],
        features: [ :security_scanning ],
        conflicts: [],
        recommendations: [ :bundler_audit ],
      },
      bullet: {
        versions: [ '>= 7.0.0' ],
        features: [ :n_plus_one_detection ],
        conflicts: [],
        recommendations: [],
      },
    }.freeze

    # Efficiency optimization strategies
    EFFICIENCY_STRATEGIES = {
      # Database optimizations
      database: {
        pg: {
          connection_pooling: true,
          prepared_statements: true,
          query_optimization: true,
          index_optimization: true,
        },
        mysql2: {
          connection_pooling: true,
          query_cache: true,
          index_optimization: true,
        },
        sqlite3: {
          journal_mode: 'WAL',
          synchronous: 'NORMAL',
          cache_size: 10000,
        },
      },

      # Caching optimizations
      caching: {
        redis: {
          connection_pooling: true,
          compression: true,
          serialization: 'oj',
          key_expiration: true,
        },
        dalli: {
          compression: true,
          serialization: 'oj',
          key_expiration: true,
        },
      },

      # Background job optimizations
      background_jobs: {
        sidekiq: {
          concurrency: 10,
          queue_prioritization: true,
          batch_processing: true,
          monitoring: true,
        },
        resque: {
          queue_prioritization: true,
          monitoring: true,
        },
      },

      # Search optimizations
      search: {
        elasticsearch_model: {
          index_optimization: true,
          query_caching: true,
          bulk_operations: true,
        },
        searchkick: {
          index_optimization: true,
          query_caching: true,
          bulk_operations: true,
        },
        pg_search: {
          index_optimization: true,
          trigram_similarity: true,
        },
      },
    }.freeze

    # Initialize gem compatibility system
    def init!
      detect_installed_gems
      configure_compatibility
      apply_efficiency_optimizations
      log_compatibility_report
    end

    # Detect installed gems
    def detect_installed_gems
      @installed_gems = {}

      COMPATIBILITY_MATRIX.each do |gem_name, config|
        begin
          require gem_name.to_s
          @installed_gems[gem_name] = {
            installed: true,
            version: get_gem_version(gem_name),
            features: config[:features],
            compatible: check_version_compatibility(gem_name, config[:versions]),
          }
        rescue LoadError, RuntimeError => e
          # Handle both LoadError and RuntimeError (like Bullet compatibility issues)
          safe_log_warn "#{gem_name} gem skipped: #{e.message}"
          @installed_gems[gem_name] = {
            installed: false,
            version: nil,
            features: [],
            compatible: false,
            error: e.message,
          }
        rescue StandardError => e
          # Handle any other unexpected errors
          safe_log_warn "#{gem_name} gem detection failed: #{e.message}"
          @installed_gems[gem_name] = {
            installed: false,
            version: nil,
            features: [],
            compatible: false,
            error: e.message,
          }
        end
      end

      @installed_gems
    end

    # Configure compatibility settings
    def configure_compatibility
      return unless @installed_gems

      # Check for conflicts
      resolve_conflicts

      # Apply recommendations
      apply_recommendations

      # Configure Rails integration
      configure_rails_integration
    end

    # Apply efficiency optimizations
    def apply_efficiency_optimizations
      return unless @installed_gems

      @installed_gems.each do |gem_name, gem_info|
        next unless gem_info[:installed] && gem_info[:compatible]

        case gem_name
        when :pg, :mysql2, :sqlite3
          optimize_database(gem_name)
        when :redis, :dalli
          optimize_caching(gem_name)
        when :sidekiq, :resque
          optimize_background_jobs(gem_name)
        when :elasticsearch_model, :searchkick, :pg_search
          optimize_search(gem_name)
        end
      end
    end

    # Get gem version
    def get_gem_version(gem_name)
      case gem_name
      when :rails
        Rails.version
      when :pg
        defined?(PG) ? PG.library_version.to_s : nil
      when :redis
        defined?(Redis) ? Redis::VERSION : nil
      when :sidekiq
        defined?(Sidekiq) ? Sidekiq::VERSION : nil
      when :graphql
        defined?(GraphQL) ? GraphQL::VERSION : nil
      else
        # Try to get version from gem specification
        begin
          Gem.loaded_specs[gem_name.to_s]&.version&.to_s
        rescue StandardError
          nil
        end
      end
    end

    # Check version compatibility
    def check_version_compatibility(gem_name, version_requirements)
      version = get_gem_version(gem_name)
      return false unless version

      version_requirements.all? do |requirement|
        Gem::Requirement.new(requirement).satisfied_by?(Gem::Version.new(version))
      end
    end

    # Resolve gem conflicts
    def resolve_conflicts
      conflicts = []

      @installed_gems.each do |gem_name, gem_info|
        next unless gem_info[:installed]

        config = COMPATIBILITY_MATRIX[gem_name]
        next unless config[:conflicts]

        config[:conflicts].each do |conflicting_gem|
          if @installed_gems[conflicting_gem]&.dig(:installed)
            conflicts << {
              gem: gem_name,
              conflicting_gem: conflicting_gem,
              severity: 'warning',
            }
          end
        end
      end

      log_conflicts(conflicts) if conflicts.any?
    end

    # Apply gem recommendations
    def apply_recommendations
      recommendations = []

      @installed_gems.each do |gem_name, gem_info|
        next unless gem_info[:installed]

        config = COMPATIBILITY_MATRIX[gem_name]
        next unless config[:recommendations]

        config[:recommendations].each do |recommended_gem|
          unless @installed_gems[recommended_gem]&.dig(:installed)
            recommendations << {
              gem: gem_name,
              recommended_gem: recommended_gem,
              reason: "Enhances #{gem_name} functionality",
            }
          end
        end
      end

      log_recommendations(recommendations) if recommendations.any?
    end

    # Configure Rails integration
    def configure_rails_integration
      return unless defined?(Rails)

      # Configure database adapter optimizations
      configure_database_optimizations

      # Configure caching optimizations
      configure_caching_optimizations

      # Configure background job optimizations
      configure_background_job_optimizations

      # Configure search optimizations
      configure_search_optimizations
    end

    # Optimize database
    def optimize_database(gem_name)
      case gem_name
      when :pg
        optimize_postgresql
      when :mysql2
        optimize_mysql
      when :sqlite3
        optimize_sqlite
      end
    end

    # Optimize PostgreSQL
    def optimize_postgresql
      return unless defined?(ActiveRecord::Base)

      ActiveRecord::Base.connection.execute(<<~SQL)
        SET enable_seqscan = off;
        SET random_page_cost = 1.1;
        SET effective_cache_size = '256MB';
      SQL

      safe_log_info '🐘 PostgreSQL optimizations applied'
    rescue StandardError => e
      safe_log_warn "⚠️ PostgreSQL optimization failed: #{e.message}"
    end

    # Optimize MySQL
    def optimize_mysql
      return unless defined?(ActiveRecord::Base)

      ActiveRecord::Base.connection.execute(<<~SQL)
        SET SESSION query_cache_type = ON;
        SET SESSION query_cache_size = 67108864;
      SQL

      safe_log_info '🐬 MySQL optimizations applied'
    rescue StandardError => e
      safe_log_warn "⚠️ MySQL optimization failed: #{e.message}"
    end

    # Optimize SQLite
    def optimize_sqlite
      return unless defined?(ActiveRecord::Base)

      ActiveRecord::Base.connection.execute(<<~SQL)
        PRAGMA journal_mode = WAL;
        PRAGMA synchronous = NORMAL;
        PRAGMA cache_size = 10000;
        PRAGMA temp_store = MEMORY;
      SQL

      safe_log_info '📱 SQLite optimizations applied'
    rescue StandardError => e
      safe_log_warn "⚠️ SQLite optimization failed: #{e.message}"
    end

    # Optimize caching
    def optimize_caching(gem_name)
      case gem_name
      when :redis
        optimize_redis
      when :dalli
        optimize_memcached
      end
    end

    # Optimize Redis
    def optimize_redis
      return unless defined?(Redis)

      # Configure Redis with optimizations
      redis_config = {
        url: ENV['REDIS_URL'] || 'redis://localhost:6379/0',
        timeout: 1,
        reconnect_attempts: 3,
        compression: true,
      }

      Rails.cache = ActiveSupport::Cache::RedisCacheStore.new(redis_config)
      safe_log_info '🔴 Redis optimizations applied'
    rescue StandardError => e
      safe_log_warn "⚠️ Redis optimization failed: #{e.message}"
    end

    # Optimize Memcached
    def optimize_memcached
      return unless defined?(Dalli)

      # Configure Memcached with optimizations
      memcached_config = {
        servers: ENV['MEMCACHED_SERVERS'] || 'localhost:11211',
        compression: true,
        compression_threshold: 1024,
      }

      Rails.cache = ActiveSupport::Cache::MemCacheStore.new(memcached_config)
      safe_log_info '💾 Memcached optimizations applied'
    rescue StandardError => e
      safe_log_warn "⚠️ Memcached optimization failed: #{e.message}"
    end

    # Optimize background jobs
    def optimize_background_jobs(gem_name)
      case gem_name
      when :sidekiq
        optimize_sidekiq
      when :resque
        optimize_resque
      end
    end

    # Optimize Sidekiq
    def optimize_sidekiq
      return unless defined?(Sidekiq)

      Sidekiq.configure_server do |config|
        config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/0' }
        config.concurrency = ENV.fetch('SIDEKIQ_CONCURRENCY', 10).to_i
        config.queues = %w[default high low]
      end

      safe_log_info '⚡ Sidekiq optimizations applied'
    rescue StandardError => e
      safe_log_warn "⚠️ Sidekiq optimization failed: #{e.message}"
    end

    # Optimize Resque
    def optimize_resque
      return unless defined?(Resque)

      Resque.redis = Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379/0')
      safe_log_info '⚡ Resque optimizations applied'
    rescue StandardError => e
      safe_log_warn "⚠️ Resque optimization failed: #{e.message}"
    end

    # Optimize search
    def optimize_search(gem_name)
      case gem_name
      when :elasticsearch_model
        optimize_elasticsearch
      when :searchkick
        optimize_searchkick
      when :pg_search
        optimize_pg_search
      end
    end

    # Optimize Elasticsearch
    def optimize_elasticsearch
      return unless defined?(Elasticsearch::Model)

      # Configure Elasticsearch client with optimizations
      Elasticsearch::Model.client = Elasticsearch::Client.new(
        url: ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200',
        retry_on_failure: 3,
        reload_connections: true,
        randomize_hosts: true
      )

      safe_log_info '🔍 Elasticsearch optimizations applied'
    rescue StandardError => e
      safe_log_warn "⚠️ Elasticsearch optimization failed: #{e.message}"
    end

    # Optimize Searchkick
    def optimize_searchkick
      return unless defined?(Searchkick)

      Searchkick.client_options = {
        retry_on_failure: 3,
        reload_connections: true,
        randomize_hosts: true,
      }

      safe_log_info '🔍 Searchkick optimizations applied'
    rescue StandardError => e
      safe_log_warn "⚠️ Searchkick optimization failed: #{e.message}"
    end

    # Optimize PgSearch
    def optimize_pg_search
      return unless defined?(PgSearch)

      # PgSearch optimizations are handled at the model level
      safe_log_info '🔍 PgSearch optimizations available'
    rescue StandardError => e
      safe_log_warn "⚠️ PgSearch optimization failed: #{e.message}"
    end

    # Log compatibility report
    def log_compatibility_report
      return unless @installed_gems

      safe_log_info '💎 Gem Compatibility Report'
      safe_log_info '=' * 50

      installed_count = @installed_gems.count { |_, info| info[:installed] }
      compatible_count = @installed_gems.count { |_, info| info[:installed] && info[:compatible] }

      safe_log_info "Installed gems: #{installed_count}"
      safe_log_info "Compatible gems: #{compatible_count}"
      safe_log_info "Compatibility rate: #{(compatible_count.to_f / installed_count * 100).round(1)}%"

      @installed_gems.each do |gem_name, info|
        if info[:installed]
          status = info[:compatible] ? '✅' : '⚠️'
          safe_log_info "#{status} #{gem_name}: #{info[:version]}"
        end
      end
    end

    # Log conflicts
    def log_conflicts(conflicts)
      safe_log_warn '⚠️ Gem Conflicts Detected'
      conflicts.each do |conflict|
        safe_log_warn "  #{conflict[:gem]} conflicts with #{conflict[:conflicting_gem]}"
      end
    end

    # Log recommendations
    def log_recommendations(recommendations)
      safe_log_info '💡 Gem Recommendations'
      recommendations.each do |rec|
        safe_log_info "  Consider adding #{rec[:recommended_gem]} for #{rec[:gem]}: #{rec[:reason]}"
      end
    end

    # Get compatibility status
    def compatibility_status
      return {} unless @installed_gems

      {
        installed_gems: @installed_gems,
        conflicts: detect_conflicts,
        recommendations: detect_recommendations,
        efficiency_optimizations: get_applied_optimizations,
      }
    end

    # Detect conflicts
    def detect_conflicts
      conflicts = []

      @installed_gems.each do |gem_name, gem_info|
        next unless gem_info[:installed]

        config = COMPATIBILITY_MATRIX[gem_name]
        next unless config[:conflicts]

        config[:conflicts].each do |conflicting_gem|
          if @installed_gems[conflicting_gem]&.dig(:installed)
            conflicts << {
              gem: gem_name,
              conflicting_gem: conflicting_gem,
            }
          end
        end
      end

      conflicts
    end

    # Detect recommendations
    def detect_recommendations
      recommendations = []

      @installed_gems.each do |gem_name, gem_info|
        next unless gem_info[:installed]

        config = COMPATIBILITY_MATRIX[gem_name]
        next unless config[:recommendations]

        config[:recommendations].each do |recommended_gem|
          unless @installed_gems[recommended_gem]&.dig(:installed)
            recommendations << {
              gem: gem_name,
              recommended_gem: recommended_gem,
            }
          end
        end
      end

      recommendations
    end

    # Get applied optimizations
    def get_applied_optimizations
      optimizations = []

      @installed_gems.each do |gem_name, gem_info|
        next unless gem_info[:installed] && gem_info[:compatible]

        case gem_name
        when :pg, :mysql2, :sqlite3
          optimizations << "database_#{gem_name}"
        when :redis, :dalli
          optimizations << "caching_#{gem_name}"
        when :sidekiq, :resque
          optimizations << "background_jobs_#{gem_name}"
        when :elasticsearch_model, :searchkick, :pg_search
          optimizations << "search_#{gem_name}"
        end
      end

      optimizations
    end

    private

    # Safe logging methods that work with or without Rails
    def safe_log_info(message)
      if defined?(Rails) && Rails.logger
        Rails.logger.info message
      else
        Rails.logger.debug "INFO: #{message}"
      end
    end

    def safe_log_warn(message)
      if defined?(Rails) && Rails.logger
        Rails.logger.warn message
      else
        Rails.logger.debug "WARN: #{message}"
      end
    end

    # Configure database optimizations
    def configure_database_optimizations
      # Database-specific optimizations are applied in optimize_database methods
    end

    # Configure caching optimizations
    def configure_caching_optimizations
      # Caching optimizations are applied in optimize_caching methods
    end

    # Configure background job optimizations
    def configure_background_job_optimizations
      # Background job optimizations are applied in optimize_background_jobs methods
    end

    # Configure search optimizations
    def configure_search_optimizations
      # Search optimizations are applied in optimize_search methods
    end
  end
end
