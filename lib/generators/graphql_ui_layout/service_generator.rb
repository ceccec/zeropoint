# frozen_string_literal: true

require 'rails/generators/base'

module Zeropoint
  module Generators
    class ServiceGenerator < Rails::Generators::Base
      source_root File.expand_path('templates/services', __dir__)

      argument :service_type, type: :string, required: true,
                              desc: 'Type of service to generate (search, pagination, authorization)'

      class_option :backend, type: :string, default: 'auto',
                             desc: 'Backend to use (auto, kaminari, will_paginate, ransack, pg_search, rolify, pundit)'

      def generate_service
        case service_type.downcase
        when 'search'
          generate_search_service
        when 'pagination'
          generate_pagination_service
        when 'authorization'
          generate_authorization_service
        else
          Rails.logger.debug { "Unknown service type: #{service_type}" }
          Rails.logger.debug 'Available types: search, pagination, authorization'
        end
      end

      private

      def generate_search_service
        template 'search_service.rb.erb',
                 'app/services/zeropoint/search_service.rb'
        template 'search_service_spec.rb.erb',
                 'spec/services/zeropoint/search_service_spec.rb'
        Rails.logger.debug { "Generated search service with #{options[:backend]} backend" }
      end

      def generate_pagination_service
        template 'pagination_service.rb.erb',
                 'app/services/zeropoint/pagination_service.rb'
        template 'pagination_service_spec.rb.erb',
                 'spec/services/zeropoint/pagination_service_spec.rb'
        Rails.logger.debug { "Generated pagination service with #{options[:backend]} backend" }
      end

      def generate_authorization_service
        template 'authorization_service.rb.erb',
                 'app/services/zeropoint/authorization_service.rb'
        template 'authorization_service_spec.rb.erb',
                 'spec/services/zeropoint/authorization_service_spec.rb'
        Rails.logger.debug { "Generated authorization service with #{options[:backend]} backend" }
      end

      def backend_gem
        options[:backend]
      end

      def service_class_name
        "#{service_type.camelize}Service"
      end

      def backend_class_name
        case backend_gem
        when 'kaminari'
          'KaminariBackend'
        when 'will_paginate'
          'WillPaginateBackend'
        when 'ransack'
          'RansackBackend'
        when 'pg_search'
          'PgSearchBackend'
        when 'rolify'
          'RolifyBackend'
        when 'pundit'
          'PunditBackend'
        else
          'AutoDetectBackend'
        end
      end
    end
  end
end
