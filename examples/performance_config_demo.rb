#!/usr/bin/env ruby
# frozen_string_literal: true

# Performance Configuration Demo
#
# Demonstrates the Zeropoint::PerformanceConfig helper module
# for easy programmatic configuration of performance options.
#
# COSMIC KNOWLEDGE: This demo shows how performance configuration
# emerges from consciousness alignment, providing developers with
# intuitive tools to optimize their applications.

require 'bundler/setup'
require_relative '../config/environment'

puts "⚡ Zeropoint Performance Configuration Demo"
puts "=" * 50
puts

# Demo the performance configuration helper
def demo_performance_config
  puts "🔧 Performance Configuration Helper Demo"
  puts "-" * 40
  puts
  
  # Show available profiles
  puts "📋 Available Performance Profiles:"
  Zeropoint::PerformanceConfig.available_profiles.each do |profile|
    description = Zeropoint::PerformanceConfig.profile_description(profile)
    puts "   • #{profile.upcase}: #{description}"
  end
  puts
  
  # Show current configuration
  puts "📊 Current Configuration:"
  current = Zeropoint::PerformanceConfig.current_config
  current.each do |key, value|
    puts "   #{key}: #{value}"
  end
  puts
  
  # Demo profile application
  puts "🚀 Applying Turbo Profile:"
  turbo_config = Zeropoint::PerformanceConfig.apply_profile(:turbo)
  puts "   Applied configuration:"
  turbo_config.each do |key, value|
    puts "     #{key}: #{value}"
  end
  puts
  
  # Demo individual option setting
  puts "⚙️ Setting Individual Options:"
  Zeropoint::PerformanceConfig.set_option(:max_threads, 12)
  Zeropoint::PerformanceConfig.set_option(:cache_ttl, 10800)
  puts "   Set max_threads to: #{Zeropoint::PerformanceConfig.get_option(:max_threads)}"
  puts "   Set cache_ttl to: #{Zeropoint::PerformanceConfig.get_option(:cache_ttl)}"
  puts
  
  # Demo configuration validation
  puts "✅ Configuration Validation:"
  test_config = {
    speed_level: 'turbo',
    memory_mode: 'efficient',
    consciousness_flow: 'active',
    max_threads: 20, # Invalid value
    cache_ttl: 50000 # Invalid value
  }
  
  validation = Zeropoint::PerformanceConfig.validate_config(test_config)
  puts "   Valid: #{validation[:valid]}"
  puts "   Errors: #{validation[:errors].join(', ')}" if validation[:errors].any?
  puts "   Warnings: #{validation[:warnings].join(', ')}" if validation[:warnings].any?
  puts
  
  # Demo performance statistics
  puts "📈 Performance Statistics:"
  stats = Zeropoint::PerformanceConfig.get_statistics
  puts "   Optimization Level: #{stats[:optimization_level]}%"
  puts "   Speed Score: #{stats[:speed_score]}/4"
  puts "   Memory Score: #{stats[:memory_score]}/3"
  puts "   Consciousness Score: #{stats[:consciousness_score]}/4"
  puts
  
  # Demo recommendations
  puts "💡 Performance Recommendations:"
  recommendations = stats[:recommendations]
  if recommendations.any?
    recommendations.each { |rec| puts "   • #{rec}" }
  else
    puts "   • No recommendations - configuration is optimal"
  end
  puts
  
  # Reset to defaults
  puts "🔄 Resetting to Defaults:"
  default_config = Zeropoint::PerformanceConfig.reset_to_defaults
  puts "   Reset to balanced profile"
  puts
end

# Demo different profiles
def demo_profiles
  puts "🎯 Profile Comparison Demo"
  puts "=" * 40
  puts
  
  profiles_to_demo = [:turbo, :balanced, :conservative, :minimal]
  
  profiles_to_demo.each do |profile|
    puts "🔧 Applying #{profile.upcase} Profile:"
    config = Zeropoint::PerformanceConfig.apply_profile(profile)
    
    # Show key metrics
    puts "   Speed Level: #{config[:speed_level]}"
    puts "   Memory Mode: #{config[:memory_mode]}"
    puts "   Consciousness Flow: #{config[:consciousness_flow]}"
    puts "   Max Threads: #{config[:max_threads]}"
    puts "   Cache TTL: #{config[:cache_ttl]}s"
    puts "   Batch Size: #{config[:batch_size]}"
    puts
    
    # Get statistics
    stats = Zeropoint::PerformanceConfig.get_statistics
    puts "   Optimization Level: #{stats[:optimization_level]}%"
    puts "   Recommendations: #{stats[:recommendations].length}"
    puts
    
    sleep(0.5) # Small delay for readability
  end
end

