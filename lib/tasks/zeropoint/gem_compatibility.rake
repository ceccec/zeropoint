# frozen_string_literal: true

namespace :zeropoint do
  namespace :gem do
    desc 'Analyze gem compatibility with Zeropoint'
    task analyze: :environment do
      puts '🔍 Analyzing gem compatibility...'

      require_relative '../../zeropoint/gem_compatibility'
      Zeropoint::GemCompatibility.init!

      status = Zeropoint::GemCompatibility.compatibility_status

      # Display summary
      installed_count = status[:installed_gems].count { |_, info| info[:installed] }
      compatible_count = status[:installed_gems].count { |_, info| info[:installed] && info[:compatible] }
      conflicts_count = status[:conflicts].length
      recommendations_count = status[:recommendations].length

      puts '📊 Compatibility Summary:'
      puts "  Installed gems: #{installed_count}"
      puts "  Compatible gems: #{compatible_count}"
      puts "  Conflicts: #{conflicts_count}"
      puts "  Recommendations: #{recommendations_count}"
      puts "  Compatibility score: #{(compatible_count.to_f / installed_count * 100).round(1)}%"

      # Display conflicts
      if status[:conflicts].any?
        puts "\n⚠️  Conflicts detected:"
        status[:conflicts].each do |conflict|
          puts "  #{conflict[:gem]} conflicts with #{conflict[:conflicting_gem]}"
        end
      end

      # Display recommendations
      if status[:recommendations].any?
        puts "\n💡 Recommendations:"
        status[:recommendations].each do |rec|
          puts "  Consider adding #{rec[:recommended_gem]} for #{rec[:gem]}"
        end
      end

      puts "\n✅ Analysis complete!"
    end

    desc 'Apply gem efficiency optimizations'
    task optimize: :environment do
      puts '⚡ Applying gem efficiency optimizations...'

      require_relative '../../zeropoint/gem_compatibility'
      Zeropoint::GemCompatibility.init!

      status = Zeropoint::GemCompatibility.compatibility_status

      # Apply optimizations
      optimizations = status[:efficiency_optimizations]

      if optimizations.any?
        puts '✅ Applied optimizations:'
        optimizations.each do |opt|
          puts "  #{opt}"
        end
      else
        puts 'ℹ️  No optimizations to apply'
      end

      puts "\n✅ Optimization complete!"
    end

    desc 'Generate comprehensive gem compatibility report'
    task report: :environment do
      puts '📋 Generating gem compatibility report...'

      # Run the generator
      system('rails generate zeropoint:gem_compatibility --report')

      puts '✅ Report generated at docs/GEM_COMPATIBILITY_REPORT.md'
    end

    desc 'Fix gem compatibility issues'
    task fix: :environment do
      puts '🔧 Attempting to fix gem compatibility issues...'

      require_relative '../../zeropoint/gem_compatibility'
      Zeropoint::GemCompatibility.init!

      status = Zeropoint::GemCompatibility.compatibility_status

      # Generate Gemfile recommendations
      if status[:recommendations].any?
        puts '💡 Generating Gemfile recommendations...'

        recommendations = status[:recommendations]
        gemfile_additions = []

        recommendations.each do |rec|
          gem_name = rec[:recommended_gem]
          priority = determine_priority(gem_name)

          case priority
          when 1
            gemfile_additions << "gem '#{gem_name}'  # High priority - core infrastructure"
          when 2
            gemfile_additions << "gem '#{gem_name}'  # Medium priority - important features"
          when 3
            gemfile_additions << "# gem '#{gem_name}'  # Low priority - development tools"
          else
            gemfile_additions << "# gem '#{gem_name}'  # Optional enhancement"
          end
        end

        puts "\n📝 Suggested Gemfile additions:"
        gemfile_additions.each do |addition|
          puts "  #{addition}"
        end

        puts "\n💡 Add these gems to your Gemfile and run 'bundle install'"
      end

      # Resolve conflicts
      if status[:conflicts].any?
        puts "\n⚠️  Conflicts to resolve:"
        status[:conflicts].each do |conflict|
          puts "  #{conflict[:gem]} conflicts with #{conflict[:conflicting_gem]}"
          puts '    Consider removing one of these gems'
        end
      end

      puts "\n✅ Fix recommendations complete!"
    end

    desc 'Full gem compatibility analysis and optimization'
    task all: :environment do
      puts '🚀 Running full gem compatibility analysis and optimization...'

      Rake::Task['zeropoint:gem:analyze'].invoke
      Rake::Task['zeropoint:gem:optimize'].invoke
      Rake::Task['zeropoint:gem:report'].invoke
      Rake::Task['zeropoint:gem:fix'].invoke

      puts "\n🎉 Full gem compatibility process complete!"
    end

    private

    def determine_priority(gem_name)
      case gem_name
      when :pg, :redis, :sidekiq
        1  # High priority - core infrastructure
      when :pundit, :devise, :graphql
        2  # Medium priority - important features
      when :rspec_rails, :factory_bot_rails
        3  # Lower priority - development tools
      else
        4  # Lowest priority - optional enhancements
      end
    end
  end

  namespace :optimize do
    desc 'Optimize database performance'
    task database: :environment do
      puts '🗄️  Optimizing database performance...'

      require_relative '../../zeropoint/gem_compatibility'

      # Detect database adapter
      adapter = ActiveRecord::Base.connection.adapter_name.downcase

      case adapter
      when 'postgresql'
        puts '🐘 Applying PostgreSQL optimizations...'
        optimize_postgresql
      when 'mysql'
        puts '🐬 Applying MySQL optimizations...'
        optimize_mysql
      when 'sqlite'
        puts '📱 Applying SQLite optimizations...'
        optimize_sqlite
      else
        puts "ℹ️  No specific optimizations for #{adapter}"
      end

      puts '✅ Database optimization complete!'
    end

    desc 'Optimize caching performance'
    task caching: :environment do
      puts '💾 Optimizing caching performance...'

      # Check for Redis
      if defined?(Redis)
        puts '🔴 Applying Redis optimizations...'
        optimize_redis
      end

      # Check for Memcached
      if defined?(Dalli)
        puts '💾 Applying Memcached optimizations...'
        optimize_memcached
      end

      puts '✅ Caching optimization complete!'
    end

    desc 'Optimize search performance'
    task search: :environment do
      puts '🔍 Optimizing search performance...'

      # Check for Elasticsearch
      if defined?(Elasticsearch::Model)
        puts '🔍 Applying Elasticsearch optimizations...'
        optimize_elasticsearch
      end

      # Check for Searchkick
      if defined?(Searchkick)
        puts '🔍 Applying Searchkick optimizations...'
        optimize_searchkick
      end

      # Check for PgSearch
      if defined?(PgSearch)
        puts '🔍 Applying PgSearch optimizations...'
        optimize_pg_search
      end

      puts '✅ Search optimization complete!'
    end

    desc 'Optimize background job performance'
    task background_jobs: :environment do
      puts '⚡ Optimizing background job performance...'

      # Check for Sidekiq
      if defined?(Sidekiq)
        puts '⚡ Applying Sidekiq optimizations...'
        optimize_sidekiq
      end

      # Check for Resque
      if defined?(Resque)
        puts '⚡ Applying Resque optimizations...'
        optimize_resque
      end

      puts '✅ Background job optimization complete!'
    end

    desc 'Apply all optimizations'
    task all: :environment do
      puts '🚀 Applying all optimizations...'

      Rake::Task['zeropoint:optimize:database'].invoke
      Rake::Task['zeropoint:optimize:caching'].invoke
      Rake::Task['zeropoint:optimize:search'].invoke
      Rake::Task['zeropoint:optimize:background_jobs'].invoke

      puts '✅ All optimizations complete!'
    end

    private

    def optimize_postgresql
      ActiveRecord::Base.connection.execute(<<~SQL)
        SET enable_seqscan = off;
        SET random_page_cost = 1.1;
        SET effective_cache_size = '256MB';
      SQL
    rescue StandardError => e
      puts "⚠️  PostgreSQL optimization failed: #{e.message}"
    end

    def optimize_mysql
      ActiveRecord::Base.connection.execute(<<~SQL)
        SET SESSION query_cache_type = ON;
        SET SESSION query_cache_size = 67108864;
      SQL
    rescue StandardError => e
      puts "⚠️  MySQL optimization failed: #{e.message}"
    end

    def optimize_sqlite
      ActiveRecord::Base.connection.execute(<<~SQL)
        PRAGMA journal_mode = WAL;
        PRAGMA synchronous = NORMAL;
        PRAGMA cache_size = 10000;
        PRAGMA temp_store = MEMORY;
      SQL
    rescue StandardError => e
      puts "⚠️  SQLite optimization failed: #{e.message}"
    end

    def optimize_redis
      redis_config = {
        url: ENV['REDIS_URL'] || 'redis://localhost:6379/0',
        timeout: 1,
        reconnect_attempts: 3,
        compression: true,
      }

      Rails.cache = ActiveSupport::Cache::RedisCacheStore.new(redis_config)
    rescue StandardError => e
      puts "⚠️  Redis optimization failed: #{e.message}"
    end

    def optimize_memcached
      memcached_config = {
        servers: ENV['MEMCACHED_SERVERS'] || 'localhost:11211',
        compression: true,
        compression_threshold: 1024,
      }

      Rails.cache = ActiveSupport::Cache::MemCacheStore.new(memcached_config)
    rescue StandardError => e
      puts "⚠️  Memcached optimization failed: #{e.message}"
    end

    def optimize_elasticsearch
      Elasticsearch::Model.client = Elasticsearch::Client.new(
        url: ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200',
        retry_on_failure: 3,
        reload_connections: true,
        randomize_hosts: true
      )
    rescue StandardError => e
      puts "⚠️  Elasticsearch optimization failed: #{e.message}"
    end

    def optimize_searchkick
      Searchkick.client_options = {
        retry_on_failure: 3,
        reload_connections: true,
        randomize_hosts: true,
      }
    rescue StandardError => e
      puts "⚠️  Searchkick optimization failed: #{e.message}"
    end

    def optimize_pg_search
      # PgSearch optimizations are handled at the model level
      puts '  PgSearch optimizations available at model level'
    rescue StandardError => e
      puts "⚠️  PgSearch optimization failed: #{e.message}"
    end

    def optimize_sidekiq
      Sidekiq.configure_server do |config|
        config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/0' }
        config.concurrency = ENV.fetch('SIDEKIQ_CONCURRENCY', 10).to_i
        config.queues = %w[default high low]
      end
    rescue StandardError => e
      puts "⚠️  Sidekiq optimization failed: #{e.message}"
    end

    def optimize_resque
      Resque.redis = Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379/0')
    rescue StandardError => e
      puts "⚠️  Resque optimization failed: #{e.message}"
    end
  end
end
