# frozen_string_literal: true

# TypeScript Rails Integration
# Provides seamless TypeScript integration for GraphQL UI Layout in Rails applications

require 'rails/engine'
require 'rails/generators'
require 'json'

module TypeScriptRails
  class Engine < ::Rails::Engine
    isolate_namespace TypeScriptRails

    config.autoload_paths += Dir[root.join('lib', 'typescript_rails', 'generators')]
    config.autoload_paths += Dir[root.join('lib', 'typescript_rails', 'helpers')]

    initializer 'typescript_rails.assets' do |app|
      app.config.assets.paths << root.join('app', 'assets', 'javascripts')
      app.config.assets.paths << root.join('app', 'assets', 'typescripts')
    end

    initializer 'typescript_rails.helpers' do
      ActiveSupport.on_load(:action_view) { include TypeScriptRails::Helpers }
      ActiveSupport.on_load(:action_controller) { include TypeScriptRails::ControllerHelpers }
    end

    initializer 'typescript_rails.config' do
      config.after_initialize do
        TypeScriptRails.configure do |config|
          config.api_base_url = Rails.application.routes.url_helpers.api_v1_url
          config.api_version = 'v1'
          config.default_timeout = 30_000
          config.enable_offline_support = true
          config.cache_ttl = 300_000 # 5 minutes
          config.auto_refresh = true
          config.refresh_interval = 300_000 # 5 minutes
        end
      end
    end
  end

  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def api_config
      {
        baseURL: configuration.api_base_url,
        timeout: configuration.default_timeout,
        headers: {
          "X-API-Version": configuration.api_version,
          "X-Requested-With": 'XMLHttpRequest',
        },
      }
    end

    def generate_types
      generate_type_definitions
    end

    def generate_type_definitions
      types = {
        api_config: api_config,
        routes: generate_routes_config,
        models: generate_models_config,
        permissions: generate_permissions_config,
      }

      Rails.root.join('app/javascript/types/rails-config.ts').write(generate_typescript_config(types))
    end

    private

    def generate_routes_config
      Rails.application.routes.routes.filter_map do |route|
        {
          name: route.name,
          path: route.path.spec.to_s,
          verb: route.verb,
          controller: route.controller,
          action: route.action,
        }
      end
    end

    def generate_models_config
      Rails.application.eager_load!
      ActiveRecord::Base.descendants.map do |model|
        {
          name: model.name,
          table_name: model.table_name,
          attributes: model.column_names,
          associations: model.reflect_on_all_associations.map(&:name),
        }
      end
    end

    def generate_permissions_config
      if defined?(Pundit)
        Rails.application.eager_load!
        ApplicationController.descendants.map do |controller|
          {
            controller: controller.name,
            policies: controller.instance_methods.grep(/policy/),
          }
        end
      else
        []
      end
    end

    def generate_typescript_config(config)
      <<~TYPESCRIPT
        // Auto-generated Rails configuration for TypeScript
        // Generated at: #{Time.current}

        export interface RailsConfig {
          api: {
            baseURL: string;
            timeout: number;
            headers: Record<string, string>;
          };
          routes: Array<{
            name: string;
            path: string;
            verb: string;
            controller: string;
            action: string;
          }>;
          models: Array<{
            name: string;
            table_name: string;
            attributes: string[];
            associations: string[];
          }>;
          permissions: Array<{
            controller: string;
            policies: string[];
          }>;
        }

        export const railsConfig: RailsConfig = #{JSON.pretty_generate(config)};

        export default railsConfig;
      TYPESCRIPT
    end
  end

  class Configuration
    attr_accessor :api_base_url, :api_version, :default_timeout, :enable_offline_support,
                  :cache_ttl, :auto_refresh, :refresh_interval

    def initialize
      @api_base_url = 'http://localhost:3000/api/v1'
      @api_version = 'v1'
      @default_timeout = 30_000
      @enable_offline_support = true
      @cache_ttl = 300_000
      @auto_refresh = true
      @refresh_interval = 300_000
    end
  end
end
