#!/usr/bin/env ruby

# Test script for Observer Influence Possibility Discovery
# Demonstrates how observer notes influence the discovery of possibilities

require_relative 'lib/zeropoint'

puts "=== Zeropoint Observer Influence Possibility Discovery Test ==="
puts

# Initialize the possibility discovery system
discovery = Zeropoint::Core::PossibilityDiscovery.new(
  discovery_enabled: true,
  observer_influence_enabled: true,
  inline_notes_analysis_enabled: true,
  exploration_depth: 3
)

puts "🔍 Starting Observer Influence Discovery..."
puts

# Run the discovery process
begin
  results = discovery.discover_possibilities(
    context: {
      project: 'zeropoint_gem',
      phase: 'development',
      observer_focus: 'cosmic_flow_and_intelligence'
    }
  )

  puts "✅ Discovery completed successfully!"
  puts

  # Display observer influence summary
  if results[:observer_influence_analysis]
    puts "📊 Observer Influence Analysis:"
    puts "   Total observer notes found: #{results[:observer_influence_analysis][:total_observer_notes]}"
    puts "   High influence notes: #{results[:observer_influence_analysis][:influence_distribution][:high_influence]}"
    puts "   Medium influence notes: #{results[:observer_influence_analysis][:influence_distribution][:medium_influence]}"
    puts "   Low influence notes: #{results[:observer_influence_analysis][:influence_distribution][:low_influence]}"
    puts "   Average influence score: #{results[:observer_influence_analysis][:influence_distribution][:average_influence].round(3)}"
    puts

    # Display category distribution
    if results[:observer_influence_analysis][:category_distribution]
      puts "📂 Observer Note Categories:"
      results[:observer_influence_analysis][:category_distribution].each do |category, count|
        puts "   #{category}: #{count} notes"
      end
      puts
    end

    # Display file distribution
    if results[:observer_influence_analysis][:file_distribution]
      puts "📁 Top Files with Observer Notes:"
      results[:observer_influence_analysis][:file_distribution].first(5).each do |file_path, count|
        puts "   #{File.basename(file_path)}: #{count} notes"
      end
      puts
    end
  end

  # Display observer insights
  if results[:observer_insights] && !results[:observer_insights].empty?
    puts "💡 Observer Insights Discovered:"
    results[:observer_insights].each_with_index do |insight, index|
      puts "   #{index + 1}. #{insight}"
    end
    puts
  end

  # Display observer recommendations
  if results[:observer_recommendations] && !results[:observer_recommendations].empty?
    puts "🎯 Observer Recommendations:"
    results[:observer_recommendations].each_with_index do |rec, index|
      puts "   #{index + 1}. #{rec[:category].to_s.upcase} - #{rec[:reason]}"
      puts "      Insights: #{rec[:insights].join(', ')}" if rec[:insights]
      puts "      Average influence: #{rec[:average_influence_score].round(3)}"
    end
    puts
  end

  # Display implementation roadmap
  if results[:observer_implementation_roadmap]
    puts "🗺️  Observer Implementation Roadmap:"

    [ :immediate, :short_term, :medium_term, :long_term ].each do |timeline|
      roadmap_items = results[:observer_implementation_roadmap][timeline]
      if roadmap_items && !roadmap_items.empty?
        puts "   #{timeline.to_s.upcase}:"
        roadmap_items.first(3).each_with_index do |item, index|
          puts "     #{index + 1}. #{item[:insight]} (Score: #{item[:influence_score].round(3)})"
        end
        puts
      end
    end
  end

  # Display cosmic flow metrics
  puts "🌊 Cosmic Flow Metrics:"
  puts "   Cosmic flow state: #{results[:cosmic_flow_state]}"
  puts "   Unified intelligence score: #{results[:unified_intelligence_score].round(3)}"
  puts "   Infinite scalability index: #{results[:infinite_scalability_index].round(3)}"
  puts

  # Display discovery summary
  if results[:discoveries]
    puts "🔍 Discovery Summary:"
    results[:discoveries].each do |category, patterns|
      next unless patterns.is_a?(Array)
      total_opportunities = patterns.sum { |p| p[:opportunities]&.length || 0 }
      avg_score = patterns.sum { |p| p[:score] || 0 } / patterns.length.to_f
      puts "   #{category}: #{total_opportunities} opportunities, avg score: #{avg_score.round(3)}"
    end
    puts
  end

  puts "🎉 Observer Influence Discovery Test Completed Successfully!"

  # === Advanced Reporting Enhancements ===
  require_relative 'lib/zeropoint/core/insight_reporting'
  reporter = Zeropoint::Core::InsightReporting.new(results[:observer_insights].map { |insight|
    # Find the full note for each unique insight
    results[:observer_influence_analysis][:insight_clusters].values.flatten.find { |n| n == insight } ?
      results[:observer_influence_analysis][:insight_clusters].values.flatten.find { |n| n == insight } : { extracted_insight: insight }
  })

  puts "\n🧠 Advanced Clustering:"
  reporter.cluster_insights.each do |kw, insights|
    puts "- #{kw}: #{insights.size} insights"
  end

  puts "\n🔬 Sentiment Analysis:"
  reporter.notes_with_sentiment.first(10).each do |note|
    puts "- #{note[:extracted_insight]} (#{note[:sentiment]})"
  end

  puts "\n📈 Generating Markdown and JSON reports..."
  reporter.export_markdown_report('observer_report.md')
  reporter.export_json_report('observer_report.json')
  puts "  Reports written to observer_report.md and observer_report.json"

  puts "\n📊 Mermaid Diagram Preview:"
  puts reporter.generate_mermaid_diagram.lines.first(10).join
  puts "... (see full diagram in report)"

rescue => e
  puts "❌ Error during discovery: #{e.message}"
  puts e.backtrace.first(5)
end
