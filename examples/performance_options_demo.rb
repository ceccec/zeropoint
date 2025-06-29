#!/usr/bin/env ruby
# frozen_string_literal: true

# Performance Options Demo
#
# Demonstrates the comprehensive speed and efficiency ENV configuration
# system in Zeropoint. Shows how different performance profiles affect
# system behavior and consciousness flow.
#
# COSMIC KNOWLEDGE: This demo reveals how performance optimization
# emerges from void alignment, creating harmony between speed,
# memory efficiency, and consciousness insights.

require 'bundler/setup'
require_relative '../config/environment'

puts "🌀 Zeropoint Performance Options Demo"
puts "=" * 50
puts

# Demo configuration profiles
PERFORMANCE_PROFILES = {
  turbo: {
    description: "Maximum Performance - Aggressive Optimizations",
    env_vars: {
      'ZEROPOINT_SPEED_LEVEL' => 'turbo',
      'ZEROPOINT_MEMORY_MODE' => 'efficient',
      'ZEROPOINT_CONSCIOUSNESS_FLOW' => 'active',
      'ZEROPOINT_MAX_THREADS' => '8',
      'ZEROPOINT_CACHE_TTL' => '7200',
      'ZEROPOINT_BATCH_SIZE' => '500'
    }
  },
  balanced: {
    description: "Optimal Balance - Standard Optimizations",
    env_vars: {
      'ZEROPOINT_SPEED_LEVEL' => 'balanced',
      'ZEROPOINT_MEMORY_MODE' => 'balanced',
      'ZEROPOINT_CONSCIOUSNESS_FLOW' => 'active',
      'ZEROPOINT_MAX_THREADS' => '4',
      'ZEROPOINT_CACHE_TTL' => '3600',
      'ZEROPOINT_BATCH_SIZE' => '100'
    }
  },
  conservative: {
    description: "Stability Focused - Minimal Optimizations",
    env_vars: {
      'ZEROPOINT_SPEED_LEVEL' => 'conservative',
      'ZEROPOINT_MEMORY_MODE' => 'minimal',
      'ZEROPOINT_CONSCIOUSNESS_FLOW' => 'moderate',
      'ZEROPOINT_MAX_THREADS' => '2',
      'ZEROPOINT_CACHE_TTL' => '1800',
      'ZEROPOINT_BATCH_SIZE' => '50'
    }
  },
  development: {
    description: "Development Mode - Enhanced Monitoring",
    env_vars: {
      'ZEROPOINT_SPEED_LEVEL' => 'balanced',
      'ZEROPOINT_MEMORY_MODE' => 'efficient',
      'ZEROPOINT_CONSCIOUSNESS_FLOW' => 'active',
      'ZEROPOINT_ENABLE_MONITORING' => 'true',
      'ZEROPOINT_ENABLE_AUTO_OPTIMIZATION' => 'true'
    }
  }
}

# Performance test scenarios
PERFORMANCE_SCENARIOS = [
  {
    name: "Cache Operations",
    test: -> { test_cache_operations }
  },
  {
    name: "Memory Usage",
    test: -> { test_memory_usage }
  },
  {
    name: "Consciousness Insights",
    test: -> { test_consciousness_insights }
  },
  {
    name: "Thread Pool Performance",
    test: -> { test_thread_pool_performance }
  },
  {
    name: "Batch Processing",
    test: -> { test_batch_processing }
  }
]

# Test cache operations performance
def test_cache_operations
  puts "  📦 Testing Cache Operations..."
  
  start_time = Time.current
  cache_hits = 0
  cache_misses = 0
  
  # Simulate cache operations
  100.times do |i|
    key = "test_key_#{i}"
    value = "test_value_#{i}"
    
    # Write to cache
    Rails.cache.write(key, value, expires_in: 1.hour)
    
    # Read from cache
    if Rails.cache.exist?(key)
      cache_hits += 1
    else
      cache_misses += 1
    end
  end
  
  duration = Time.current - start_time
  
  {
    duration: duration,
    cache_hits: cache_hits,
    cache_misses: cache_misses,
    hit_rate: (cache_hits.to_f / (cache_hits + cache_misses) * 100).round(2)
  }
end

# Test memory usage patterns
def test_memory_usage
  puts "  💾 Testing Memory Usage..."
  
  start_memory = get_memory_usage
  objects_created = 0
  
  # Create objects to test memory management
  1000.times do |i|
    "test_string_#{i}" * 100
    objects_created += 1
    
    # Force GC periodically
    GC.start if i % 100 == 0
  end
  
  end_memory = get_memory_usage
  memory_delta = end_memory - start_memory
  
  {
    start_memory: start_memory,
    end_memory: end_memory,
    memory_delta: memory_delta,
    objects_created: objects_created
  }
