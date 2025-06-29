# frozen_string_literal: true

# Custom Adapters for GraphQL UI Layout Demo
# This demonstrates how to create and register custom adapters

module DemoApp
  module Adapters
    module Search
      class CustomSearchAdapter < Zeropoint::Adapters::BaseAdapter
        def self.available?
          true # Always available for demo
        end

        def search(model, query, _options = {})
          # Custom search logic that combines multiple fields
          model.where(
            'title ILIKE :query OR content ILIKE :query OR tags ILIKE :query',
            query: "%#{query}%",
          ).order(
            'CASE WHEN title ILIKE :query THEN 1 WHEN content ILIKE :query THEN 2 ELSE 3 END',
            query: "%#{query}%",
          )
        end

        def info
          {
            name: 'CustomSearchAdapter',
            available: self.class.available?,
            healthy: true,
            description: 'Custom search with weighted results'
          }
        end
      end
    end

    module Analytics
      class DemoAnalyticsAdapter < Zeropoint::Adapters::BaseAdapter
        def self.available?
          true
        end

        def track_event(event_name, properties = {}, user = nil)
          # Demo analytics tracking
          Rails.logger.info "Demo Analytics: #{event_name} - #{properties} - User: #{user&.id}"

          # In a real app, you might send to a service
          # DemoAnalyticsService.track(event_name, properties, user)
        end

        def info
          {
            name: 'DemoAnalyticsAdapter',
            available: self.class.available?,
            healthy: true,
            description: 'Demo analytics with logging'
          }
        end
      end
    end

    module Cache
      class SmartCacheAdapter < Zeropoint::Adapters::BaseAdapter
        def self.available?
          defined?(Zeropoint)
        end

        def get(key)
          cache_service.read(cache_key(key))
        end

        def set(key, value, ttl = nil)
          cache_service.write(cache_key(key), value, expires_in: ttl || 3600)
        end

        def delete(key)
          cache_service.delete(cache_key(key))
        end

        def clear
          cache_service.clear
        end

        private

        def cache_service
          @cache_service ||= Zeropoint::Core::CacheService.new(Zeropoint.configuration)
        end

        def cache_key(key)
          "demo_app:#{key}"
        end

        def info
          {
            name: 'SmartCacheAdapter',
            available: self.class.available?,
            healthy: true,
            description: 'Smart caching with prefixing'
          }
        end
      end
    end
  end
end

# Register custom adapters with high priority
Rails.application.config.after_initialize do
  container = Zeropoint::DependencyContainer.instance

  # Register custom search adapter with highest priority
  container.register_adapter(
    :search,
    DemoApp::Adapters::Search::CustomSearchAdapter,
    priority: 10,
  )

  # Register custom analytics adapter
  container.register_adapter(
    :analytics,
    DemoApp::Adapters::Analytics::DemoAnalyticsAdapter,
    priority: 5,
  )

  # Register custom cache adapter
  container.register_adapter(
    :cache,
    DemoApp::Adapters::Cache::SmartCacheAdapter,
    priority: 3,
  )

  Rails.logger.info 'Custom adapters registered for GraphQL UI Layout Demo'
end
