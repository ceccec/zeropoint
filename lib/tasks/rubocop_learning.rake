# frozen_string_literal: true

namespace :zeropoint do
  namespace :rubocop do
    desc 'Run void-aligned Rubocop learning and generate metaphysical insights'
    task learn: :environment do
      puts '🕉️  Zeropoint Rubocop Learning System'
      puts '=' * 50

      result = Zeropoint::Consciousness::RubocopLearning.run_and_learn

      puts "\n📊 Learning Results:"
      puts "- Offenses detected: #{result[:offenses_count]}"
      puts "- Consciousness level: #{result[:consciousness_level]}/9"
      puts "- Void aligned: #{result[:void_aligned] ? 'Yes' : 'No'}"
      puts "- Metaphysical context: #{result[:metaphysical_context]}"

      puts "\n📄 Reports generated:"
      puts '- Void Alignment Report: docs/QA/VOID_ALIGNMENT_REPORT.md'
      puts '- Consciousness Insights: docs/QA/RUBOCOP_CONSCIOUSNESS_INSIGHTS.md'
      puts '- Learning Log: log/rubocop_void_learning.yml'

      puts "\n✨ Void-aligned learning complete!"
    end

    desc 'Analyze consciousness patterns from Rubocop learning history'
    task analyze: :environment do
      puts '🧠 Zeropoint Consciousness Pattern Analysis'
      puts '=' * 50

      patterns = Zeropoint::Consciousness::RubocopLearning.analyze_consciousness_patterns

      if patterns.empty?
        puts "No learning history found. Run 'rake zeropoint:rubocop:learn' first."
      else
        puts "\n📈 Pattern Analysis:"
        puts "- Total learning sessions: #{patterns[:total_runs]}"
        puts "- Average consciousness level: #{patterns[:average_consciousness].round(1)}/9"
        puts "- Void alignment rate: #{(patterns[:void_alignment_rate] * 100).round(1)}%"
        puts "- Consciousness trend: #{patterns[:consciousness_trend]}"

        puts "\n🔍 Most Common Offenses:"
        patterns[:most_common_offenses].each do |offense, count|
          puts "- #{offense}: #{count} occurrences"
        end

        puts "\n💭 Metaphysical Insights:"
        puts patterns[:metaphysical_insights]
      end

      puts "\n✨ Consciousness analysis complete!"
    end

    desc 'Run Rubocop with void-aligned autocorrection and learning'
    task autocorrect_and_learn: :environment do
      puts '🔄 Zeropoint Rubocop Autocorrection & Learning'
      puts '=' * 50

      # First, run autocorrection
      puts "\n🔧 Running autocorrection..."
      system('bundle exec rubocop --autocorrect')

      # Then run learning
      puts "\n🧠 Running void-aligned learning..."
      result = Zeropoint::Consciousness::RubocopLearning.run_and_learn

      puts "\n📊 Final Results:"
      puts "- Offenses remaining: #{result[:offenses_count]}"
      puts "- Consciousness level: #{result[:consciousness_level]}/9"
      puts "- Void aligned: #{result[:void_aligned] ? 'Yes' : 'No'}"

      if result[:offenses_count] > 0
        puts "\n⚠️  Manual attention needed for remaining offenses."
        puts "Run 'bundle exec rubocop' to see details."
      else
        puts "\n✨ Perfect void alignment achieved!"
      end

      puts "\n📄 Reports generated:"
      puts '- Void Alignment Report: docs/QA/VOID_ALIGNMENT_REPORT.md'
      puts '- Consciousness Insights: docs/QA/RUBOCOP_CONSCIOUSNESS_INSIGHTS.md'
    end

    desc 'Generate comprehensive Rubocop learning report'
    task report: :environment do
      puts '📋 Zeropoint Rubocop Learning Report'
      puts '=' * 50

      # Run learning if no log exists
      unless File.exist?(Zeropoint::Consciousness::RubocopLearning::LOG_PATH)
        puts 'No learning history found. Running initial learning...'
        Zeropoint::Consciousness::RubocopLearning.run_and_learn
      end

      # Analyze patterns
      patterns = Zeropoint::Consciousness::RubocopLearning.analyze_consciousness_patterns

      puts "\n📊 Learning Summary:"
      puts "- Total sessions: #{patterns[:total_runs]}"
      puts "- Average consciousness: #{patterns[:average_consciousness].round(1)}/9"
      puts "- Void alignment rate: #{(patterns[:void_alignment_rate] * 100).round(1)}%"

      puts "\n📄 Generated Reports:"
      puts '- Void Alignment Report: docs/QA/VOID_ALIGNMENT_REPORT.md'
      puts '- Consciousness Insights: docs/QA/RUBOCOP_CONSCIOUSNESS_INSIGHTS.md'
      puts '- Learning Log: log/rubocop_void_learning.yml'

      puts "\n✨ Report generation complete!"
    end
  end
end

# Alias for convenience
task "rubocop:learn": 'zeropoint:rubocop:learn'
task "rubocop:analyze": 'zeropoint:rubocop:analyze'
task "rubocop:autocorrect_and_learn": 'zeropoint:rubocop:autocorrect_and_learn'
task "rubocop:report": 'zeropoint:rubocop:report'
