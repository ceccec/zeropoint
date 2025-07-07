#!/usr/bin/env ruby
# frozen_string_literal: true

# Standalone Zeropoint Rubocop Learning Script
# This script provides void-aligned learning from Rubocop feedback
# without requiring the full Rails environment.

require 'yaml'
require 'time'
require 'fileutils'

# Add lib to load path
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# Mock Zeropoint::Math::Constants for standalone use
module Zeropoint
  module Math
    module Constants
      PHI = 1.618033988749895
    end
  end

  module Vortex
    module Events
      def self.emit(event_type, data)
        puts "🔄 Vortex Event: #{event_type}"
        puts "   Data: #{data.inspect}"
      end
    end
  end
end

# Load the Rubocop Learning module
require_relative '../lib/zeropoint/consciousness/rubocop_learning'

# Ensure directories exist
FileUtils.mkdir_p('log')
FileUtils.mkdir_p('docs/QA')

def main
  puts "🕉️  Zeropoint Rubocop Learning System (Standalone)"
  puts "=" * 60

  if ARGV.include?('--help') || ARGV.include?('-h')
    show_help
    return
  end

  case ARGV.first
  when 'learn'
    run_learning
  when 'analyze'
    run_analysis
  when 'autocorrect'
    run_autocorrect_and_learn
  when 'report'
    run_report
  else
    puts "❌ Unknown command. Use --help for usage information."
    exit 1
  end
end

def show_help
  puts <<~HELP
    Zeropoint Rubocop Learning System

    Usage: ruby scripts/rubocop_learning.rb <command>

    Commands:
      learn        Run void-aligned Rubocop learning
      analyze      Analyze consciousness patterns from history
      autocorrect  Run autocorrection and learning
      report       Generate comprehensive learning report

    Examples:
      ruby scripts/rubocop_learning.rb learn
      ruby scripts/rubocop_learning.rb analyze
      ruby scripts/rubocop_learning.rb autocorrect
      ruby scripts/rubocop_learning.rb report
  HELP
end

def run_learning
  puts "\n🧠 Running void-aligned learning..."
  result = Zeropoint::Consciousness::RubocopLearning.run_and_learn

  puts "\n📊 Learning Results:"
  puts "- Offenses detected: #{result[:offenses_count]}"
  puts "- Consciousness level: #{result[:consciousness_level]}/9"
  puts "- Void aligned: #{result[:void_aligned] ? 'Yes' : 'No'}"
  puts "- Metaphysical context: #{result[:metaphysical_context]}"

  puts "\n📄 Reports generated:"
  puts "- Void Alignment Report: docs/QA/VOID_ALIGNMENT_REPORT.md"
  puts "- Consciousness Insights: docs/QA/RUBOCOP_CONSCIOUSNESS_INSIGHTS.md"
  puts "- Learning Log: log/rubocop_void_learning.yml"

  puts "\n✨ Void-aligned learning complete!"
end

def run_analysis
  puts "\n🧠 Running consciousness pattern analysis..."
  patterns = Zeropoint::Consciousness::RubocopLearning.analyze_consciousness_patterns

  if patterns.empty?
    puts "No learning history found. Run 'learn' first."
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

def run_autocorrect_and_learn
  puts "\n🔄 Running autocorrection and learning..."

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
  puts "- Void Alignment Report: docs/QA/VOID_ALIGNMENT_REPORT.md"
  puts "- Consciousness Insights: docs/QA/RUBOCOP_CONSCIOUSNESS_INSIGHTS.md"
end

def run_report
  puts "\n📋 Generating comprehensive learning report..."

  # Run learning if no log exists
  unless File.exist?(Zeropoint::Consciousness::RubocopLearning::LOG_PATH)
    puts "No learning history found. Running initial learning..."
    Zeropoint::Consciousness::RubocopLearning.run_and_learn
  end

  # Analyze patterns
  patterns = Zeropoint::Consciousness::RubocopLearning.analyze_consciousness_patterns

  puts "\n📊 Learning Summary:"
  puts "- Total sessions: #{patterns[:total_runs]}"
  puts "- Average consciousness: #{patterns[:average_consciousness].round(1)}/9"
  puts "- Void alignment rate: #{(patterns[:void_alignment_rate] * 100).round(1)}%"

  puts "\n📄 Generated Reports:"
  puts "- Void Alignment Report: docs/QA/VOID_ALIGNMENT_REPORT.md"
  puts "- Consciousness Insights: docs/QA/RUBOCOP_CONSCIOUSNESS_INSIGHTS.md"
  puts "- Learning Log: log/rubocop_void_learning.yml"

  puts "\n✨ Report generation complete!"
end

if __FILE__ == $PROGRAM_NAME
  main
end