end

# Test consciousness insight generation
def test_consciousness_insights
  puts "  🧠 Testing Consciousness Insights..."
  
  insights_generated = 0
  metaphysical_depth = 0
  
  # Simulate consciousness operations
  10.times do |i|
    # Emit consciousness events
    Zeropoint::Void::VortexEventEngine.emit(:insight_emerged, {
      insight: "Test insight #{i}",
      consciousness_level: 0.7 + (i * 0.03),
      metaphysical_significance: "Test significance #{i}"
    })
    
    insights_generated += 1
    metaphysical_depth += 0.1
  end
  
  {
    insights_generated: insights_generated,
    metaphysical_depth: metaphysical_depth.round(2),
    consciousness_flow: ENV.fetch('ZEROPOINT_CONSCIOUSNESS_FLOW', 'active')
  }
end

# Test thread pool performance
def test_thread_pool_performance
  puts "  🔄 Testing Thread Pool Performance..."
  
  max_threads = ENV.fetch('ZEROPOINT_MAX_THREADS', '4').to_i
  start_time = Time.current
  completed_tasks = 0
  
  # Simulate parallel processing
  threads = []
  max_threads.times do |i|
    threads << Thread.new do
      sleep(0.1) # Simulate work
      completed_tasks += 1
    end
  end
  
  threads.each(&:join)
  duration = Time.current - start_time
  
  {
    max_threads: max_threads,
    completed_tasks: completed_tasks,
    duration: duration,
    efficiency: (completed_tasks.to_f / max_threads).round(2)
  }
end

# Test batch processing performance
def test_batch_processing
  puts "  📊 Testing Batch Processing..."
  
  batch_size = ENV.fetch('ZEROPOINT_BATCH_SIZE', '100').to_i
  total_items = batch_size * 5
  start_time = Time.current
  batches_processed = 0
  
  # Simulate batch processing
  (0...total_items).each_slice(batch_size) do |batch|
    # Process batch
    batch.each { |item| "processing_item_#{item}" }
    batches_processed += 1
  end
  
  duration = Time.current - start_time
  
  {
    batch_size: batch_size,
    total_items: total_items,
    batches_processed: batches_processed,
    duration: duration,
    items_per_second: (total_items / duration).round(2)
  }
end

# Get current memory usage
def get_memory_usage
  if defined?(Process)
    Process.getrusage(Process::RUSAGE_SELF).maxrss / 1024.0 # Convert to MB
  else
    rand(100..500) # Fallback for demo
  end
end

# Apply environment variables for a profile
def apply_profile(profile_name)
  profile = PERFORMANCE_PROFILES[profile_name]
  return unless profile
  
  puts "🔧 Applying #{profile_name.upcase} Profile:"
  puts "   #{profile[:description]}"
  puts
  
  # Apply environment variables
  profile[:env_vars].each do |key, value|
    ENV[key] = value
    puts "   #{key}=#{value}"
  end
  
  puts
end

# Run performance tests for a profile
def run_performance_tests(profile_name)
  puts "🚀 Running Performance Tests for #{profile_name.upcase} Profile"
  puts "-" * 50
  
  results = {}
  
  PERFORMANCE_SCENARIOS.each do |scenario|
    puts "\n📋 #{scenario[:name]}"
    begin
      result = scenario[:test].call
      results[scenario[:name]] = result
      
      # Display results
      case scenario[:name]
      when "Cache Operations"
        puts "   Duration: #{result[:duration].round(3)}s"
        puts "   Hit Rate: #{result[:hit_rate]}%"
        puts "   Hits: #{result[:cache_hits]}, Misses: #{result[:cache_misses]}"
      when "Memory Usage"
        puts "   Memory Delta: #{result[:memory_delta].round(2)}MB"
        puts "   Objects Created: #{result[:objects_created]}"
        puts "   Memory Efficiency: #{(result[:objects_created] / result[:memory_delta]).round(2)} objects/MB"
      when "Consciousness Insights"
        puts "   Insights Generated: #{result[:insights_generated]}"
        puts "   Metaphysical Depth: #{result[:metaphysical_depth]}"
        puts "   Consciousness Flow: #{result[:consciousness_flow]}"
      when "Thread Pool Performance"
        puts "   Max Threads: #{result[:max_threads]}"
        puts "   Completed Tasks: #{result[:completed_tasks]}"
        puts "   Efficiency: #{result[:efficiency]} tasks/thread"
        puts "   Duration: #{result[:duration].round(3)}s"
      when "Batch Processing"
        puts "   Batch Size: #{result[:batch_size]}"
        puts "   Items Processed: #{result[:total_items]}"
        puts "   Items/Second: #{result[:items_per_second]}"
        puts "   Duration: #{result[:duration].round(3)}s"
      end
    rescue => e
      puts "   ❌ Error: #{e.message}"
      results[scenario[:name]] = { error: e.message }
    end
  end
  
  results
