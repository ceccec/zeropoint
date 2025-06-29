# frozen_string_literal: true

# TypeScript Component Generator
# Generates TypeScript React components for Rails applications

require 'rails/generators'

module TypeScriptRails
  module Generators
    class ComponentGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      desc 'Generate a TypeScript React component'

      argument :component_name, type: :string, required: true
      argument :props, type: :array, default: [], banner: 'prop1 prop2 prop3'

      def create_component_file
        template 'component.tsx.erb', "app/javascript/components/#{component_name}.tsx"
      end

      def create_component_test_file
        template 'component.test.tsx.erb', "app/javascript/components/__tests__/#{component_name}.test.tsx"
      end

      def create_component_styles_file
        template 'component.scss.erb', "app/javascript/components/#{component_name}.scss"
      end

      def create_component_types_file
        template 'component.types.ts.erb', "app/javascript/components/#{component_name}.types.ts"
      end

      private

      def component_class_name
        component_name.camelize
      end

      def component_file_name
        component_name.underscore
      end

      def props_interface
        return '{}' if props.empty?

        props.map do |prop|
          prop_name, prop_type = prop.split(':')
          prop_type ||= 'any'
          "  #{prop_name}: #{prop_type};"
        end.join("\n")
      end

      def props_destructuring
        return '' if props.empty?

        props.map { |prop| prop.split(':').first }.join(', ')
      end

      def props_validation
        return '' if props.empty?

        props.map do |prop|
          prop_name = prop.split(':').first
          "    #{prop_name}: PropTypes.any.isRequired,"
        end.join("\n")
      end
    end
  end
end
