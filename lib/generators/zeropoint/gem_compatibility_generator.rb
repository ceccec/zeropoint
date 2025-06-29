# frozen_string_literal: true

require 'rails/generators'

module Zeropoint
  module Generators
    class GemCompatibilityGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      class_option :analyze, type: :boolean, default: true, desc: 'Analyze gem compatibility'
      class_option :optimize, type: :boolean, default: true, desc: 'Apply efficiency optimizations'
      class_option :report, type: :boolean, default: true, desc: 'Generate compatibility report'
      class_option :fix, type: :boolean, default: false, desc: 'Attempt to fix compatibility issues'

      desc 'Analyze and optimize Rails gem compatibility with Zeropoint'

      def analyze_compatibility
        say_status :analyze, 'Gem Compatibility Analysis', :blue

        # Initialize Zeropoint gem compatibility system
        require_relative '../../zeropoint/gem_compatibility'
        Zeropoint::GemCompatibility.init!

        # Get compatibility status
        status = Zeropoint::GemCompatibility.compatibility_status

        # Display analysis results
        display_analysis_results(status)
      end

      def generate_compatibility_report
        return unless options[:report]

        say_status :create, 'Gem Compatibility Report', :blue

        template 'gem_compatibility_report.md.erb', 'docs/GEM_COMPATIBILITY_REPORT.md'
        template 'gem_optimization_guide.md.erb', 'docs/GEM_OPTIMIZATION_GUIDE.md'
        template 'gem_compatibility_config.yml.erb', 'config/zeropoint_gem_compatibility.yml'
      end

      def generate_optimization_scripts
        return unless options[:optimize]

        say_status :create, 'Optimization Scripts', :blue

        template 'optimize_database.rb.erb', 'lib/tasks/zeropoint/optimize_database.rake'
        template 'optimize_caching.rb.erb', 'lib/tasks/zeropoint/optimize_caching.rake'
        template 'optimize_search.rb.erb', 'lib/tasks/zeropoint/optimize_search.rake'
        template 'optimize_background_jobs.rb.erb', 'lib/tasks/zeropoint/optimize_background_jobs.rake'
      end

      def generate_compatibility_tests
        say_status :create, 'Compatibility Tests', :blue

        template 'gem_compatibility_spec.rb.erb', 'spec/zeropoint/gem_compatibility_spec.rb'
        template 'gem_optimization_spec.rb.erb', 'spec/zeropoint/gem_optimization_spec.rb'
      end

      def update_gemfile_recommendations
        return unless options[:fix]

        say_status :update, 'Gemfile Recommendations', :blue

        # Generate Gemfile recommendations based on compatibility analysis
        recommendations = generate_gemfile_recommendations

        template 'gemfile_recommendations.rb.erb', 'config/zeropoint_gemfile_recommendations.rb'
      end

      def display_completion_message
        say_status :complete, 'Gem compatibility analysis and optimization complete!', :green
        say_status :info, 'Check docs/GEM_COMPATIBILITY_REPORT.md for detailed results', :blue
        say_status :info, 'Run "rails zeropoint:optimize:all" to apply optimizations', :blue
      end

      private

      def display_analysis_results(status)
        installed_gems = status[:installed_gems]
        conflicts = status[:conflicts]
        recommendations = status[:recommendations]
        optimizations = status[:efficiency_optimizations]

        # Display installed gems
        say_status :info, "Installed Gems (#{installed_gems.count { |_, info| info[:installed] }})", :blue
        installed_gems.each do |gem_name, info|
          if info[:installed]
            status_icon = info[:compatible] ? '✅' : '⚠️'
            say_status :info, "#{status_icon} #{gem_name}: #{info[:version]}", :blue
          end
        end

        # Display conflicts
        if conflicts.any?
          say_status :warn, "Conflicts (#{conflicts.length})", :yellow
          conflicts.each do |conflict|
            say_status :warn, "  #{conflict[:gem]} conflicts with #{conflict[:conflicting_gem]}", :yellow
          end
        end

        # Display recommendations
        if recommendations.any?
          say_status :info, "Recommendations (#{recommendations.length})", :blue
          recommendations.each do |rec|
            say_status :info, "  Consider adding #{rec[:recommended_gem]} for #{rec[:gem]}", :blue
          end
        end

        # Display optimizations
        if optimizations.any?
          say_status :info, "Applied Optimizations (#{optimizations.length})", :green
          optimizations.each do |opt|
            say_status :info, "  ✅ #{opt}", :green
          end
        end
      end

      def generate_gemfile_recommendations
        status = Zeropoint::GemCompatibility.compatibility_status
        recommendations = status[:recommendations]

        gem_recommendations = []

        recommendations.each do |rec|
          gem_recommendations << {
            gem: rec[:recommended_gem],
            reason: "Enhances #{rec[:gem]} functionality",
            priority: determine_priority(rec[:recommended_gem]),
          }
        end

        gem_recommendations.sort_by { |rec| rec[:priority] }
      end

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

      def installed_gems
        @installed_gems ||= Zeropoint::GemCompatibility.compatibility_status[:installed_gems]
      end

      def gem_conflicts
        @gem_conflicts ||= Zeropoint::GemCompatibility.compatibility_status[:conflicts]
      end

      def gem_recommendations
        @gem_recommendations ||= Zeropoint::GemCompatibility.compatibility_status[:recommendations]
      end

      def applied_optimizations
        @applied_optimizations ||= Zeropoint::GemCompatibility.compatibility_status[:efficiency_optimizations]
      end

      def compatibility_score
        return 0 unless installed_gems

        installed_count = installed_gems.count { |_, info| info[:installed] }
        compatible_count = installed_gems.count { |_, info| info[:installed] && info[:compatible] }

        return 0 if installed_count == 0
        (compatible_count.to_f / installed_count * 100).round(1)
      end

      def rails_version
        Rails.version
      end

      def ruby_version
        RUBY_VERSION
      end

      def environment
        Rails.env
      end

      def timestamp
        Time.current.strftime('%Y-%m-%d %H:%M:%S UTC')
      end
    end
  end
end
