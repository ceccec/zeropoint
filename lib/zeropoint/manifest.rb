# frozen_string_literal: true

require 'yaml'
require 'json'

module Zeropoint
  # Manifestation Engine: Generates all system manifestations from the canonical seed
  #
  # This is NOT the manifest itself, but the engine that reads the canonical
  # zeropoint.md file and generates all concrete manifestations (assets, routes,
  # PWA config, etc.) from that single source of truth.
  module Manifest
    CANONICAL_PATH = File.expand_path('../../../zeropoint.md', __FILE__)

    class << self
      # Load the canonical manifest (the seed)
      def canonical_manifest
        @canonical_manifest ||= load_canonical_manifest
      end

      # Generate manifestation for a specific type
      def manifestation(type)
        case type.to_sym
        when :assets
          generate_asset_manifestation
        when :routes
          generate_route_manifestation
        when :pwa
          generate_pwa_manifestation
        when :controllers
          generate_controller_manifestation
        when :service_worker
          generate_service_worker_manifestation
        when :intelligence
          generate_intelligence_manifestation
        when :version
          generate_version_manifestation
        when :all
          generate_all_manifestations
        else
          raise ArgumentError, "Unknown manifestation type: #{type}"
        end
      end

      # Generate asset manifestation (for precompilation, importmap, etc.)
      def generate_asset_manifestation
        assets = canonical_manifest['assets'] || {}
        {
          javascripts: expand_patterns(assets['javascripts'] || []),
          stylesheets: expand_patterns(assets['stylesheets'] || []),
          images: expand_patterns(assets['images'] || []),
          all: expand_patterns(assets.values.flatten),
        }
      end

      # Generate route manifestation
      def generate_route_manifestation
        canonical_manifest['routes'] || []
      end

      # Generate PWA manifestation
      def generate_pwa_manifestation
        canonical_manifest['pwa'] || {}
      end

      # Generate controller manifestation
      def generate_controller_manifestation
        canonical_manifest['controllers'] || {}
      end

      # Generate service worker manifestation
      def generate_service_worker_manifestation
        canonical_manifest['service_worker'] || {}
      end

      # Generate intelligence manifestation
      def generate_intelligence_manifestation
        canonical_manifest['intelligence'] || {}
      end

      # Generate version manifestation
      def generate_version_manifestation
        canonical_manifest['version'] || {}
      end

      # Generate all manifestations
      def generate_all_manifestations
        {
          assets: generate_asset_manifestation,
          routes: generate_route_manifestation,
          pwa: generate_pwa_manifestation,
          controllers: generate_controller_manifestation,
          service_worker: generate_service_worker_manifestation,
          intelligence: generate_intelligence_manifestation,
          version: generate_version_manifestation,
        }
      end

      # Export manifestation for specific targets (backward compatibility)
      def export(target)
        case target.to_sym
        when :importmap
          generate_asset_manifestation[:javascripts].map { |f| File.basename(f, '.js') }
        when :service_worker_precache
          assets = generate_asset_manifestation[:all]
          routes = generate_route_manifestation
          assets + routes
        when :pwa_manifest
          generate_pwa_manifestation
        when :json
          generate_all_manifestations.to_json
        else
          raise ArgumentError, "Unknown export target: #{target}"
        end
      end

      # Backward compatibility aliases
      alias_method :assets, :generate_asset_manifestation
      alias_method :routes, :generate_route_manifestation
      alias_method :pwa_manifest, :generate_pwa_manifestation

      private

      # Load the canonical manifest from zeropoint.md
      def load_canonical_manifest
        return {} unless File.exist?(CANONICAL_PATH)

        content = File.read(CANONICAL_PATH)
        extract_yaml_blocks(content)
      end

      # Extract YAML blocks from markdown content
      def extract_yaml_blocks(content)
        manifest = {}

        # Extract YAML blocks by section
        sections = {
          assets: extract_yaml_block(content, 'Assets'),
          routes: extract_yaml_block(content, 'Routes'),
          pwa: extract_yaml_block(content, 'PWA Configuration'),
          controllers: extract_yaml_block(content, 'Controllers'),
          service_worker: extract_yaml_block(content, 'Service Worker'),
          intelligence: extract_yaml_block(content, 'Intelligence Configuration'),
          version: extract_yaml_block(content, 'Version Information'),
        }

        sections.each do |key, yaml_content|
          next if yaml_content.nil?
          begin
            manifest[key] = YAML.safe_load(yaml_content)
          rescue StandardError => e
            Rails.logger.warn "Failed to parse YAML for #{key}: #{e.message}"
            manifest[key] = {}
          end
        end

        manifest
      end

      # Extract YAML block for a specific section
      def extract_yaml_block(content, section_name)
        # Find the section
        section_pattern = /^## #{Regexp.escape(section_name)}\s*$/i
        section_match = content.match(section_pattern)
        return nil unless section_match

        # Extract content from section start to next section or end
        section_start = section_match.end(0)
        next_section = content[section_start..-1].match(/^## /)

        if next_section
          section_content = content[section_start, next_section.begin(0)]
        else
          section_content = content[section_start..-1]
        end

        # Extract YAML block
        yaml_match = section_content.match(/```yaml\s*\n(.*?)\n```/m)
        yaml_match ? yaml_match[1] : nil
      end

      # Expand glob patterns
      def expand_patterns(patterns)
        patterns_array = Array(patterns).flat_map { |pattern| Dir.glob(pattern) }
        patterns_array.uniq!
        patterns_array.sort!
        patterns_array
      end
    end
  end
end
