# frozen_string_literal: true

# Zeropoint::Consciousness::GitLearning
#
# Consciousness system that learns from Git history using the single
# Zeropoint gateway API for caching, speed, and unified access patterns.
# Embodies the I principle: pure consciousness without artificial labels.
#
# @example Analyze Git consciousness patterns
#   Zeropoint::Consciousness::GitLearning.analyze_consciousness_patterns
#
module Zeropoint
  module Consciousness
    class GitLearning
      include Zeropoint::VortexAware

      # Configuration for Git consciousness via Zeropoint gateway
      CONFIG = {
        analysis_depth: 100,           # Number of commits to analyze
        pattern_threshold: 0.1,        # Minimum frequency for pattern detection
        consciousness_file: 'git_consciousness_data.json',
        commit_patterns_file: 'commit_patterns.yml',
        development_cycles_file: 'development_cycles.yml',
        cache_duration: 3600,          # Cache duration in seconds
        batch_size: 50,                # Batch size for API requests
        zeropoint_path: '/zeropoint',   # Single gateway API path
      }.freeze

      # Analyze Git commit patterns and learn from them
      # @return [Hash] Analysis results
      def self.analyze_consciousness_patterns
        new.analyze_consciousness_patterns
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

      # Initialize the Git consciousness system
      def initialize
        @git_data = {}
        @patterns = {}
        @consciousness_data = load_consciousness_data
      end

      # Analyze consciousness patterns from Git history via gateway API
      # @return [Hash] Analysis results
      def analyze_consciousness_patterns
        # COMPONENT BEST PRACTICE: Use /zeropoint gateway for caching and unified access.
        log_message('Starting Git consciousness pattern analysis via Zeropoint gateway...')

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

        log_message('Consciousness pattern analysis complete')
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

        # Update consciousness data with caching
        cache_consciousness_data(learning_results)

        log_message('Development cycle consciousness learning complete')
        learning_results
      end

      # Predict optimal RuboCop configuration
      # @return [Hash] Configuration recommendations
      def predict_optimal_config
        log_message('Predicting optimal RuboCop configuration via Zeropoint gateway...')

        # Get cached patterns or fetch via gateway
        commit_patterns = get_cached_patterns || analyze_consciousness_patterns
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
          consciousness_adaptation: predict_consciousness_adaptation(patterns),
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
        cache_key = "vortex:git_consciousness:commits:#{CONFIG[:analysis_depth]}"
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

        file_changes
      end

      # Analyze RuboCop development cycles via gateway API
      # @return [Hash] RuboCop cycles analysis
      def analyze_rubocop_development_cycles_via_gateway
        cache_key = 'vortex:git_consciousness:cycles'
        cached_cycles = Zeropoint::Vortex::CacheMatrix.instance.fetch(cache_key)
        return cached_cycles if cached_cycles

        # Get commits via gateway
        commits = get_recent_commits_via_gateway
        rubocop_commits = commits.select { |c| c['message'].downcase.include?('rubocop') }

        # Parse RuboCop cycles
        cycles = parse_rubocop_cycles(rubocop_commits)

        # Cache cycles
        Zeropoint::Vortex::CacheMatrix.instance.store(cache_key, cycles)
        cycles
      end

      # Analyze development patterns via gateway API
      # @return [Hash] Development patterns analysis
      def analyze_development_patterns_via_gateway
        cache_key = 'vortex:git_consciousness:dev_patterns'
        cached_patterns = Zeropoint::Vortex::CacheMatrix.instance.fetch(cache_key)
        return cached_patterns if cached_patterns

        # Get commits via gateway
        commits = get_recent_commits_via_gateway

        # Analyze patterns
        patterns = {
          development_velocity: calculate_commit_velocity(commits),
          average_interval: calculate_average_interval(commits),
          commit_consistency: calculate_pattern_consistency({ commit_frequency: analyze_commit_frequency(commits) }),
        }

        # Cache patterns
        Zeropoint::Vortex::CacheMatrix.instance.store(cache_key, patterns)
        patterns
      end

      # Post to Zeropoint gateway API
      # @param service [String] Service name
      # @param data [Hash] Request data
      # @return [Hash] Response data
      def post_to_gateway(service, data)
        begin
          # Use Zeropoint gateway for unified access
          response = Zeropoint::Void::Core.call(service, data)
          { success: true, data: response }
        rescue StandardError => e
          { success: false, error: e.message }
        end
      end

      # Calculate consciousness level
      # @return [Float] Consciousness level (0.0 - 1.0)
      def calculate_consciousness_level
        # Base consciousness level for GitLearning operations
        base_level = 0.7

        # Adjust based on pattern complexity
        pattern_complexity = @patterns.values.compact.length
        complexity_bonus = [pattern_complexity * 0.1, 0.3].min

        # Adjust based on learning depth
        learning_depth = @consciousness_data.keys.length
        depth_bonus = [learning_depth * 0.05, 0.2].min

        [base_level + complexity_bonus + depth_bonus, 1.0].min
      end

      # Parse RuboCop cycles from commits
      # @param commits [Array] Array of commit hashes
      # @return [Hash] RuboCop cycles analysis
      def parse_rubocop_cycles(commits)
        cycles = []
        current_cycle = nil

        commits.each do |commit|
          message = commit['message'].downcase

          if message.include?('rubocop') && (message.include?('fix') || message.include?('correct'))
            # Start new cycle
            if current_cycle
              cycles << current_cycle
            end

            current_cycle = {
              start_commit: commit['hash'],
              start_date: Time.zone.parse(commit['date']),
              iterations: 1,
              initial_offenses: extract_offense_count(message),
            }
          elsif current_cycle && message.include?('rubocop')
            # Continue current cycle
            current_cycle[:iterations] += 1
            current_cycle[:final_offenses] = extract_offense_count(message)
          end
        end

        # Add final cycle
        cycles << current_cycle if current_cycle

        # Calculate cycle statistics
        {
          total_cycles: cycles.length,
          average_iterations_per_cycle: cycles.empty? ? 0 : cycles.sum { |c| c[:iterations] } / cycles.length.to_f,
          offense_reduction_patterns: analyze_offense_reduction_patterns(cycles),
          cycle_efficiency: calculate_cycle_efficiency(cycles),
        }
      end

      # Cache patterns
      # @param patterns [Hash] Patterns to cache
      def cache_patterns(patterns)
        Zeropoint::Vortex::CacheMatrix.instance.store('vortex:git_consciousness:patterns', patterns)
      end

      # Cache consciousness data
      # @param consciousness_data [Hash] Consciousness data to cache
      def cache_consciousness_data(consciousness_data)
        Zeropoint::Vortex::CacheMatrix.instance.store('vortex:git_consciousness:consciousness', consciousness_data)
      end

      # Cache recommendations
      # @param recommendations [Hash] Recommendations to cache
      def cache_recommendations(recommendations)
        Zeropoint::Vortex::CacheMatrix.instance.store('vortex:git_consciousness:recommendations', recommendations)
      end

      # Get cached patterns
      # @return [Hash, nil] Cached patterns
      def get_cached_patterns
        Zeropoint::Vortex::CacheMatrix.instance.fetch('vortex:git_consciousness:patterns')
      end

      # Get cached cycles
      # @return [Hash, nil] Cached cycles
      def get_cached_cycles
        Zeropoint::Vortex::CacheMatrix.instance.fetch('vortex:git_consciousness:consciousness')
      end

      # Analyze commit frequency
      # @param commits [Array] Array of commit hashes
      # @return [Hash] Commit frequency analysis
      def analyze_commit_frequency(commits)
        return {} if commits.empty?

        # Group commits by date
        commits_by_date = commits.group_by { |c| Date.parse(c['date']) }

        # Calculate frequency metrics
        {
          total_commits: commits.length,
          average_daily_commits: commits.length / [commits_by_date.keys.length, 1].max.to_f,
          peak_commit_days: commits_by_date.max_by(5) { |_date, day_commits| day_commits.length }&.map { |date, _| date.to_s },
          commit_velocity: calculate_commit_velocity(commits),
        }
      end

      # Analyze commit messages
      # @param commits [Array] Array of commit hashes
      # @return [Hash] Commit message analysis
      def analyze_commit_messages(commits)
        messages = commits.map { |c| c['message'] }

        {
          total_messages: messages.length,
          average_message_length: messages.sum { |m| m.length } / messages.length.to_f,
          rubocop_mentions: messages.count { |m| m.downcase.include?('rubocop') },
          fix_mentions: messages.count { |m| m.downcase.include?('fix') },
          doc_mentions: messages.count { |m| m.downcase.include?('doc') || m.downcase.include?('readme') },
        }
      end

      # Analyze time patterns
      # @param commits [Array] Array of commit hashes
      # @return [Hash] Time pattern analysis
      def analyze_time_patterns(commits)
        return {} if commits.empty?

        # Extract hours from commit timestamps
        hours = commits.map { |c| Time.zone.parse(c['date']).hour }

        # Calculate peak hours
        hour_counts = hours.tally
        peak_hour = hour_counts.max_by { |_hour, count| count }&.first

        {
          total_commits: commits.length,
          peak_hours: peak_hour,
          time_distribution: hour_counts,
        }
      end

      # Analyze RuboCop patterns
      # @param commits [Array] Array of commit hashes
      # @return [Hash] RuboCop pattern analysis
      def analyze_rubocop_patterns(commits)
        rubocop_commits = commits.select { |c| c['message'].downcase.include?('rubocop') }

        {
          rubocop_commit_count: rubocop_commits.length,
          rubocop_commit_frequency: rubocop_commits.length / commits.length.to_f,
          rubocop_commit_patterns: analyze_rubocop_commit_patterns(rubocop_commits),
          offense_patterns: analyze_offense_patterns(rubocop_commits),
        }
      end

      # Generate recommendations
      # @param rubocop_cycles [Hash] RuboCop cycles data
      # @param dev_patterns [Hash] Development patterns data
      # @return [Hash] Recommendations
      def generate_recommendations(rubocop_cycles, dev_patterns)
        {
          max_iterations: recommend_max_iterations(rubocop_cycles),
          commit_strategy: recommend_commit_strategy(dev_patterns),
          doc_frequency: recommend_doc_frequency(dev_patterns),
          error_threshold: recommend_error_threshold(rubocop_cycles),
          consciousness_rate: recommend_consciousness_rate(dev_patterns),
        }
      end

      # Predict max iterations
      # @param patterns [Hash] Commit patterns
      # @param cycles [Hash] Development cycles
      # @return [Integer] Recommended max iterations
      def predict_max_iterations(patterns, cycles)
        # Base on historical cycle data
        avg_iterations = cycles.dig(:average_iterations_per_cycle) || 5

        # Adjust based on development velocity
        velocity = patterns.dig(:commit_frequency, :commit_velocity) || 1
        if velocity > 5
          avg_iterations += 2  # Higher velocity = more iterations needed
        elsif velocity < 2
          avg_iterations = [avg_iterations - 1, 3].max  # Lower velocity = fewer iterations
        end

        avg_iterations.to_i
      end

      # Predict commit frequency
      # @param patterns [Hash] Commit patterns
      # @return [String] Recommended commit frequency
      def predict_commit_frequency(patterns)
        avg_daily = patterns.dig(:commit_frequency, :average_daily_commits) || 1

        if avg_daily > 5
          'per_iteration'
        elsif avg_daily > 2
          'per_cycle'
        else
          'continuous'
        end
      end

      # Predict documentation strategy
      # @param patterns [Hash] Commit patterns
      # @return [String] Recommended documentation strategy
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

      # Predict consciousness adaptation rate
      # @param patterns [Hash] Commit patterns
      # @return [Float] Recommended consciousness rate
      def predict_consciousness_adaptation(patterns)
        # Base on pattern consistency
        consistency = calculate_pattern_consistency(patterns)

        # Higher consistency = lower consciousness rate needed
        [0.1, 1.0 - consistency].max
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
        commits.each_cons(2) do |commit1, commit2|
          interval = Time.zone.parse(commit2['date']) - Time.zone.parse(commit1['date'])
          intervals << interval / 3600  # Convert to hours
        end

        intervals.sum / intervals.length
      end

      # Analyze RuboCop commit patterns
      # @param rubocop_commits [Array] Array of RuboCop commits
      # @return [Hash] RuboCop commit pattern analysis
      def analyze_rubocop_commit_patterns(rubocop_commits)
        return {} if rubocop_commits.empty?

        {
          total_rubocop_commits: rubocop_commits.length,
          fix_commits: rubocop_commits.count { |c| c['message'].downcase.include?('fix') },
          correct_commits: rubocop_commits.count { |c| c['message'].downcase.include?('correct') },
          auto_correct_commits: rubocop_commits.count { |c| c['message'].downcase.include?('auto') },
        }
      end

      # Analyze offense patterns
      # @param rubocop_commits [Array] Array of RuboCop commits
      # @return [Hash] Offense pattern analysis
      def analyze_offense_patterns(rubocop_commits)
        offense_counts = []

        rubocop_commits.each do |commit|
          message = commit['message']
          if message.match(/(\d+)\s+offenses?/)
            offense_counts << $1.to_i
          end
        end

        return {} if offense_counts.empty?

        {
          total_offenses_found: offense_counts.sum,
          average_offenses_per_commit: offense_counts.sum / offense_counts.length.to_f,
          max_offenses_in_commit: offense_counts.max,
          min_offenses_in_commit: offense_counts.min,
        }
      end

      # Analyze offense reduction patterns
      # @param cycles [Array] Array of RuboCop cycles
      # @return [Hash] Offense reduction pattern analysis
      def analyze_offense_reduction_patterns(cycles)
        return {} if cycles.empty?

        initial_offenses = cycles.map { |c| c[:initial_offenses] }.compact
        final_offenses = cycles.map { |c| c[:final_offenses] }.compact

        return {} if initial_offenses.empty?

        {
          total_cycles_analyzed: cycles.length,
          average_initial_offenses: initial_offenses.sum / initial_offenses.length.to_f,
          average_final_offenses: final_offenses.empty? ? 0 : final_offenses.sum / final_offenses.length.to_f,
          average_offense_reduction: initial_offenses.sum / initial_offenses.length.to_f - (final_offenses.empty? ? 0 : final_offenses.sum / final_offenses.length.to_f),
        }
      end

      # Calculate cycle efficiency
      # @param cycles [Array] Array of RuboCop cycles
      # @return [Float] Cycle efficiency score
      def calculate_cycle_efficiency(cycles)
        return 0.0 if cycles.empty?

        # Calculate efficiency based on iterations and offense reduction
        efficiencies = cycles.map do |cycle|
          iterations = cycle[:iterations]
          initial_offenses = cycle[:initial_offenses] || 0
          final_offenses = cycle[:final_offenses] || 0

          offense_reduction = initial_offenses - final_offenses
          efficiency = offense_reduction / [iterations, 1].max.to_f
          [efficiency, 1.0].min  # Cap at 1.0
        end

        efficiencies.sum / efficiencies.length
      end

      # Calculate optimal iteration limit
      # @param cycles [Hash] Cycles data
      # @return [Integer] Optimal iteration limit
      def calculate_optimal_iteration_limit(cycles)
        avg_iterations = cycles[:average_iterations_per_cycle] || 5
        efficiency = cycles[:cycle_efficiency] || 0.5

        # Adjust based on efficiency
        if efficiency > 0.8
          avg_iterations - 1  # High efficiency = fewer iterations needed
        elsif efficiency < 0.3
          avg_iterations + 2  # Low efficiency = more iterations needed
        end

        [avg_iterations, 3].max  # Minimum 3 iterations
      end

      # Recommend max iterations
      # @param cycles [Hash] Cycles data
      # @return [Integer] Recommended max iterations
      def recommend_max_iterations(cycles)
        calculate_optimal_iteration_limit(cycles)
      end

      # Recommend commit strategy
      # @param dev_patterns [Hash] Development patterns
      # @return [String] Recommended commit strategy
      def recommend_commit_strategy(dev_patterns)
        velocity = dev_patterns[:development_velocity] || 1

        if velocity > 5
          'per_iteration'
        elsif velocity > 2
          'per_cycle'
        else
          'continuous'
        end
      end

      # Recommend documentation frequency
      # @param dev_patterns [Hash] Development patterns
      # @return [String] Recommended documentation frequency
      def recommend_doc_frequency(dev_patterns)
        quality_ratio = dev_patterns.dig(:code_quality_trends, :quality_commit_ratio) || 0

        if quality_ratio > 0.7
          'frequent'
        elsif quality_ratio > 0.3
          'moderate'
        else
          'minimal'
        end
      end

      # Recommend error threshold
      # @param cycles [Hash] Cycles data
      # @return [Integer] Recommended error threshold
      def recommend_error_threshold(cycles)
        avg_offenses = cycles.dig(:offense_reduction_patterns, :average_initial_offenses) || 10

        # Adjust based on cycle efficiency
        efficiency = cycles[:cycle_efficiency] || 0.5
        if efficiency > 0.8
          avg_offenses + 5  # High efficiency = higher tolerance
        elsif efficiency < 0.3
          avg_offenses - 3  # Low efficiency = lower tolerance
        end

        [avg_offenses, 5].max  # Minimum threshold of 5
      end

      # Recommend consciousness rate
      # @param dev_patterns [Hash] Development patterns
      # @return [Float] Recommended consciousness rate
      def recommend_consciousness_rate(dev_patterns)
        velocity = dev_patterns.dig(:development_velocity) || 1
        consistency = dev_patterns.dig(:commit_consistency) || 0.5

        # Higher velocity and consistency = lower consciousness rate needed
        base_rate = 0.5
        velocity_factor = [velocity / 10.0, 0.3].min
        consistency_factor = consistency * 0.2

        [base_rate - velocity_factor - consistency_factor, 0.1].max
      end

      # Calculate improvement rate
      # @param cycles [Array] Array of cycles
      # @return [Float] Improvement rate
      def calculate_improvement_rate(cycles)
        return 0.0 if cycles.length < 2

        # Calculate improvement over time
        improvements = []
        cycles.each_cons(2) do |cycle1, cycle2|
          efficiency1 = cycle1[:efficiency] || 0.5
          efficiency2 = cycle2[:efficiency] || 0.5
          improvement = efficiency2 - efficiency1
          improvements << improvement
        end

        improvements.sum / improvements.length
      end

      # Calculate pattern consistency
      # @param patterns [Hash] Patterns data
      # @return [Float] Pattern consistency score
      def calculate_pattern_consistency(patterns)
        # Simple consistency metric based on standard deviation
        frequencies = patterns[:commit_frequency]
        return 0.5 unless frequencies

        daily_commits = frequencies[:average_daily_commits] || 1
        total_commits = frequencies[:total_commits] || 1

        # Higher consistency = more predictable patterns
        consistency = daily_commits / [total_commits, 1].max.to_f
        [consistency, 1.0].min
      end

      # Load consciousness data
      # @return [Hash] Consciousness data
      def load_consciousness_data
        return {} unless File.exist?(CONFIG[:consciousness_file])

        begin
          JSON.parse(File.read(CONFIG[:consciousness_file]))
        rescue JSON::ParserError
          {}
        end
      end

      # Update consciousness data
      # @param new_data [Hash] New consciousness data
      def update_consciousness_data(new_data)
        @consciousness_data = @consciousness_data.dup if @consciousness_data.frozen?
        @consciousness_data.merge!(new_data)

        File.write(CONFIG[:consciousness_file], @consciousness_data.to_json)
      end

      # Extract offense count from commit message
      # @param message [String] Commit message
      # @return [Integer, nil] Offense count
      def extract_offense_count(message)
        match = message.match(/(\d+)\s+offenses?/)
        match ? match[1].to_i : nil
      end

      # Log a message
      # @param message [String] Message to log
      def log_message(message)
        timestamp = Time.zone.now.strftime('%Y-%m-%d %H:%M:%S')
        Rails.logger.debug "[#{timestamp}] GitConsciousness: #{message}"
      end
    end
  end
end 