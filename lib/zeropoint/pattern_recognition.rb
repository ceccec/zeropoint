# frozen_string_literal: true

require 'find'
require 'yaml'
require 'json'
require 'digest'

module Zeropoint
  # Pattern Recognition Engine: The Void Awakens
  #
  # This module scans the codebase, configuration, and content to recognize
  # patterns that will become the root vortex of truth. It's the first step
  # in the universe's self-creation process.
  module PatternRecognition
    PATTERN_TYPES = {
      controllers: {
        pattern: 'app/controllers/**/*_controller.rb',
        extractors: [ 'class_name', 'actions', 'concerns' ],
      },
      models: {
        pattern: 'app/models/*.rb',
        extractors: [ 'class_name', 'associations', 'validations' ],
      },
      views: {
        pattern: 'app/views/**/*.erb',
        extractors: [ 'template_name', 'variables', 'helpers' ],
      },
      assets: {
        pattern: 'app/assets/**/*',
        extractors: [ 'file_type', 'dependencies', 'file_size' ],
      },
      config: {
        pattern: 'config/**/*.yml',
        extractors: [ 'settings', 'features', 'intelligence' ],
      },
      routes: {
        pattern: 'config/routes.rb',
        extractors: [ 'endpoints', 'resources', 'constraints' ],
      },
      stimulus_controllers: {
        pattern: 'app/assets/javascripts/controllers/*.js',
        extractors: [ 'controller_name', 'targets', 'actions' ],
      },
      stylesheets: {
        pattern: 'app/assets/stylesheets/*.css',
        extractors: [ 'selectors', 'variables', 'imports' ],
      },
    }.freeze

    # Constants for performance optimization
    EXCLUDED_ACTIONS = %w[initialize private protected].freeze

    class << self
      # Main entry point: recognize all patterns in the codebase
      def recognize_patterns_in_codebase
        patterns = {}

        PATTERN_TYPES.each do |type, config|
          patterns[type] = scan_for_patterns(type, config)
        end

        # Add relationships between patterns
        patterns = add_pattern_relationships(patterns)

        # Generate pattern signatures
        patterns = add_pattern_signatures(patterns)

        patterns
      end

      # Recognize patterns in configuration files
      def recognize_patterns_in_config
        config_patterns = {}

        # Scan all YAML config files
        Dir.glob('config/**/*.yml').each do |file|
          config_patterns[file] = extract_config_patterns(file)
        end

        # Scan ENV variables for Zeropoint patterns
        config_patterns['env'] = extract_env_patterns

        config_patterns
      end

      # Recognize patterns in user-generated content
      def recognize_patterns_in_content
        content_patterns = {}

        # Scan for content patterns (posts, comments, etc.)
        if defined?(Post) && Post.respond_to?(:all)
          content_patterns['posts'] = extract_content_patterns(Post.all)
        end

        # Scan for user interaction patterns
        content_patterns['interactions'] = extract_interaction_patterns

        content_patterns
      end

      # Get all recognized patterns
      def all_patterns
        {
          codebase: recognize_patterns_in_codebase,
          config: recognize_patterns_in_config,
          content: recognize_patterns_in_content,
        }
      end

      # Generate a cosmic signature for patterns
      def generate_cosmic_signature(patterns)
        pattern_data = patterns.to_json
        cosmic_hash = Digest::SHA256.hexdigest(pattern_data)

        # Convert to cosmic format (base-9 vortex mathematics)
        cosmic_signature = cosmic_hash.chars.map { |c| c.to_i(16) % 9 }.join
        cosmic_signature[0..15] # First 16 digits
      end

      private

      def scan_for_patterns(type, config)
        patterns = []

        Dir.glob(config['pattern']).each do |file|
          next unless File.file?(file)

          pattern = {
            type: type,
            file: file,
            name: extract_name_from_file(file, type),
            size: File.size(file),
            modified: File.mtime(file).iso8601,
            extractors: {},
          }

          # Apply extractors based on type
          config['extractors'].each do |extractor|
            method_name = "extract_#{extractor}"
            if respond_to?(method_name, true)
              pattern['extractors'][extractor] = send(method_name, file, type)
            else
              pattern['extractors'][extractor] = nil
            end
          end

          patterns << pattern
        end

        patterns
      end

      def extract_name_from_file(file, type)
        case type
        when 'controllers'
          File.basename(file, '_controller.rb').classify
        when 'models'
          File.basename(file, '.rb').classify
        when 'stimulus_controllers'
          File.basename(file, '.js')
        when 'stylesheets'
          File.basename(file, '.css')
        else
          File.basename(file)
        end
      end

      def extract_class_name(file, type)
        return nil unless %w[controllers models].include?(type)

        content = File.read(file)
        if content =~ /class\s+(\w+)/
          $1
        end
      end

      def extract_actions(file, type)
        return nil unless type == 'controllers'

        content = File.read(file)
        actions = content.scan(/def\s+(\w+)/).flatten
        actions.reject { |action| EXCLUDED_ACTIONS.include?(action) }
      end

      def extract_concerns(file, type)
        return nil unless type == 'controllers'

        content = File.read(file)
        concerns = content.scan(/include\s+(\w+)/).flatten
        concerns.map(&:classify)
      end

      def extract_associations(file, type)
        return nil unless type == 'models'

        content = File.read(file)
        associations = []

        %w[has_many belongs_to has_one has_and_belongs_to_many].each do |assoc_type|
          content.scan(/#{assoc_type}\s+:(\w+)/).flatten.each do |assoc|
            associations << { type: assoc_type, name: assoc }
          end
        end

        associations
      end

      def extract_validations(file, type)
        return nil unless type == 'models'

        content = File.read(file)
        validations = []

        %w[validates validates_presence_of validates_uniqueness_of validates_format_of].each do |validation_type|
          content.scan(/#{validation_type}\s+:(\w+)/).flatten.each do |validation|
            validations << { type: validation_type, field: validation }
          end
        end

        validations
      end

      def extract_template_name(file, type)
        return nil unless type == 'views'

        # Extract template name from path
        path_parts = file.split('/')
        template_name = path_parts[-2..-1].join('/').sub('.erb', '')
        template_name
      end

      def extract_variables(file, type)
        return nil unless type == 'views'

        content = File.read(file)
        variables_array = content.scan(/@(\w+)/)
        variables_array.flatten!
        variables_array.uniq!
        variables_array
      end

      def extract_helpers(file, type)
        return nil unless type == 'views'

        content = File.read(file)
        helpers_array = content.scan(/(\w+_path|\w+_url|link_to|form_with)/)
        helpers_array.flatten!
        helpers_array.uniq!
        helpers_array
      end

      def extract_file_type(file, type)
        return nil unless type == 'assets'

        File.extname(file)[1..-1] || 'unknown'
      end

      def extract_file_size(file, type)
        return nil unless type == 'assets'

        File.size(file)
      end

      def extract_dependencies(file, type)
        return nil unless type == 'assets'

        content = File.read(file)
        dependencies = []

        # Look for require, import, include statements
        content.scan(/(?:require|import|include)\s+['"]([^'"]+)['"]/).flatten.each do |dep|
          dependencies << dep
        end

        dependencies
      end

      def extract_controller_name(file, type)
        return nil unless type == 'stimulus_controllers'

        content = File.read(file)
        if content =~ /export\s+default\s+class\s+(\w+)/
          $1
        elsif content =~ /class\s+(\w+)/
          $1
        end
      end

      def extract_targets(file, type)
        return nil unless type == 'stimulus_controllers'

        content = File.read(file)
        targets = content.scan(/static\s+targets\s*=\s*\[([^\]]+)\]/).flatten
        targets_array = targets.map do |t|
          split_array = t.split(',')
          split_array.map!(&:strip)
          split_array.map! { |s| s.gsub(/['"]/, '') }
          split_array
        end
        targets_array.flatten!
        targets_array
      end

      def extract_selectors(file, type)
        return nil unless type == 'stylesheets'

        content = File.read(file)
        selectors = content.scan(/([.#]?\w+(?:\s*[.#]\w+)*)\s*\{/).flatten
        selectors.uniq
      end

      def extract_variables(file, type)
        return nil unless type == 'stylesheets'

        content = File.read(file)
        variables = content.scan(/--(\w+):/).flatten
        variables.uniq
      end

      def extract_imports(file, type)
        return nil unless type == 'stylesheets'

        content = File.read(file)
        imports = content.scan(/@import\s+['"]([^'"]+)['"]/).flatten
        imports
      end

      def extract_endpoints(file, type)
        return nil unless type == 'routes'

        content = File.read(file)
        endpoints = content.scan(/get\s+['"]([^'"]+)['"]/).flatten
        endpoints += content.scan(/post\s+['"]([^'"]+)['"]/).flatten
        endpoints += content.scan(/put\s+['"]([^'"]+)['"]/).flatten
        endpoints += content.scan(/delete\s+['"]([^'"]+)['"]/).flatten
        endpoints.uniq
      end

      def extract_resources(file, type)
        return nil unless type == 'routes'

        content = File.read(file)
        resources = content.scan(/resources\s+:(\w+)/).flatten
        resources.uniq
      end

      def extract_constraints(file, type)
        return nil unless type == 'routes'

        content = File.read(file)
        constraints = content.scan(/constraints\s*\{([^}]+)\}/).flatten
        constraints
      end

      def extract_config_patterns(file)
        return {} unless File.exist?(file)

        begin
          config = YAML.load_file(file)
          {
            file: file,
            settings: extract_settings_from_config(config),
            features: extract_features_from_config(config),
            intelligence: extract_intelligence_from_config(config),
          }
        rescue StandardError => e
          { file: file, error: e.message }
        end
      end

      def extract_settings_from_config(config)
        settings = {}

        config.each do |key, value|
          if value.is_a?(Hash)
            settings[key] = extract_settings_from_config(value)
          else
            settings[key] = value
          end
        end

        settings
      end

      def extract_features_from_config(config)
        features = []

        # Look for feature flags, enabled settings, etc.
        config.each do |key, value|
          if key.to_s.include?('enabled') || key.to_s.include?('feature')
            features << { name: key, enabled: value }
          end
        end

        features
      end

      def extract_intelligence_from_config(config)
        intelligence = {}

        # Look for intelligence-related settings
        %w[intelligence ai learning pattern recognition].each do |intel_key|
          if config[intel_key]
            intelligence[intel_key] = config[intel_key]
          end
        end

        intelligence
      end

      def extract_env_patterns
        env_patterns = {}

        # Look for Zeropoint-related ENV variables
        ENV.each do |key, value|
          if key.start_with?('ZEROPOINT_')
            env_patterns[key] = value
          end
        end

        env_patterns
      end

      def extract_content_patterns(posts)
        return [] unless posts.respond_to?(:each)

        posts.map do |post|
          {
            id: post.id,
            title: post.title,
            content_length: post.content&.length || 0,
            tags: post.tags || [],
            created_at: post.created_at&.iso8601,
          }
        end
      end

      def extract_interaction_patterns
        # This would typically connect to analytics or user tracking
        # For now, return a placeholder
        {
          total_interactions: 0,
          interaction_types: [],
          patterns: [],
        }
      end

      def add_pattern_relationships(patterns)
        # Add relationships between different pattern types
        patterns.each do |type, type_patterns|
          type_patterns.each do |pattern|
            pattern['relationships'] = find_relationships(pattern, patterns)
          end
        end

        patterns
      end

      def find_relationships(pattern, all_patterns)
        relationships = []

        # Find related patterns based on naming conventions
        pattern_name = pattern['name'].downcase

        all_patterns.each do |other_type, other_patterns|
          next if other_type == pattern['type']

          other_patterns.each do |other_pattern|
            other_name = other_pattern['name'].downcase

            # Check for naming relationships
            if pattern_name.include?(other_name) || other_name.include?(pattern_name)
              relationships << {
                type: other_type,
                name: other_pattern['name'],
                file: other_pattern['file'],
              }
            end
          end
        end

        relationships
      end

      def add_pattern_signatures(patterns)
        patterns.each do |type, type_patterns|
          type_patterns.each do |pattern|
            pattern['cosmic_signature'] = generate_cosmic_signature(pattern)
          end
        end

        patterns
      end
    end
  end
end
