# frozen_string_literal: true

# TypeScript Hook Generator
# Generates TypeScript React hooks for Rails applications

require 'rails/generators'

module TypeScriptRails
  module Generators
    class HookGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      desc 'Generate a TypeScript React hook'

      argument :hook_name, type: :string, required: true
      argument :dependencies, type: :array, default: [], banner: 'dep1 dep2 dep3'

      def create_hook_file
        template 'hook.ts.erb', "app/javascript/hooks/#{hook_name}.ts"
      end

      def create_hook_test_file
        template 'hook.test.ts.erb', "app/javascript/hooks/__tests__/#{hook_name}.test.ts"
      end

      def create_hook_types_file
        template 'hook.types.ts.erb', "app/javascript/hooks/#{hook_name}.types.ts"
      end

      private

      def hook_class_name
        hook_name.camelize
      end

      def hook_file_name
        hook_name.underscore
      end

      def dependencies_interface
        return '{}' if dependencies.empty?

        dependencies.map do |dep|
          dep_name, dep_type = dep.split(':')
          dep_type ||= 'any'
          "  #{dep_name}: #{dep_type};"
        end.join("\n")
      end

      def dependencies_destructuring
        return '' if dependencies.empty?

        dependencies.map { |dep| dep.split(':').first }.join(', ')
      end

      def dependencies_validation
        return '' if dependencies.empty?

        dependencies.map do |dep|
          dep_name = dep.split(':').first
          "    #{dep_name}: PropTypes.any.isRequired,"
        end.join("\n")
      end
    end
  end
end
