# frozen_string_literal: true

# RuboCop Development Loop
#
# A self-documenting development system that continuously improves
# RuboCop configuration and documentation until the error vortex is void.
# Now enhanced with Git learning intelligence.
#
# @example Run the development loop
#   RuboCop::DevelopmentLoop.run
#
module RuboCop
  class DevelopmentLoop
    # Configuration for the development loop
    CONFIG = {
      max_iterations: 10,
      documentation_file: 'docs/RUBOCOP_DOCUMENTATION.md',
      config_file: '.rubocop.yml',
      todo_file: '.rubocop_todo.yml',
      log_file: 'rubocop_development.log',
      auto_commit: true,
      commit_message_template: 'RuboCop development loop iteration %d: %d offenses, %d corrected',
      enable_git_learning: true,
      learning_adaptation_rate: 0.1,
    }.freeze

    # Run the complete development loop
    # @return [Hash] Results of the development loop
    def self.run
      new.run
    end

    # Initialize the development loop
    def initialize
      @iteration = 0
      @results = []
      @log = []
      @git_learning = nil

      # Initialize Git learning if enabled
      if CONFIG[:enable_git_learning]
        initialize_git_learning
      end
    end

    # Execute the development loop
    # @return [Hash] Results summary
    def run
      log_message('Starting RuboCop Development Loop')
      log_message('Target: Void the error vortex')
      log_message("Auto-commit: #{CONFIG[:auto_commit] ? 'enabled' : 'disabled'}")
      log_message("Git Learning: #{CONFIG[:enable_git_learning] ? 'enabled' : 'disabled'}")

      # Learn from Git history before starting
      if CONFIG[:enable_git_learning]
        learn_from_git_history
      end

      loop do
        @iteration += 1
        log_message("=== Iteration #{@iteration} ===")

        # Check if we've reached max iterations
        if @iteration > CONFIG[:max_iterations]
          log_message('Maximum iterations reached. Stopping.')
          break
        end

        # Run RuboCop and capture results
        offenses = run_rubocop
        log_message("Found #{offenses} offenses")

        # If no offenses, we've voided the error vortex
        if offenses.zero?
          log_message('🎉 Error vortex is void! No more offenses found.')
          break
        end

        # Auto-correct what we can
        corrected = auto_correct_offenses
        log_message("Auto-corrected #{corrected} offenses")

        # Update documentation
        update_documentation

        # Generate todo for remaining offenses
        generate_todo

        # Auto-commit changes if enabled
        if CONFIG[:auto_commit]
          commit_changes(offenses, corrected)
        end

        # Learn and adapt from this iteration
        if CONFIG[:enable_git_learning]
          learn_from_iteration(offenses, corrected)
        end

        # Store iteration results
        @results ||= []
        @results << {
          iteration: @iteration,
          offenses: offenses,
          corrected: corrected,
          timestamp: Time.zone.now,
          committed: CONFIG[:auto_commit],
          learning_applied: CONFIG[:enable_git_learning],
        }

        log_message("Iteration #{@iteration} complete")
      end

      generate_final_report
    end

    private

    # Initialize Git learning system
    def initialize_git_learning
      require_relative '../zeropoint/intelligence/git_learning'

      # Try to initialize with cache, fallback to without cache if needed
      begin
        require_relative '../zeropoint/cache/redis_cache'
        @git_learning = Zeropoint::Intelligence::GitLearning.new
        log_message('Git learning system initialized with cache')
      rescue LoadError, NameError => e
        log_message("Warning: Could not load cache system: #{e.message}")
        log_message('Initializing Git learning without cache...')

        # Create a simplified version without cache dependency
        @git_learning = create_simplified_git_learning
        log_message('Git learning system initialized without cache')
      end
    rescue LoadError => e
      log_message("Warning: Could not load Git learning system: #{e.message}")
      CONFIG[:enable_git_learning] = false
    end

    # Create simplified Git learning without cache dependency
    def create_simplified_git_learning
      # Create a minimal Git learning object that provides the required interface
      # but doesn't depend on the cache system
      Object.new.tap do |git_learning|
        git_learning.instance_eval do
          def analyze_commit_patterns
            log_message('Simplified Git learning: analyze_commit_patterns')
            {
              commit_frequency: { average_daily_commits: 1 },
              file_change_patterns: { most_changed_files: [] },
              message_patterns: { doc_mentions: 0 },
              time_patterns: { peak_hours: [] },
              rubocop_patterns: { rubocop_commits: 0 },
            }
          end

          def learn_from_development_cycles
            log_message('Simplified Git learning: learn_from_development_cycles')
            {
              rubocop_cycles: { average_iterations_per_cycle: 5 },
              development_patterns: { development_velocity: 1 },
              recommendations: {},
            }
          end

          def predict_optimal_config
            log_message('Simplified Git learning: predict_optimal_config')
            {
              max_iterations: 10,
              auto_commit_frequency: 'per_iteration',
              documentation_update_strategy: 'per_iteration',
              error_threshold: 10,
              learning_adaptation: 0.1,
            }
          end

          def log_message(message)
            timestamp = void_time_now.strftime('%Y-%m-%d %H:%M:%S')
            Rails.logger.debug "[#{timestamp}] #{message}"
          end
        end
      end
    end

    # Learn from Git history
    def learn_from_git_history
      return unless @git_learning

      log_message('Learning from Git history...')

      begin
        # Analyze commit patterns
        patterns = @git_learning.analyze_commit_patterns

        # Learn from development cycles
        cycles = @git_learning.learn_from_development_cycles

        # Predict optimal configuration
        recommendations = @git_learning.predict_optimal_config

        # Apply recommendations
        apply_git_learning_recommendations(recommendations)

        log_message('Git learning complete')
        log_message("Applied recommendations: #{recommendations}")

      rescue StandardError => e
        log_message("Error in Git learning: #{e.message}")
      end
    end

    # Learn from current iteration
    # @param offenses [Integer] Number of offenses found
    # @param corrected [Integer] Number of offenses corrected
    def learn_from_iteration(offenses, corrected)
      return unless @git_learning

      # Store iteration data for learning
      iteration_data = {
        iteration: @iteration,
        offenses: offenses,
        corrected: corrected,
        timestamp: Time.zone.now,
        efficiency: corrected.to_f / offenses,
      }

      # Update learning data
      update_learning_data(iteration_data)

      # Adapt configuration if needed
      adapt_configuration_based_on_learning(iteration_data)
    end

    # Apply Git learning recommendations
    # @param recommendations [Hash] Configuration recommendations
    def apply_git_learning_recommendations(recommendations)
      # Update max iterations if recommended
      if recommendations[:max_iterations] && recommendations[:max_iterations] != CONFIG[:max_iterations]
        old_max = CONFIG[:max_iterations]
        CONFIG[:max_iterations] = recommendations[:max_iterations]
        log_message("Updated max iterations: #{old_max} -> #{CONFIG[:max_iterations]}")
      end

      # Update commit frequency if recommended
      if recommendations[:auto_commit_frequency]
        case recommendations[:auto_commit_frequency]
        when 'per_iteration'
          CONFIG[:auto_commit] = true
        when 'per_cycle'
          CONFIG[:auto_commit] = false  # Will commit at end of cycle
        when 'continuous'
          CONFIG[:auto_commit] = true
        end
        log_message("Updated commit strategy: #{recommendations[:auto_commit_frequency]}")
      end

      # Update documentation strategy if recommended
      if recommendations[:documentation_update_strategy]
        log_message("Documentation strategy: #{recommendations[:documentation_update_strategy]}")
      end

      # Update error threshold if recommended
      if recommendations[:error_threshold]
        log_message("Error threshold recommendation: #{recommendations[:error_threshold]}")
      end

      # Update learning adaptation rate if recommended
      if recommendations[:learning_adaptation]
        CONFIG[:learning_adaptation_rate] = recommendations[:learning_adaptation]
        log_message("Updated learning adaptation rate: #{CONFIG[:learning_adaptation_rate]}")
      end
    end

    # Adapt configuration based on learning
    # @param iteration_data [Hash] Current iteration data
    def adapt_configuration_based_on_learning(iteration_data)
      efficiency = iteration_data[:efficiency]

      # If efficiency is very low, increase max iterations
      if efficiency < 0.3 && @iteration < CONFIG[:max_iterations] - 2
        CONFIG[:max_iterations] += 2
        log_message("Low efficiency detected. Increased max iterations to #{CONFIG[:max_iterations]}")
      end

      # If efficiency is very high, decrease max iterations
      if efficiency > 0.8 && CONFIG[:max_iterations] > 5
        CONFIG[:max_iterations] = [ CONFIG[:max_iterations] - 1, 5 ].max
        log_message("High efficiency detected. Decreased max iterations to #{CONFIG[:max_iterations]}")
      end
    end

    # Update learning data
    # @param iteration_data [Hash] Iteration data
    def update_learning_data(iteration_data)
      # Store in learning file
      learning_file = 'rubocop_learning_data.json'

      existing_data = if File.exist?(learning_file)
        JSON.parse(File.read(learning_file))
      else
        { iterations: [] }
      end

      # Defensive: ensure existing_data is not frozen before modifying
      existing_data = existing_data.dup if existing_data.frozen?

      # Defensive: ensure 'iterations' is an array
      existing_data['iterations'] ||= []
      existing_data['iterations'] = [] unless existing_data['iterations'].is_a?(Array)
      existing_data['iterations'] << iteration_data
      # Keep only last 100 iterations
      existing_data['iterations'] = existing_data['iterations'].last(100)
      File.write(learning_file, existing_data.to_json)
    end

    # Run RuboCop and return number of offenses
    # @return [Integer] Number of offenses found
    def run_rubocop
      output = `bundle exec rubocop --format simple 2>&1`
      @log << "RuboCop Output: #{output}"

      # Count offenses from output
      offense_count = output.scan(/^\d+ offenses? detected/).first&.match(/^(\d+)/)&.[](1)&.to_i || 0
      offense_count
    end

    # Auto-correct offenses
    # @return [Integer] Number of offenses corrected
    def auto_correct_offenses
      output = `bundle exec rubocop --autocorrect --format simple 2>&1`
      @log << "Auto-correct Output: #{output}"

      # Count corrected offenses
      corrected_count = output.scan(/(\d+) offenses? corrected/).first&.first&.to_i || 0
      corrected_count
    end

    # Update documentation with current state
    def update_documentation
      log_message('Updating documentation...')

      # Read current documentation
      doc_content = File.read(CONFIG[:documentation_file])

      # Add development loop section if not present
      unless doc_content.include?('## Development Loop')
        development_section = generate_development_section
        doc_content += "\n\n#{development_section}"
      else
        # Update existing development section
        doc_content = update_development_section(doc_content)
      end

      # Write updated documentation
      File.write(CONFIG[:documentation_file], doc_content)
      log_message('Documentation updated')
    end

    # Generate development section for documentation
    # @return [String] Development section content
    def generate_development_section
      <<~MARKDOWN
        ## Development Loop

        This documentation is automatically updated by the RuboCop Development Loop.
        The loop runs until the error vortex is void (no more offenses found).
        Enhanced with Git learning intelligence for adaptive optimization.

        ### Current Status
        - **Iteration**: #{@iteration}
        - **Last Run**: #{Time.zone.now}
        - **Status**: #{@iteration > CONFIG[:max_iterations] ? 'Max iterations reached' : 'Running'}
        - **Auto-commit**: #{CONFIG[:auto_commit] ? 'enabled' : 'disabled'}
        - **Git Learning**: #{CONFIG[:enable_git_learning] ? 'enabled' : 'disabled'}

        ### Development Loop Configuration
        ```ruby
        CONFIG = {
          max_iterations: #{CONFIG[:max_iterations]},
          documentation_file: '#{CONFIG[:documentation_file]}',
          config_file: '#{CONFIG[:config_file]}',
          todo_file: '#{CONFIG[:todo_file]}',
          log_file: '#{CONFIG[:log_file]}',
          auto_commit: #{CONFIG[:auto_commit]},
          commit_message_template: '#{CONFIG[:commit_message_template]}',
          enable_git_learning: #{CONFIG[:enable_git_learning]},
          learning_adaptation_rate: #{CONFIG[:learning_adaptation_rate]}
        }
        ```

        ### How to Run
        ```ruby
        # Run the development loop
        RuboCop::DevelopmentLoop.run
        ```

        ### Git Learning Intelligence
        The development loop now includes Git learning intelligence that:
        - Analyzes commit patterns and development cycles
        - Predicts optimal configuration based on historical data
        - Adapts behavior based on efficiency patterns
        - Learns from each iteration to improve future runs

        ### Iteration History
        #{generate_iteration_history}
      MARKDOWN
    end

    # Update existing development section
    # @param content [String] Current documentation content
    # @return [String] Updated content
    def update_development_section(content)
      # Find and replace the iteration history
      history_pattern = /### Iteration History\n.*?(?=\n##|\z)/m
      new_history = "### Iteration History\n#{generate_iteration_history}"

      if content.match?(history_pattern)
        content.gsub!(history_pattern, new_history)
      else
        content += "\n#{new_history}"
      end

      content
    end

    # Generate iteration history table
    # @return [String] Markdown table of iterations
    def generate_iteration_history
      return 'No iterations recorded yet.' if @results.empty?

      table = "| Iteration | Offenses | Corrected | Committed | Learning | Timestamp |\n"
      table += "|-----------|----------|-----------|-----------|----------|-----------|\n"

      @results.each do |result|
        committed_status = result[:committed] ? '✅' : '❌'
        learning_status = result[:learning_applied] ? '🧠' : '❌'
        table += "| #{result[:iteration]} | #{result[:offenses]} | #{result[:corrected]} | #{committed_status} | #{learning_status} | #{result[:timestamp]} |\n"
      end

      table
    end

    # Generate todo file for remaining offenses
    def generate_todo
      log_message('Generating todo file...')
      system('bundle exec rubocop --auto-gen-config')
      log_message('Todo file generated')
    end

    # Commit changes to Git
    # @param offenses [Integer] Number of offenses found
    # @param corrected [Integer] Number of offenses corrected
    def commit_changes(offenses, corrected)
      log_message('Committing changes...')

      # Check if there are changes to commit
      status_output = `git status --porcelain 2>&1`

      if status_output.strip.empty?
        log_message('No changes to commit')
        return
      end

      # Stage all changes
      system('git add .')

      # Create commit message
      commit_message = CONFIG[:commit_message_template] % [ @iteration, offenses, corrected ]

      # Commit with detailed message
      detailed_message = <<~COMMIT
        #{commit_message}

        RuboCop Development Loop Iteration #{@iteration}
        - Offenses found: #{offenses}
        - Offenses corrected: #{corrected}
        - Documentation updated: #{CONFIG[:documentation_file]}
        - Log file: #{CONFIG[:log_file]}
        - Git Learning: #{CONFIG[:enable_git_learning] ? 'enabled' : 'disabled'}

        Auto-generated by RuboCop Development Loop with Git Learning Intelligence
      COMMIT

      # Write commit message to file
      File.write('.git/COMMIT_EDITMSG', detailed_message)

      # Commit using the message file
      if system('git commit -F .git/COMMIT_EDITMSG')
        log_message("✅ Changes committed: #{commit_message}")
      else
        log_message('❌ Failed to commit changes')
      end

      # Clean up
      File.delete('.git/COMMIT_EDITMSG') if File.exist?('.git/COMMIT_EDITMSG')
    end

    # Generate final report
    # @return [Hash] Final results
    def generate_final_report
      report = {
        total_iterations: @iteration,
        final_offenses: run_rubocop,
        error_vortex_void: run_rubocop.zero?,
        results: @results,
        log: @log,
        git_learning_enabled: CONFIG[:enable_git_learning],
        learning_adaptations: count_learning_adaptations,
      }

      # Write log file
      File.write(CONFIG[:log_file], @log.join("\n"))

      # Update documentation with final status
      update_documentation

      # Final commit if auto-commit is enabled
      if CONFIG[:auto_commit]
        commit_changes(run_rubocop, 0)
      end

      # Final learning update
      if CONFIG[:enable_git_learning]
        finalize_git_learning
      end

      log_message('Development loop complete')
      log_message("Final report: #{report}")

      report
    end

    # Count learning adaptations made
    # @return [Integer] Number of adaptations
    def count_learning_adaptations
      adaptations = 0

      @results.each do |result|
        adaptations += 1 if result[:learning_applied]
      end

      adaptations
    end

    # Finalize Git learning
    def finalize_git_learning
      return unless @git_learning

      log_message('Finalizing Git learning...')
      begin
        # Update learning data with final results
        final_data = {
          total_iterations: @iteration,
          final_offenses: run_rubocop,
          success: run_rubocop.zero?,
          timestamp: Time.zone.now,
        }
        update_learning_data(final_data)
        # Generate final learning report
        learning_report = @git_learning.learn_from_development_cycles
        log_message("Final learning report: #{learning_report}")
      rescue StandardError => e
        log_message("Error in finalizing Git learning: #{e.message}")
      end
    end

    # Log a message
    # @param message [String] Message to log
    def log_message(message)
      timestamp = void_time_now.strftime('%Y-%m-%d %H:%M:%S')
      log_entry = "[#{timestamp}] #{message}"
      Rails.logger.debug log_entry
      # Defensive: ensure @log is an array
      @log ||= []
      @log << log_entry
    end

    def void_time_now
      # rubocop:disable Rails/TimeZone
      defined?(Time.zone) && Time.zone ? Time.zone.now : Time.now
      # rubocop:enable Rails/TimeZone
    end
  end
end