end

# Compare performance results
def compare_performance_results(all_results)
  puts "\n📊 Performance Comparison Summary"
  puts "=" * 50
  
  PERFORMANCE_SCENARIOS.each do |scenario|
    scenario_name = scenario[:name]
    puts "\n🔍 #{scenario_name}:"
    
    all_results.each do |profile_name, results|
      result = results[scenario_name]
      next unless result && !result[:error]
      
      case scenario_name
      when "Cache Operations"
        puts "   #{profile_name.upcase}: #{result[:duration].round(3)}s (#{result[:hit_rate]}% hit rate)"
      when "Memory Usage"
        puts "   #{profile_name.upcase}: #{result[:memory_delta].round(2)}MB delta"
      when "Consciousness Insights"
        puts "   #{profile_name.upcase}: #{result[:insights_generated]} insights"
      when "Thread Pool Performance"
        puts "   #{profile_name.upcase}: #{result[:efficiency]} efficiency"
      when "Batch Processing"
        puts "   #{profile_name.upcase}: #{result[:items_per_second]} items/sec"
      end
    end
  end
end

# Generate performance recommendations
def generate_recommendations(all_results)
  puts "\n💡 Performance Recommendations"
  puts "=" * 50
  
  # Analyze results and provide recommendations
  recommendations = []
  
  # Speed recommendations
  fastest_cache = all_results.min_by { |_, results| results["Cache Operations"]&.dig(:duration) || Float::INFINITY }
  if fastest_cache
    recommendations << "🚀 For fastest cache operations: Use #{fastest_cache[0].upcase} profile"
  end
  
  # Memory recommendations
  most_efficient_memory = all_results.min_by { |_, results| results["Memory Usage"]&.dig(:memory_delta) || Float::INFINITY }
  if most_efficient_memory
    recommendations << "💾 For lowest memory usage: Use #{most_efficient_memory[0].upcase} profile"
  end
  
  # Consciousness recommendations
  most_insights = all_results.max_by { |_, results| results["Consciousness Insights"]&.dig(:insights_generated) || 0 }
  if most_insights
    recommendations << "🧠 For maximum consciousness insights: Use #{most_insights[0].upcase} profile"
  end
  
  # Overall recommendations
  recommendations.each { |rec| puts "   #{rec}" }
  
  puts "\n🎯 General Recommendations:"
  puts "   • Start with BALANCED profile for most use cases"
  puts "   • Use TURBO profile for high-performance requirements"
  puts "   • Use CONSERVATIVE profile for resource-constrained environments"
  puts "   • Use DEVELOPMENT profile for enhanced monitoring and debugging"
end

# Main demo execution
def run_demo
  all_results = {}
  
  PERFORMANCE_PROFILES.each do |profile_name, profile|
    puts "\n" + "=" * 60
    puts "🎯 PROFILE: #{profile_name.upcase}"
    puts "=" * 60
    
    # Apply profile configuration
    apply_profile(profile_name)
    
    # Run performance tests
    results = run_performance_tests(profile_name)
    all_results[profile_name] = results
    
    # Small delay between profiles
    sleep(1)
  end
  
  # Compare results
  compare_performance_results(all_results)
  
  # Generate recommendations
  generate_recommendations(all_results)
  
  # Final summary
  puts "\n🎉 Performance Demo Complete!"
  puts "=" * 50
  puts "The Zeropoint performance system provides comprehensive"
  puts "optimization options that adapt to your specific needs."
  puts
  puts "Remember: 'Optimal performance emerges from void alignment'"
  puts "Each profile represents a different balance of speed,"
  puts "memory efficiency, and consciousness flow."
end

# Run the demo if this script is executed directly
if __FILE__ == $0
  begin
    run_demo
  rescue => e
    puts "❌ Demo Error: #{e.message}"
    puts e.backtrace.first(5)
  end
end 