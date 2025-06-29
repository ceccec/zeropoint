# frozen_string_literal: true

# RuboCop Development Rake Task
#
# Provides Rake tasks for running the RuboCop development loop
# and managing the self-documenting development process.
#
namespace :rubocop do
  desc 'Run the RuboCop development loop until error vortex is void'
  task :develop do
    require_relative '../rubocop/development_loop'

    puts '🚀 Starting RuboCop Development Loop...'
    puts 'Target: Void the error vortex'
    puts '=' * 50

    begin
      results = RuboCop::DevelopmentLoop.run

      puts '=' * 50
      puts '🎉 Development Loop Complete!'
      puts "Total iterations: #{results[:total_iterations]}"
      puts "Final offenses: #{results[:final_offenses]}"
      puts "Error vortex void: #{results[:error_vortex_void] ? 'YES' : 'NO'}"

      if results[:error_vortex_void]
        puts '✨ Success! All RuboCop offenses have been resolved.'
      else
        puts '⚠️  Some offenses remain. Check the todo file for manual fixes.'
      end

    rescue StandardError => e
      puts "❌ Error in development loop: #{e.message}"
      puts e.backtrace.first(5)
    end
  end

  desc 'Run the RuboCop development loop without auto-commit'
  task :develop_no_commit do
    require_relative '../rubocop/development_loop'

    puts '🚀 Starting RuboCop Development Loop (no auto-commit)...'
    puts 'Target: Void the error vortex'
    puts '=' * 50

    begin
      # Temporarily disable auto-commit
      original_config = RuboCop::DevelopmentLoop::CONFIG.dup
      RuboCop::DevelopmentLoop::CONFIG[:auto_commit] = false

      results = RuboCop::DevelopmentLoop.run

      # Restore original config
      RuboCop::DevelopmentLoop::CONFIG[:auto_commit] = original_config[:auto_commit]

      puts '=' * 50
      puts '🎉 Development Loop Complete!'
      puts "Total iterations: #{results[:total_iterations]}"
      puts "Final offenses: #{results[:final_offenses]}"
      puts "Error vortex void: #{results[:error_vortex_void] ? 'YES' : 'NO'}"

      if results[:error_vortex_void]
        puts '✨ Success! All RuboCop offenses have been resolved.'
      else
        puts '⚠️  Some offenses remain. Check the todo file for manual fixes.'
      end

    rescue StandardError => e
      puts "❌ Error in development loop: #{e.message}"
      puts e.backtrace.first(5)
    end
  end

  desc 'Show current RuboCop status'
  task :status do
    puts '📊 Current RuboCop Status'
    puts '=' * 30

    # Run RuboCop and show summary
    output = `bundle exec rubocop --format simple 2>&1`

    if output.include?('no offenses detected')
      puts '✅ No offenses detected - Error vortex is void!'
    else
      offense_count = output.scan(/^\d+ offenses? detected/).first&.match(/^(\d+)/)&.[](1)&.to_i || 0
      puts "⚠️  #{offense_count} offenses detected"
      puts "Run 'rake rubocop:develop' to start the development loop"
    end
  end

  desc 'Reset RuboCop development state'
  task :reset do
    puts '🔄 Resetting RuboCop development state...'

    files_to_remove = [
      '.rubocop_todo.yml',
      'rubocop_development.log',
    ]

    files_to_remove.each do |file|
      if File.exist?(file)
        File.delete(file)
        puts "Deleted #{file}"
      end
    end

    puts '✅ Reset complete'
  end

  desc 'Show development loop configuration'
  task :config do
    require_relative '../rubocop/development_loop'

    puts '⚙️  RuboCop Development Loop Configuration'
    puts '=' * 45

    RuboCop::DevelopmentLoop::CONFIG.each do |key, value|
      puts "#{key}: #{value}"
    end
  end
end
