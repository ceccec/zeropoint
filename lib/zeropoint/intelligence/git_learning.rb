# COMPONENT BEST PRACTICE: Use single gateway API for all Git learning operations for unified access and caching.

# Git Learning Intelligence

# frozen_string_literal: true

# Zeropoint::Intelligence::GitLearning
#
# Intelligence system that learns from Git history using the single
# Zeropoint gateway API for caching, speed, and unified access patterns.
#
# @example Analyze Git learning patterns
#   Zeropoint::Intelligence::GitLearning.analyze_commit_patterns
#
module Zeropoint
  module Intelligence
    class GitLearning
      include Zeropoint::VortexAware

      # Configuration for Git learning via Zeropoint gateway
      CONFIG = {
        analysis_depth: 100,           # Number of commits to analyze
        pattern_threshold: 0.1,        # Minimum frequency for pattern detection
        learning_file: 'git_learning_data.json',
        commit_patterns_file: 'commit_patterns.yml',
        development_cycles_file: 'development_cycles.yml',
        cache_duration: 3600,          # Cache duration in seconds
        batch_size: 50,                # Batch size for API requests
        zeropoint_path: '/zeropoint',   # Single gateway API path
      }.freeze

      # Analyze Git commit patterns and learn from them
      # @return [Hash] Analysis results
      def self.analyze_commit_patterns
        new.analyze_commit_patterns
      end

      # Learn from recent development cycles
      # @return [Hash] Learning results
      def self.learn_from_development_cycles
        new.learn_from_development_cycles
      end

      # Predict optimal RuboCop configuration based on Git history
      # @return [Hash] Configuration recommendations
      def self.predict_optimal_config
        new.predict_optimal_config
      end

      # Initialize the Git learning system
      def initialize
        @git_data = {}
        @patterns = {}
        @learning_data = load_learning_data
      end

      # Analyze commit patterns from Git history via gateway API
      # @return [Hash] Analysis results
      def analyze_commit_patterns
        # COMPONENT BEST PRACTICE: Use /zeropoint gateway for caching and unified access.
        log_message('Starting Git commit pattern analysis via Zeropoint gateway...')

        # Get recent commits via gateway API with caching
        commits = get_recent_commits_via_gateway
        log_message("Analyzing #{commits.length} commits")

        # Analyze patterns
        patterns = {
          commit_frequency: analyze_commit_frequency(commits),
          file_change_patterns: analyze_file_changes_via_gateway(commits),
          message_patterns: analyze_commit_messages(commits),
          time_patterns: analyze_time_patterns(commits),
          rubocop_patterns: analyze_rubocop_patterns(commits),
        }

        # Store patterns with caching
        @patterns = patterns
        cache_patterns(patterns)

        log_message('Pattern analysis complete')
        patterns
      end

      # Learn from development cycles via gateway API
      # @return [Hash] Learning results
      def learn_from_development_cycles
        log_message('Learning from development cycles via Zeropoint gateway...')

        # Analyze RuboCop development cycles via gateway
        rubocop_cycles = analyze_rubocop_development_cycles_via_gateway

        # Analyze general development patterns via gateway
        dev_patterns = analyze_development_patterns_via_gateway

        # Combine learning
        learning_results = {
          rubocop_cycles: rubocop_cycles,
          development_patterns: dev_patterns,
          recommendations: generate_recommendations(rubocop_cycles, dev_patterns),
        }

        # Update learning data with caching
        cache_learning_data(learning_results)

        log_message('Development cycle learning complete')
        learning_results
      end

      # Predict optimal RuboCop configuration
      # @return [Hash] Configuration recommendations
      def predict_optimal_config
        log_message('Predicting optimal RuboCop configuration via Zeropoint gateway...')

        # Get cached patterns or fetch via gateway
        commit_patterns = get_cached_patterns || analyze_commit_patterns
        learning_results = get_cached_cycles || learn_from_development_cycles

        # Extract the patterns we need for predictions
        patterns = {
          commit_frequency: commit_patterns[:commit_frequency] || {},
          message_patterns: commit_patterns[:message_patterns] || {},
          rubocop_patterns: commit_patterns[:rubocop_patterns] || {},
          development_patterns: learning_results[:development_patterns] || {},
        }

        # Handle both cached cycles (raw) and learning results (with :rubocop_cycles key)
        cycles = if learning_results.key?(:rubocop_cycles)
                   learning_results[:rubocop_cycles] || {}
        else
                   learning_results || {}
        end

        # Generate recommendations
        recommendations = {
          max_iterations: predict_max_iterations(patterns, cycles),
          auto_commit_frequency: predict_commit_frequency(patterns),
          documentation_update_strategy: predict_doc_strategy(patterns),
          error_threshold: predict_error_threshold(patterns, cycles),
          learning_adaptation: predict_learning_adaptation(patterns),
        }

        # Cache recommendations
        cache_recommendations(recommendations)

        log_message('Configuration prediction complete')
        recommendations
      end

      private

      # Get recent commits via Zeropoint gateway API with caching
      # @return [Array] Array of commit hashes
      def get_recent_commits_via_gateway
        cache_key = "vortex:git_learning:commits:#{CONFIG[:analysis_depth]}"
        cached_commits = Zeropoint::Vortex::CacheMatrix.instance.fetch(cache_key)
        return cached_commits if cached_commits

        # Fetch via gateway API
        response = post_to_gateway('git.commits', {
          action: 'fetch_commits',
          limit: CONFIG[:analysis_depth],
          format: 'detailed',
        })

        if response[:success]
          commits = response[:data]['commits'] || []
          Zeropoint::Vortex::CacheMatrix.instance.store(cache_key, commits)
          commits
        else
          log_message("Gateway Error: #{response[:error]}")
          []
        end
      end

      # Analyze file changes via gateway API
      # @param commits [Array] Array of commit hashes
      # @return [Hash] File change analysis
      def analyze_file_changes_via_gateway(commits)
        file_changes = {}

        # Batch process commits for efficiency
        commits.each_slice(CONFIG[:batch_size]) do |batch|
          commit_hashes = batch.map { |c| c['hash'] }

          # Get file changes for batch via gateway
          response = post_to_gateway('git.file_changes', {
            action: 'fetch_file_changes',
            commits: commit_hashes,
          })

          if response[:success]
            changes_data = response[:data]['changes'] || {}

            changes_data.each do |commit_hash, files|
              files.each do |file|
                file_changes[file] ||= { changes: 0, last_modified: nil }
                file_changes[file][:changes] += 1
                file_changes[file][:last_modified] = Time.zone.parse(commits.find { |c| c['hash'] == commit_hash }['date'])
              end
            end
          end
        end

        # Analyze patterns
        {
          most_changed_files: file_changes.sort_by { |_, data| -data[:changes] }.first(10),
          file_change_frequency: file_changes.values.sum { |data| data[:changes] }.to_f / file_changes.length,
          rubocop_related_files: file_changes.select { |file, _| file.include?('rubocop') || file.include?('.rb') },
        }
      end

      # Analyze RuboCop development cycles via gateway API
      # @return [Hash] Development cycle analysis
      def analyze_rubocop_development_cycles_via_gateway
        cache_key = 'vortex:git_learning:cycles'

        # Try to get from cache first
        cached_cycles = Zeropoint::Vortex::CacheMatrix.instance.fetch(cache_key)
        return cached_cycles if cached_cycles

        # Get RuboCop-related commits via gateway
        response = post_to_gateway('git.commits', {
          action: 'fetch_rubocop_commits',
          search: 'RuboCop development loop',
          limit: 200,
        })

        if response[:success]
          commits = response[:data]['commits'] || []
          cycles = parse_rubocop_cycles(commits)

          # Cache the results
          Zeropoint::Vortex::CacheMatrix.instance.store(cache_key, cycles)

          cycles
        else
          log_message("Gateway Error: #{response[:error]}")
          {}
        end
      end

      # Analyze development patterns via gateway API
      # @return [Hash] Development pattern analysis
      def analyze_development_patterns_via_gateway
        cache_key = 'vortex:git_learning:dev_patterns'

        # Try to get from cache first
        cached_patterns = Zeropoint::Vortex::CacheMatrix.instance.fetch(cache_key)
        return cached_patterns if cached_patterns

        # Get development metrics via gateway
        response = post_to_gateway('git.metrics', {
          action: 'fetch_development_metrics',
          period: '7d',
          include: [ 'velocity', 'quality', 'collaboration', 'features' ],
        })

        if response[:success]
          metrics = response[:data]['metrics'] || {}

          patterns = {
            development_velocity: metrics['velocity'] || 0,
            code_quality_trends: metrics['quality'] || {},
            collaboration_patterns: metrics['collaboration'] || {},
            feature_development_patterns: metrics['features'] || {},
          }

          # Cache the results
          Zeropoint::Vortex::CacheMatrix.instance.store(cache_key, patterns)

          patterns
        else
          log_message("Gateway Error: #{response[:error]}")
          {}
        end
      end

      # Post request to Zeropoint gateway
      # @param service [String] Service name
      # @param data [Hash] Request data
      # @return [Hash] Response data
      def post_to_gateway(service, data)
        begin
          # Use the DRY helper for unified gateway request
          vortex_request = build_vortex_request(service, data, channel: 'git_learning')
          response = Net::HTTP.post_form(
            URI.parse(Rails.application.routes.url_helpers.zeropoint_path.to_s),
            vortex_request
          )
          JSON.parse(response.body, symbolize_names: true)
        rescue StandardError => e
          { success: false, error: e.message }
        end
      end

      # Calculate consciousness level for vortex requests
      # @return [Float] Consciousness level
      def calculate_consciousness_level
        # Base consciousness level for GitLearning operations
        base_level = 0.7

        # Adjust based on analysis complexity
        complexity_bonus = 0.2 if CONFIG[:analysis_depth] > 50
        complexity_bonus = 0.1 if CONFIG[:analysis_depth] > 25

        [ base_level + (complexity_bonus || 0), 1.0 ].min
      end

      # Parse RuboCop cycles from commits
      # @param commits [Array] Array of commits
      # @return [Hash] Cycle analysis
      def parse_rubocop_cycles(commits)
        cycles = []
        current_cycle = nil

        commits.each do |commit|
          if commit['message'].include?('RuboCop development loop iteration')
            # Start new cycle
            if current_cycle
              # Defensive: ensure cycles is an array
              cycles ||= []
              cycles << current_cycle
            end

            iteration_match = commit['message'].match(/iteration (\d+): (\d+) offenses, (\d+) corrected/)
            if iteration_match
              current_cycle = {
                iteration: iteration_match[1].to_i,
                offenses: iteration_match[2].to_i,
                corrected: iteration_match[3].to_i,
                timestamp: Time.zone.parse(commit['date']),
                hash: commit['hash'],
              }
            end
          elsif current_cycle && commit['message'].include?('Development Loop Complete')
            # End cycle
            current_cycle[:end_timestamp] = Time.zone.parse(commit['date'])
            current_cycle[:duration] = current_cycle[:end_timestamp] - current_cycle[:timestamp]
            # Defensive: ensure cycles is an array
            cycles ||= []
            cycles << current_cycle
            current_cycle = nil
          end
        end

        # Analyze cycles
        {
          total_cycles: cycles.length,
          average_cycle_duration: cycles.filter_map { |c| c[:duration] }.sum.to_f / cycles.length,
          average_iterations_per_cycle: cycles.map { |c| c[:iteration] }.max || 0,
          offense_reduction_patterns: analyze_offense_reduction_patterns(cycles),
          cycle_efficiency: calculate_cycle_efficiency(cycles),
        }
      end

      # Cache patterns
      # @param patterns [Hash] Pattern data
      def cache_patterns(patterns)
        Zeropoint::Vortex::CacheMatrix.instance.store('vortex:git_learning:patterns', patterns)
        File.write(CONFIG[:commit_patterns_file], patterns.to_yaml)
      end

      # Cache learning data
      # @param learning_data [Hash] Learning data
      def cache_learning_data(learning_data)
        Zeropoint::Vortex::CacheMatrix.instance.store('vortex:git_learning:learning', learning_data)
        update_learning_data(learning_data)
      end

      # Cache recommendations
      # @param recommendations [Hash] Recommendations
      def cache_recommendations(recommendations)
        Zeropoint::Vortex::CacheMatrix.instance.store('vortex:git_learning:recommendations', recommendations)
      end

      # Get cached patterns
      # @return [Hash, nil] Cached patterns or nil
      def get_cached_patterns
        Zeropoint::Vortex::CacheMatrix.instance.fetch('vortex:git_learning:patterns')
      end

      # Get cached cycles
      # @return [Hash, nil] Cached cycles or nil
      def get_cached_cycles
        Zeropoint::Vortex::CacheMatrix.instance.fetch('vortex:git_learning:cycles')
      end

      # Analyze commit frequency patterns
      # @param commits [Array] Array of commit hashes
      # @return [Hash] Frequency analysis
      def analyze_commit_frequency(commits)
        return {} if commits.empty?

        # Group by day
        daily_commits = commits.group_by { |c| Time.zone.parse(c['date']).to_date }
        intervals = []
        previous_time = nil
        commits.each do |commit|
          time = Time.zone.parse(commit['date'])
          if previous_time
            # Defensive: ensure intervals is an array
            intervals ||= []
            interval = time - previous_time
            intervals << interval / 3600  # Convert to hours
          end
          previous_time = time
        end

        # Calculate patterns
        {
          average_daily_commits: daily_commits.values.sum(&:length).to_f / daily_commits.length,
          peak_commit_days: daily_commits.select { |_, cs| cs.length > 3 }.keys,
          quiet_days: daily_commits.select { |_, cs| cs.length == 0 }.keys,
          commit_velocity: calculate_commit_velocity(commits),
        }
      end

      # Analyze commit message patterns
      # @param commits [Array] Array of commit hashes
      # @return [Hash] Message pattern analysis
      def analyze_commit_messages(commits)
        messages = commits.map { |c| c['message'] }

        # Common patterns
        patterns = {
          rubocop_mentions: messages.count { |m| m.downcase.include?('rubocop') },
          fix_mentions: messages.count { |m| m.downcase.include?('fix') },
          refactor_mentions: messages.count { |m| m.downcase.include?('refactor') },
          test_mentions: messages.count { |m| m.downcase.include?('test') },
          doc_mentions: messages.count { |m| m.downcase.include?('doc') },
        }

        # Message length analysis
        lengths = messages.map(&:length)
        patterns.merge({
          average_message_length: lengths.sum.to_f / lengths.length,
          short_messages: messages.count { |m| m.length < 20 },
          long_messages: messages.count { |m| m.length > 100 },
        })
      end

      # Analyze time patterns
      # @param commits [Array] Array of commit hashes
      # @return [Hash] Time pattern analysis
      def analyze_time_patterns(commits)
        return {} if commits.empty?

        hours = commits.map { |c| Time.zone.parse(c['date']).hour }
        days = commits.map { |c| Time.zone.parse(c['date']).wday }

        {
          peak_hours: hours.group_by(&:itself).max_by { |_, h| h.length }&.first,
          peak_days: days.group_by(&:itself).max_by { |_, d| d.length }&.first,
          average_commit_interval: calculate_average_interval(commits),
          time_distribution: {
            morning: hours.count { |h| h >= 6 && h < 12 },
            afternoon: hours.count { |h| h >= 12 && h < 18 },
            evening: hours.count { |h| h >= 18 && h < 24 },
            night: hours.count { |h| h >= 0 && h < 6 },
          },
        }
      end

      # Analyze RuboCop-specific patterns
      # @param commits [Array] Array of commit hashes
      # @return [Hash] RuboCop pattern analysis
      def analyze_rubocop_patterns(commits)
        rubocop_commits = commits.select { |c| c['message'].downcase.include?('rubocop') }

        {
          rubocop_commit_count: rubocop_commits.length,
          rubocop_commit_frequency: rubocop_commits.length.to_f / commits.length,
          rubocop_commit_patterns: analyze_rubocop_commit_patterns(rubocop_commits),
          rubocop_offense_patterns: analyze_offense_patterns(rubocop_commits),
        }
      end

      # Generate recommendations based on analysis
      # @param rubocop_cycles [Hash] RuboCop cycle analysis
      # @param dev_patterns [Hash] Development pattern analysis
      # @return [Hash] Recommendations
      def generate_recommendations(rubocop_cycles, dev_patterns)
        {
          optimal_iteration_limit: calculate_optimal_iteration_limit(rubocop_cycles),
          commit_strategy: recommend_commit_strategy(dev_patterns),
          documentation_frequency: recommend_doc_frequency(dev_patterns),
          error_threshold_adjustment: recommend_error_threshold(rubocop_cycles),
          learning_rate: recommend_learning_rate(dev_patterns),
        }
      end

      # Predict optimal max iterations
      # @param patterns [Hash] Commit patterns
      # @param cycles [Hash] Development cycles
      # @return [Integer] Recommended max iterations
      def predict_max_iterations(patterns, cycles)
        # Base on historical cycle data
        avg_iterations = cycles.dig(:average_iterations_per_cycle) || 5

        # Adjust based on patterns
        rubocop_frequency = patterns.dig(:rubocop_patterns, :rubocop_commit_frequency)
        if rubocop_frequency && rubocop_frequency > 0.3
          avg_iterations += 2  # More RuboCop activity = more iterations needed
        end

        # Ensure minimum reasonable value and cap at reasonable limit
        [ [ avg_iterations, 5 ].max, 15 ].min
      end

      # Predict optimal commit frequency
      # @param patterns [Hash] Commit patterns
      # @return [String] Recommended commit frequency
      def predict_commit_frequency(patterns)
        avg_daily = patterns.dig(:commit_frequency, :average_daily_commits) || 1

        case avg_daily
        when 0..2
          'per_iteration'
        when 3..5
          'per_cycle'
        else
          'continuous'
        end
      end

      # Predict documentation update strategy
      # @param patterns [Hash] Commit patterns
      # @return [String] Recommended strategy
      def predict_doc_strategy(patterns)
        doc_mentions = patterns.dig(:message_patterns, :doc_mentions) || 0
        total_commits = patterns.dig(:message_patterns)&.values&.sum || 1

        if doc_mentions.to_f / total_commits > 0.1
          'frequent'
        else
          'minimal'
        end
      end

      # Predict error threshold
      # @param patterns [Hash] Commit patterns
      # @param cycles [Hash] Development cycles
      # @return [Integer] Recommended error threshold
      def predict_error_threshold(patterns, cycles)
        # Base on historical offense patterns
        avg_offenses = cycles.dig(:offense_reduction_patterns, :average_initial_offenses) || 10

        # Adjust based on development velocity
        development_velocity = patterns.dig(:development_patterns, :development_velocity)
        if development_velocity && development_velocity > 5
          avg_offenses += 5  # Higher velocity = higher tolerance
        end

        avg_offenses
      end

      # Predict learning adaptation rate
      # @param patterns [Hash] Commit patterns
      # @return [Float] Recommended learning rate
      def predict_learning_adaptation(patterns)
        # Base on pattern consistency
        consistency = calculate_pattern_consistency(patterns)

        # Higher consistency = lower learning rate needed
        [ 0.1, 1.0 - consistency ].max
      end

      # Calculate commit velocity
      # @param commits [Array] Array of commits
      # @return [Float] Commit velocity
      def calculate_commit_velocity(commits)
        return 0.0 if commits.length < 2

        time_span = Time.zone.parse(commits.first['date']) - Time.zone.parse(commits.last['date'])
        commits.length.to_f / (time_span / 86400)  # commits per day
      end

      # Calculate average commit interval
      # @param commits [Array] Array of commits
      # @return [Float] Average interval in hours
      def calculate_average_interval(commits)
        return 0.0 if commits.length < 2

        intervals = []
        (0...commits.length - 1).each do |i|
          interval = Time.zone.parse(commits[i]['date']) - Time.zone.parse(commits[i + 1]['date'])
          intervals << interval / 3600  # Convert to hours
        end

        intervals.sum.to_f / intervals.length
      end

      # Analyze RuboCop commit patterns
      # @param rubocop_commits [Array] RuboCop-related commits
      # @return [Hash] Pattern analysis
      def analyze_rubocop_commit_patterns(rubocop_commits)
        return {} if rubocop_commits.empty?

        {
          iteration_patterns: rubocop_commits.count { |c| c['message'].include?('iteration') },
          offense_patterns: rubocop_commits.count { |c| c['message'].include?('offenses') },
          correction_patterns: rubocop_commits.count { |c| c['message'].include?('corrected') },
        }
      end

      # Analyze offense patterns
      # @param rubocop_commits [Array] RuboCop-related commits
      # @return [Hash] Offense pattern analysis
      def analyze_offense_patterns(rubocop_commits)
        offense_counts = []

        rubocop_commits.each do |commit|
          if commit['message'] =~ /offenses? (\d+)/
            # Defensive: ensure offense_counts is an array
            offense_counts ||= []
            offense_counts << $1.to_i
          end
        end

        return {} if offense_counts.empty?

        {
          average_initial_offenses: offense_counts.first,
          average_final_offenses: offense_counts.last,
          offense_trend: offense_counts,
        }
      end

      # Analyze offense reduction patterns
      # @param cycles [Array] Development cycles
      # @return [Hash] Reduction pattern analysis
      def analyze_offense_reduction_patterns(cycles)
        return {} if cycles.empty?

        initial_offenses = cycles.map { |c| c[:offenses] }
        corrections = cycles.map { |c| c[:corrected] }

        {
          average_initial_offenses: initial_offenses.sum.to_f / initial_offenses.length,
          average_corrections: corrections.sum.to_f / corrections.length,
          reduction_efficiency: corrections.sum.to_f / initial_offenses.sum,
          improvement_rate: calculate_improvement_rate(cycles),
        }
      end

      # Calculate cycle efficiency
      # @param cycles [Array] Development cycles
      # @return [Float] Efficiency score
      def calculate_cycle_efficiency(cycles)
        return 0.0 if cycles.empty?

        total_offenses_reduced = cycles.sum { |c| c[:corrected] }
        total_time = cycles.sum { |c| c[:duration] || 0 }

        return 0.0 if total_time == 0

        total_offenses_reduced.to_f / total_time  # offenses reduced per second
      end

      # Calculate optimal iteration limit
      # @param cycles [Hash] Development cycles
      # @return [Integer] Optimal limit
      def calculate_optimal_iteration_limit(cycles)
        avg_iterations = cycles[:average_iterations_per_cycle] || 5
        efficiency = cycles[:cycle_efficiency] || 0

        # Adjust based on efficiency
        if efficiency > 0.1
          avg_iterations -= 1  # High efficiency = fewer iterations needed
        elsif efficiency < 0.01
          avg_iterations += 2  # Low efficiency = more iterations needed
        end

        [ avg_iterations, 20 ].min
      end

      # Recommend commit strategy
      # @param dev_patterns [Hash] Development patterns
      # @return [String] Recommended strategy
      def recommend_commit_strategy(dev_patterns)
        velocity = dev_patterns[:development_velocity] || 1

        case velocity
        when 0..2
          'conservative'  # Few commits = careful strategy
        when 3..5
          'balanced'      # Moderate velocity = balanced approach
        else
          'aggressive'    # High velocity = frequent commits
        end
      end

      # Recommend documentation frequency
      # @param dev_patterns [Hash] Development patterns
      # @return [String] Recommended frequency
      def recommend_doc_frequency(dev_patterns)
        quality_ratio = dev_patterns.dig(:code_quality_trends, :quality_commit_ratio) || 0

        if quality_ratio > 0.3
          'frequent'      # High quality focus = frequent docs
        elsif quality_ratio > 0.1
          'moderate'      # Moderate quality = moderate docs
        else
          'minimal'       # Low quality focus = minimal docs
        end
      end

      # Recommend error threshold
      # @param cycles [Hash] Development cycles
      # @return [Integer] Recommended threshold
      def recommend_error_threshold(cycles)
        avg_offenses = cycles.dig(:offense_reduction_patterns, :average_initial_offenses) || 10
        efficiency = cycles.dig(:cycle_efficiency) || 0

        # Adjust based on efficiency
        if efficiency > 0.1
          avg_offenses += 5  # High efficiency = higher tolerance
        else
          avg_offenses = [ avg_offenses - 2, 1 ].max  # Low efficiency = lower tolerance
        end

        avg_offenses
      end

      # Recommend learning rate
      # @param dev_patterns [Hash] Development patterns
      # @return [Float] Recommended learning rate
      def recommend_learning_rate(dev_patterns)
        velocity = dev_patterns.dig(:development_velocity) || 1
        collaboration = dev_patterns.dig(:collaboration_patterns, :collaboration_index) || 0

        # Higher velocity and collaboration = higher learning rate
        base_rate = 0.1
        velocity_bonus = [ velocity * 0.05, 0.3 ].min
        collaboration_bonus = collaboration * 0.2

        [ base_rate + velocity_bonus + collaboration_bonus, 1.0 ].min
      end

      # Calculate improvement rate
      # @param cycles [Array] Development cycles
      # @return [Float] Improvement rate
      def calculate_improvement_rate(cycles)
        return 0.0 if cycles.length < 2

        # Compare first and last cycle
        first_cycle = cycles.last
        last_cycle = cycles.first

        initial_offenses = first_cycle[:offenses]
        final_offenses = last_cycle[:offenses]

        return 0.0 if initial_offenses == 0

        (initial_offenses - final_offenses).to_f / initial_offenses
      end

      # Calculate pattern consistency
      # @param patterns [Hash] Commit patterns
      # @return [Float] Consistency score
      def calculate_pattern_consistency(patterns)
        # Simple consistency metric based on standard deviation
        frequencies = patterns[:commit_frequency]
        return 0.5 if frequencies.empty?

        daily_counts = frequencies[:daily_commits] || []
        return 0.5 if daily_counts.empty?

        mean = daily_counts.sum.to_f / daily_counts.length
        variance = daily_counts.sum { |count| (count - mean) ** 2 }.to_f / daily_counts.length
        std_dev = Zeropoint::Math.sqrt(variance)

        # Lower std dev = higher consistency
        [ 1.0 - (std_dev / mean), 0.0 ].max
      end

      # Load learning data
      # @return [Hash] Learning data
      def load_learning_data
        return {} unless File.exist?(CONFIG[:learning_file])

        JSON.parse(File.read(CONFIG[:learning_file]))
      rescue JSON::ParserError
        {}
      end

      # Update learning data
      # @param new_data [Hash] New learning data
      def update_learning_data(new_data)
        @learning_data = @learning_data.dup if @learning_data.frozen?
        @learning_data.merge!(new_data)
        File.write(CONFIG[:learning_file], @learning_data.to_json)
      end

      # Log a message
      # @param message [String] Message to log
      def log_message(message)
        timestamp = Time.zone.now.strftime('%Y-%m-%d %H:%M:%S')
        Rails.logger.debug "[#{timestamp}] GitLearning: #{message}"
      end
    end
  end
end