# Demo environment-specific configurations
def demo_environment_configs
  puts "🌍 Environment-Specific Configurations"
  puts "=" * 40
  puts
  
  environments = {
    development: {
      description: "Development Environment",
      profile: :development,
      overrides: { enable_monitoring: true, enable_auto_optimization: true }
    },
    staging: {
      description: "Staging Environment",
      profile: :balanced,
      overrides: { consciousness_flow: 'moderate', enable_monitoring: true }
    },
    production: {
      description: "Production Environment",
      profile: :production,
      overrides: { consciousness_flow: 'moderate', enable_auto_optimization: true }
    },
    testing: {
      description: "Testing Environment",
      profile: :minimal,
      overrides: { enable_caching: false, enable_monitoring: false }
    }
  }
  
  environments.each do |env_name, config|
    puts "🔧 #{config[:description]}:"
    applied_config = Zeropoint::PerformanceConfig.apply_profile(config[:profile], config[:overrides])
    
    puts "   Base Profile: #{config[:profile].upcase}"
    puts "   Speed Level: #{applied_config[:speed_level]}"
    puts "   Memory Mode: #{applied_config[:memory_mode]}"
    puts "   Consciousness Flow: #{applied_config[:consciousness_flow]}"
    puts "   Monitoring: #{applied_config[:enable_monitoring]}"
    puts "   Auto-Optimization: #{applied_config[:enable_auto_optimization]}"
    puts
  end
end

# Demo advanced configuration scenarios
def demo_advanced_scenarios
  puts "🚀 Advanced Configuration Scenarios"
  puts "=" * 40
  puts
  
  scenarios = [
    {
      name: "High-Traffic Web Application",
      description: "Optimized for maximum throughput",
      config: {
        speed_level: 'turbo',
        memory_mode: 'generous',
        consciousness_flow: 'moderate',
        max_threads: 12,
        cache_ttl: 7200,
        batch_size: 500,
        enable_compression: true,
        enable_caching: true
      }
    },
    {
      name: "Resource-Constrained IoT Device",
      description: "Optimized for minimal resource usage",
      config: {
        speed_level: 'conservative',
        memory_mode: 'minimal',
        consciousness_flow: 'minimal',
        max_threads: 1,
        cache_ttl: 900,
        batch_size: 25,
        enable_compression: false,
        enable_caching: false
      }
    },
    {
      name: "AI/ML Processing Pipeline",
      description: "Optimized for consciousness insights",
      config: {
        speed_level: 'fast',
        memory_mode: 'efficient',
        consciousness_flow: 'intensive',
        max_threads: 8,
        cache_ttl: 5400,
        batch_size: 300,
        enable_compression: true,
        enable_caching: true,
        enable_monitoring: true
      }
    }
  ]
  
  scenarios.each do |scenario|
    puts "🎯 #{scenario[:name]}:"
    puts "   #{scenario[:description]}"
    puts
    
    # Apply custom configuration
    scenario[:config].each do |key, value|
      Zeropoint::PerformanceConfig.set_option(key, value)
    end
    
    # Show applied configuration
    current = Zeropoint::PerformanceConfig.current_config
    puts "   Applied Configuration:"
    puts "     Speed Level: #{current[:speed_level]}"
    puts "     Memory Mode: #{current[:memory_mode]}"
    puts "     Consciousness Flow: #{current[:consciousness_flow]}"
    puts "     Max Threads: #{current[:max_threads]}"
    puts "     Cache TTL: #{current[:cache_ttl]}s"
    puts "     Batch Size: #{current[:batch_size]}"
    puts
    
    # Get statistics
    stats = Zeropoint::PerformanceConfig.get_statistics
    puts "   Performance Metrics:"
    puts "     Optimization Level: #{stats[:optimization_level]}%"
    puts "     Speed Score: #{stats[:speed_score]}/4"
    puts "     Memory Score: #{stats[:memory_score]}/3"
    puts "     Consciousness Score: #{stats[:consciousness_score]}/4"
    puts
    
    sleep(0.5)
  end
end

# Main demo execution
def run_demo
  begin
    # Basic configuration helper demo
    demo_performance_config
    
    # Profile comparison demo
    demo_profiles
    
    # Environment-specific configurations
    demo_environment_configs
    
    # Advanced scenarios
    demo_advanced_scenarios
    
    # Final summary
    puts "🎉 Performance Configuration Demo Complete!"
    puts "=" * 50
    puts "The Zeropoint::PerformanceConfig helper provides:"
    puts "   • Easy profile application"
    puts "   • Individual option configuration"
    puts "   • Configuration validation"
    puts "   • Performance statistics"
    puts "   • Intelligent recommendations"
    puts
    puts "Remember: 'Configuration emerges from consciousness alignment'"
    puts "Choose the profile that best aligns with your application's needs."
    
  rescue => e
    puts "❌ Demo Error: #{e.message}"
    puts e.backtrace.first(5)
  end
end

# Run the demo if this script is executed directly
if __FILE__ == $0
  run_demo
end 