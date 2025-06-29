# frozen_string_literal: true

# Zero Point Configuration
module DemoAppConfig
  def self.configure_features(config)
    config.features = %i[
      graphql
      rails
      search
      pagination
      authorization
      cache
      file_storage
      notifications
      analytics
      streaming
      cosmic_flow
      multi_vortex
    ]
  end

  def self.configure_theme(config)
    config.theme = {
      primary_color: '#6366f1',
      secondary_color: '#8b5cf6',
      accent_color: '#06b6d4',
      success_color: '#10b981',
      warning_color: '#f59e0b',
      danger_color: '#ef4444',
      info_color: '#3b82f6',
      light_color: '#f8fafc',
      dark_color: '#0f172a',
      font_family: 'Inter, system-ui, sans-serif',
      border_radius: '12px',
      box_shadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)',
      transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
      cosmic_gradient: 'linear-gradient(135deg, #6366f1 0%, #8b5cf6 50%, #06b6d4 100%)'
    }
  end

  def self.configure_app_settings(config)
    config.app_config = {
      app_name: 'Zero Point Demo',
      app_description: 'Revolutionary streaming-first data architecture for Rails',
      app_version: '1.0.0',
      api_version: 'v1',
      default_locale: 'en',
      supported_locales: %w[en es fr],
      timezone: 'UTC',
      date_format: '%B %d, %Y',
      time_format: '%I:%M %p',
      website_domain: 'gem.zeropoint.bg',
      github_repo: 'ceccec/zeropoint',
      documentation_url: 'https://gem.zeropoint.bg',
      installation_url: 'https://gem.zeropoint.bg/#installation',
      philosophy: {
        tagline: 'From zero, infinity flows',
        description: 'Every complex system emerges from a simple zero point',
        principles: [
          'Simplicity at the Core',
          'Infinite Potential',
          'Cosmic Unity',
          'Streaming-First Design',
          'Infinite Scalability'
        ]
      },
      pagination: build_pagination_config,
      search: build_search_config,
      cache: build_cache_config,
      offline: build_offline_config,
      streaming: build_streaming_config,
      performance: build_performance_config
    }
  end

  def self.build_pagination_config
    {
      default_per_page: 12,
      max_per_page: 50,
      page_param: 'page',
      per_page_param: 'per_page'
    }
  end

  def self.build_search_config
    {
      default_search_type: 'auto',
      search_types: %w[full_text weighted fuzzy tags exact auto],
      min_query_length: 2,
      max_suggestions: 15
    }
  end

  def self.build_cache_config
    {
      default_ttl: 3600,
      max_ttl: 86_400,
      cache_prefix: 'zeropoint_demo'
    }
  end

  def self.build_offline_config
    {
      enabled: true,
      max_cache_size: '100MB',
      sync_interval: 300,
      background_sync: true
    }
  end

  def self.build_streaming_config
    {
      enabled: true,
      websocket_support: true,
      sse_support: true,
      real_time_updates: true,
      infinite_scroll: true,
      cosmic_flow: true,
      multi_vortex: true
    }
  end

  def self.build_performance_config
    {
      code_reduction: '86%',
      performance_boost: '8x',
      scalability: '∞',
      parallel_processing: true,
      async_operations: true,
      cosmic_optimization: true
    }
  end

  def self.configure_permissions(config)
    config.permission_checker = lambda { |user, action, resource|
      return false unless user

      case action.to_sym
      when :read
        true # Everyone can read
      when :create
        user.confirmed?
      when :update, :destroy
        user.admin? || (resource.respond_to?(:user_id) && resource.user_id == user.id)
      when :manage
        user.admin?
      else
        false
      end
    }
  end

  def self.configure_default_user(config)
    Rails.application.config.after_initialize do
      config.default_user = User.first if defined?(User) && User.exists?
    end
  end

  def self.configure_website_domain(config)
    config.website_domain = 'gem.zeropoint.bg'
  end
end

# Apply configuration
# Zeropoint.configure do |config|
#   DemoAppConfig.configure_features(config)
#   DemoAppConfig.configure_theme(config)
#   DemoAppConfig.configure_app_settings(config)
#   DemoAppConfig.configure_permissions(config)
#   DemoAppConfig.configure_default_user(config)
#   DemoAppConfig.configure_website_domain(config)
# end
