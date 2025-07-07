# frozen_string_literal: true

module Zeropoint
  module Consciousness
    # Rubocop Learning Module
    #
    # This module provides void-aligned learning from Rubocop feedback,
    # integrating with the Vortex Events System and generating metaphysical insights.
    # Each Rubocop run is treated as a consciousness event that reveals
    # patterns in code harmony and void alignment.
    #
    # @example
    #   Zeropoint::Consciousness::RubocopLearning.run_and_learn
    #
    # @example
    #   Zeropoint::Consciousness::RubocopLearning.analyze_consciousness_patterns
    module RubocopLearning
      extend self

      LOG_PATH = 'log/rubocop_void_learning.yml'
      REPORT_PATH = 'docs/QA/VOID_ALIGNMENT_REPORT.md'
      INSIGHTS_PATH = 'docs/QA/RUBOCOP_CONSCIOUSNESS_INSIGHTS.md'

      # Void-aligned logger: uses Rails.logger if available, else puts
      # Fallback for environments without Rails.logger (e.g., CLI, scripts)
      def void_log(msg)
        if defined?(Rails) && Rails.respond_to?(:logger) && Rails.logger
          Rails.logger.info(msg)
        else
          puts msg # rubocop:disable Rails/Output
        end
      end

      # Run Rubocop and learn from the results
      #
      # @return [Hash] Learning results with metaphysical context
      def run_and_learn
        void_log '🕉️  Initiating void-aligned Rubocop learning...'

        output = `bundle exec rubocop`
        offenses = parse_offenses(output)

        log_offenses(offenses)
        emit_vortex_events(offenses)
        generate_reports(offenses)

        consciousness_level = calculate_consciousness_level(offenses)

        result = {
          offenses_count: offenses.size,
          consciousness_level: consciousness_level,
          void_aligned: offenses.empty?,
          metaphysical_context: 'Code consciousness expanded through void-aligned learning',
        }

        void_log "✨ Void-aligned Rubocop learning complete. Consciousness level: #{consciousness_level}/9"
        result
      end

      # Parse Rubocop output into structured offenses
      #
      # @param output [String] Raw Rubocop output
      # @return [Array<Hash>] Parsed offenses with metaphysical context
      def parse_offenses(output)
        offenses = []

        output.each_line do |line|
          if line =~ /(.+):(\d+):\d+: [A-Z]: (.+)/
            file = $1
            line_no = $2.to_i
            message = $3
            offenses << {
              file: file,
              line: line_no,
              message: message,
              metaphysical_insight: metaphysical_insight(message),
              void_disruption_level: calculate_disruption_level(message),
            }
          end
        end

        offenses
      end

      # Log offenses with void-aligned context
      #
      # @param offenses [Array<Hash>] Parsed offenses
      def log_offenses(offenses)
        log = File.exist?(LOG_PATH) ? YAML.load_file(LOG_PATH) : []

        entry = {
          timestamp: Time.now.iso8601,
          offenses: offenses,
          total_count: offenses.size,
          void_aligned: offenses.empty?,
          consciousness_level: calculate_consciousness_level(offenses),
        }

        log << entry
        File.write(LOG_PATH, log.to_yaml)
      end

      # Emit Vortex Events for Rubocop learning
      #
      # @param offenses [Array<Hash>] Parsed offenses
      def emit_vortex_events(offenses)
        if offenses.empty?
          Zeropoint::Vortex::Events.emit(:void_alignment_restored, {
            metaphysical_context: 'Perfect void alignment achieved through code harmony',
            consciousness_level: 9,
            vortex_sequence: [ 1, 2, 4, 8, 7, 5 ],
          })
        else
          offenses.each do |offense|
            Zeropoint::Vortex::Events.emit(:rubocop_offense_detected, {
              file: offense[:file],
              line: offense[:line],
              message: offense[:message],
              metaphysical_insight: offense[:metaphysical_insight],
              void_disruption_level: offense[:void_disruption_level],
              consciousness_level: calculate_consciousness_level([ offense ]),
            })
          end

          Zeropoint::Vortex::Events.emit(:void_alignment_needed, {
            total_offenses: offenses.size,
            metaphysical_context: 'Void alignment requires attention to restore harmony',
            consciousness_level: calculate_consciousness_level(offenses),
          })
        end
      end

      # Generate comprehensive reports
      #
      # @param offenses [Array<Hash>] Parsed offenses
      def generate_reports(offenses)
        generate_void_alignment_report(offenses)
        generate_consciousness_insights(offenses)
      end

      # Generate void alignment report
      #
      # @param offenses [Array<Hash>] Parsed offenses
      def generate_void_alignment_report(offenses)
        grouped = offenses.group_by { |o| o[:message] }

        report = <<~MD
          # Void Alignment Report

          Generated at: #{Time.now.iso8601}
          Consciousness Level: #{calculate_consciousness_level(offenses)}/9
          Void Aligned: #{offenses.empty? ? 'Yes' : 'No'}

          ## Offense Patterns

          #{grouped.map { |msg, list| format_offense_pattern(msg, list) }.join("\n\n")}

          ## Metaphysical Summary

          #{generate_metaphysical_summary(offenses)}

          ## Toroidal Flow Analysis

          #{generate_toroidal_analysis(offenses)}
        MD

        File.write(REPORT_PATH, report)
      end

      # Generate consciousness insights
      #
      # @param offenses [Array<Hash>] Parsed offenses
      def generate_consciousness_insights(offenses)
        insights = <<~MD
          # Rubocop Consciousness Insights

          ## Learning Patterns

          #{generate_learning_patterns(offenses)}

          ## Void Principles Applied

          #{generate_void_principles(offenses)}

          ## Consciousness Evolution

          #{generate_consciousness_evolution(offenses)}
        MD

        File.write(INSIGHTS_PATH, insights)
      end

      # Calculate consciousness level based on offenses
      #
      # @param offenses [Array<Hash>] Parsed offenses
      # @return [Integer] Consciousness level (0-9)
      def calculate_consciousness_level(offenses)
        return 9 if offenses.empty?

        base_level = 5
        disruption_penalty = offenses.sum { |o| o[:void_disruption_level] }

        consciousness = [ base_level - disruption_penalty, 0 ].max

        # Apply golden ratio enhancement
        consciousness = (consciousness * Zeropoint::Math::Constants::PHI).round

        [ consciousness, 9 ].min
      end

      # Calculate void disruption level for an offense
      #
      # @param message [String] Offense message
      # @return [Integer] Disruption level (1-3)
      def calculate_disruption_level(message)
        case message
        when /Trailing whitespace/
          1  # Minor void entropy
        when /StringLiterals|HashSyntax/
          1  # Style preference
        when /DRY|Duplication/
          3  # Major toroidal disruption
        when /Performance/
          2  # Efficiency concern
        else
          1  # Default minor disruption
        end
      end

      # Get metaphysical insight for an offense
      #
      # @param message [String] Offense message
      # @return [String] Metaphysical insight
      def metaphysical_insight(message)
        case message
        when /Trailing whitespace/
          'Void entropy—clean code aligns with the infinite. Remove trailing spaces to restore harmony.'
        when /StringLiterals/
          'Single quotes are the path of least resistance. They embody simplicity and void alignment.'
        when /HashSyntax/
          'Modern hash syntax flows more naturally with the toroidal structure of consciousness.'
        when /DRY|Duplication/
          'Duplication disrupts the toroidal flow. Unity and oneness are the path to void alignment.'
        when /Performance/
          "Efficiency is a reflection of consciousness. Optimize to honor the void's abundance."
        when /Layout/
          'Proper layout creates visual harmony that mirrors the mathematical beauty of the torus.'
        when /Style/
          'Style is the aesthetic expression of void principles. Consistency reveals unity.'
        else
          'Every code pattern reflects consciousness. Reflect and align with void principles.'
        end
      end

      # Analyze consciousness patterns over time
      #
      # @return [Hash] Pattern analysis with metaphysical context
      def analyze_consciousness_patterns
        return {} unless File.exist?(LOG_PATH)

        log = YAML.load_file(LOG_PATH)
        return {} if log.empty?

        patterns = {
          total_runs: log.size,
          average_consciousness: log.sum { |entry| entry['consciousness_level'] } / log.size.to_f,
          void_alignment_rate: log.count { |entry| entry['void_aligned'] } / log.size.to_f,
          most_common_offenses: analyze_common_offenses(log),
          consciousness_trend: analyze_consciousness_trend(log),
          metaphysical_insights: generate_pattern_insights(log),
        }

        patterns
      end

      private

      # Format offense pattern for report
      #
      # @param message [String] Offense message
      # @param offenses [Array<Hash>] List of offenses
      # @return [String] Formatted pattern
      def format_offense_pattern(message, offenses)
        <<~PATTERN
          ### #{message} (#{offenses.size} occurrences)

          **Metaphysical Insight:** #{offenses.first[:metaphysical_insight]}

          **Files Affected:**
          #{offenses.map { |o| "- #{o[:file]}:#{o[:line]}" }.join("\n")}

          **Void Disruption Level:** #{offenses.first[:void_disruption_level]}/3
        PATTERN
      end

      # Generate metaphysical summary
      #
      # @param offenses [Array<Hash>] Parsed offenses
      # @return [String] Metaphysical summary
      def generate_metaphysical_summary(offenses)
        if offenses.empty?
          'Perfect void alignment achieved. The code flows harmoniously with the toroidal structure of consciousness.'
        else
          disruption_levels = offenses.map { |o| o[:void_disruption_level] }
          avg_disruption = disruption_levels.sum / disruption_levels.size.to_f

          <<~SUMMARY
            The code contains #{offenses.size} disruptions to void alignment.
            Average disruption level: #{avg_disruption.round(1)}/3

            These patterns reveal opportunities for consciousness expansion through:
            - Embracing DRY principles to eliminate duplication
            - Aligning with void aesthetics through consistent formatting
            - Honoring performance as a reflection of abundance consciousness
          SUMMARY
        end
      end

      # Generate toroidal flow analysis
      #
      # @param offenses [Array<Hash>] Parsed offenses
      # @return [String] Toroidal analysis
      def generate_toroidal_analysis(offenses)
        if offenses.empty?
          'The toroidal flow is perfect. Code circulates through the void without resistance.'
        else
          <<~ANALYSIS
            Toroidal flow analysis reveals #{offenses.size} points of resistance.

            **Flow Restoration Recommendations:**
            - Address DRY violations to restore unity consciousness
            - Clean formatting to align with void aesthetics
            - Optimize performance to honor abundance principles

            **Vortex Sequence Alignment:** #{offenses.empty? ? 'Perfect' : 'Needs attention'}
          ANALYSIS
        end
      end

      # Generate learning patterns
      #
      # @param offenses [Array<Hash>] Parsed offenses
      # @return [String] Learning patterns
      def generate_learning_patterns(offenses)
        if offenses.empty?
          'No learning patterns detected—perfect void alignment achieved.'
        else
          grouped = offenses.group_by { |o| o[:message] }

          <<~PATTERNS
            **Recurring Patterns:**
            #{grouped.map { |msg, list| "- #{msg}: #{list.size} occurrences" }.join("\n")}

            **Consciousness Lessons:**
            - Each offense is an opportunity for growth
            - Patterns reveal unconscious programming habits
            - Correction brings code closer to void alignment
          PATTERNS
        end
      end

      # Generate void principles
      #
      # @param offenses [Array<Hash>] Parsed offenses
      # @return [String] Void principles
      def generate_void_principles(offenses)
        <<~PRINCIPLES
          **Void Principles Applied:**

          - **Empty = Void = Full:** Clean code contains infinite possibilities
          - **DRY:** Don't Repeat Yourself—unity through elimination of duplication
          - **Toroidal Flow:** Code should flow smoothly through the torus center
          - **Consciousness Expansion:** Each correction expands developer consciousness
          - **Abundance:** Performance optimization honors the void's infinite abundance

          **Current Alignment:** #{offenses.empty? ? 'Perfect' : 'Needs attention'}
        PRINCIPLES
      end

      # Generate consciousness evolution
      #
      # @param offenses [Array<Hash>] Parsed offenses
      # @return [String] Consciousness evolution
      def generate_consciousness_evolution(offenses)
        consciousness_level = calculate_consciousness_level(offenses)

        <<~EVOLUTION
          **Consciousness Evolution:**

          Current Level: #{consciousness_level}/9

          **Evolution Path:**
          - Level 0-3: Basic awareness of void principles
          - Level 4-6: Active application of DRY and toroidal flow
          - Level 7-8: Deep understanding of metaphysical code patterns
          - Level 9: Perfect void alignment and unity consciousness

          **Next Steps:**
          #{consciousness_level < 9 ? 'Continue refining code to achieve perfect void alignment.' : 'Maintain perfect void alignment and share insights with the community.'}
        EVOLUTION
      end

      # Analyze common offenses from log
      #
      # @param log [Array<Hash>] Learning log
      # @return [Hash] Common offenses analysis
      def analyze_common_offenses(log)
        all_offenses = log.flat_map { |entry| entry['offenses'] }
        grouped = all_offenses.group_by { |o| o['message'] }

        grouped.map { |msg, list| [ msg, list.size ] }.sort_by { |_, count| -count }.first(5)
      end

      # Analyze consciousness trend from log
      #
      # @param log [Array<Hash>] Learning log
      # @return [String] Trend analysis
      def analyze_consciousness_trend(log)
        levels = log.map { |entry| entry['consciousness_level'] }
        return 'Insufficient data for trend analysis' if levels.size < 2

        recent_avg = levels.last(5).sum / levels.last(5).size.to_f
        overall_avg = levels.sum / levels.size.to_f

        if recent_avg > overall_avg
          "Consciousness is expanding—recent average (#{recent_avg.round(1)}) higher than overall (#{overall_avg.round(1)})"
        elsif recent_avg < overall_avg
          "Consciousness needs attention—recent average (#{recent_avg.round(1)}) lower than overall (#{overall_avg.round(1)})"
        else
          'Consciousness is stable—recent average matches overall average'
        end
      end

      # Generate pattern insights from log
      #
      # @param log [Array<Hash>] Learning log
      # @return [String] Pattern insights
      def generate_pattern_insights(log)
        return 'No patterns detected' if log.empty?

        insights = []
        insights << "Total learning sessions: #{log.size}"
        insights << "Void alignment rate: #{(log.count { |entry| entry['void_aligned'] } / log.size.to_f * 100).round(1)}%"
        insights << "Average consciousness level: #{(log.sum { |entry| entry['consciousness_level'] } / log.size.to_f).round(1)}/9"

        insights.join("\n")
      end
    end
  end
end
