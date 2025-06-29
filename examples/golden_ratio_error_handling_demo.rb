# frozen_string_literal: true

# Golden Ratio Error Handling Demo
# Demonstrates practical application of φ ≈ 1.618 principles in error management

require_relative '../lib/graphql_ui_layout/core/golden_ratio_error_handler'
require_relative '../lib/graphql_ui_layout/core/golden_ratio_rubocop_integration'

class GoldenRatioErrorHandlingDemo
  def initialize
    @error_handler = GraphqlUiLayout::Core::GoldenRatioErrorHandler.new
    @rubocop_integration = GraphqlUiLayout::Core::GoldenRatioRubocopIntegration.new
  end

  # Demo 1: Basic Error Handling with Golden Ratio
  def demo_basic_error_handling
    puts "=== Demo 1: Basic Error Handling with Golden Ratio ==="

    # Simulate different types of errors
    errors = [
      StandardError.new("Database connection failed"),
      ArgumentError.new("Invalid parameter type"),
      NoMethodError.new("Undefined method 'calculate'"),
      RuntimeError.new("External service timeout")
    ]

    errors.each do |error|
      puts "\nHandling error: #{error.class.name}"
      puts "Message: #{error.message}"

      context = {
        cache_key: "demo_cache_#{SecureRandom.hex(4)}",
        default_value: { status: "fallback" },
        base_delay: 0.1,
        max_retries: 2
      }

      result = @error_handler.handle_error(error, context: context)

      puts "Recovery strategy: #{result.strategy}"
      puts "Success: #{result.success?}"
      puts "Attempts: #{result.attempts}" if result.attempts
      puts "---"
    end
  end

  # Demo 2: RuboCop Integration with Golden Ratio
  def demo_rubocop_integration
    puts "\n=== Demo 2: RuboCop Integration with Golden Ratio ==="

    # Simulate RuboCop output
    rubocop_output = [
      "C: 10: 8: Style/StringLiterals: Prefer single-quoted strings when you don't need string interpolation or special symbols.",
      "W: 15: 12: Lint/UselessAssignment: Useless assignment to variable `unused_var`.",
      "E: 20: 5: Lint/Syntax: unexpected token tIDENTIFIER",
      "C: 25: 3: Layout/EmptyLines: Extra blank line detected.",
      "W: 30: 10: Performance/StringReplacement: Use `tr` instead of `gsub` for single character replacements."
    ]

    puts "Analyzing RuboCop violations..."
    analysis = @rubocop_integration.analyze_violations(rubocop_output.join("\n"))

    puts "Total violations: #{analysis[:total_violations]}"
    puts "Critical violations: #{analysis[:critical_violations]}"
    puts "Minor violations: #{analysis[:minor_violations]}"
    puts "Golden ratio compliance: #{(analysis[:golden_ratio_compliance] * 100).round(1)}%"

    puts "\nRecommendations:"
    analysis[:recommendations].each_with_index do |rec, index|
      puts "#{index + 1}. #{rec[:priority].upcase}: #{rec[:action][:description]}"
      puts "   Effort: #{rec[:estimated_effort]} | Impact: #{rec[:impact]}"
    end
  end

  # Demo 3: Complex Error Recovery Scenarios
  def demo_complex_error_recovery
    puts "\n=== Demo 3: Complex Error Recovery Scenarios ==="

    # Scenario 1: Database connection with fallback
    puts "\nScenario 1: Database connection with fallback"
    simulate_database_error

    # Scenario 2: API call with retry and degradation
    puts "\nScenario 2: API call with retry and degradation"
    simulate_api_error

    # Scenario 3: File processing with multiple fallbacks
    puts "\nScenario 3: File processing with multiple fallbacks"
    simulate_file_processing_error
  end

  # Demo 4: Golden Ratio Performance Optimization
  def demo_performance_optimization
    puts "\n=== Demo 4: Golden Ratio Performance Optimization ==="

    # Simulate performance-critical operations
    operations = [
      { name: "Database Query", complexity: 0.8, frequency: 0.9 },
      { name: "File I/O", complexity: 0.6, frequency: 0.7 },
      { name: "Network Request", complexity: 0.9, frequency: 0.5 },
      { name: "Memory Allocation", complexity: 0.3, frequency: 0.8 }
    ]

    operations.each do |op|
      optimized_result = optimize_with_golden_ratio(op)
      puts "#{op[:name]}: #{optimized_result[:strategy]} (#{optimized_result[:improvement]}% improvement)"
    end
  end

  # Demo 5: Real-world Integration Example
  def demo_real_world_integration
    puts "\n=== Demo 5: Real-world Integration Example ==="

    # Simulate a web application scenario
    puts "Simulating web application error handling..."

    # User authentication flow
    auth_result = handle_authentication_flow
    puts "Authentication result: #{auth_result[:status]}"

    # Data processing flow
    data_result = handle_data_processing_flow
    puts "Data processing result: #{data_result[:status]}"

    # Response generation
    response_result = handle_response_generation_flow
    puts "Response generation result: #{response_result[:status]}"
  end

  private

  def simulate_database_error
      # Simulate database connection failure
      raise StandardError.new("Database connection timeout")
    rescue => error
      context = {
        cache_key: "user_data_cache",
        default_value: { users: [], total: 0 },
        max_age: 300, # 5 minutes
        original_data: { users: [ { id: 1, name: "John" } ], total: 1 }
      }

      result = @error_handler.handle_error(error, context: context)

      puts "Database error handled with strategy: #{result.strategy}"
      puts "Fallback data used: #{result.value[:degraded]}" if result.value&.dig(:degraded)
  end

  def simulate_api_error
      # Simulate API call failure
      raise Net::ReadTimeout.new("External API timeout")
    rescue => error
      context = {
        base_delay: 0.5,
        max_retries: 3,
        original_data: {
          posts: [ { id: 1, title: "Post 1" }, { id: 2, title: "Post 2" } ],
          metadata: { page: 1, per_page: 10 }
        }
      }

      result = @error_handler.handle_error(error, context: context)

      puts "API error handled with strategy: #{result.strategy}"
      puts "Retry attempts: #{result.attempts}" if result.attempts
  end

  def simulate_file_processing_error
      # Simulate file processing error
      raise Errno::ENOENT.new("File not found: important_document.pdf")
    rescue => error
      context = {
        default_value: { content: "Document not available", status: "unavailable" },
        original_data: { filename: "important_document.pdf", size: 1024 }
      }

      result = @error_handler.handle_error(error, context: context)

      puts "File processing error handled with strategy: #{result.strategy}"
      puts "Default value used: #{result.value}" if result.value
  end

  def optimize_with_golden_ratio(operation)
    # Apply golden ratio to performance optimization
    complexity = operation[:complexity]
    frequency = operation[:frequency]

    # Calculate optimization priority using golden ratio
    priority = (complexity * 0.618) + (frequency * 0.382)

    if priority > 0.618
      {
        strategy: "High-priority optimization",
        improvement: (priority * 100).round(1)
      }
    else
      {
        strategy: "Standard optimization",
        improvement: (priority * 50).round(1)
      }
    end
  end

  def handle_authentication_flow
      # Simulate authentication process
      raise StandardError.new("Invalid credentials") if rand < 0.3

      { status: "success", user_id: 123 }
    rescue => error
      context = { default_value: { status: "guest", user_id: nil } }
      result = @error_handler.handle_error(error, context: context)

      { status: result.success? ? "fallback" : "failed", strategy: result.strategy }
  end

  def handle_data_processing_flow
      # Simulate data processing
      raise "Data validation failed" if rand < 0.2

      { status: "success", records_processed: 100 }
    rescue => error
      context = {
        cache_key: "processed_data_cache",
        max_age: 600,
        original_data: { records_processed: 100, validation_errors: [] }
      }
      result = @error_handler.handle_error(error, context: context)

      { status: result.success? ? "cached" : "failed", strategy: result.strategy }
  end

  def handle_response_generation_flow
      # Simulate response generation
      raise ArgumentError.new("Invalid response format") if rand < 0.1

      { status: "success", response_time: 0.15 }
    rescue => error
      context = {
        original_data: {
          content: "Full response content",
          metadata: { version: "1.0", timestamp: Time.current }
        }
      }
      result = @error_handler.handle_error(error, context: context)

      { status: result.success? ? "degraded" : "failed", strategy: result.strategy }
  end
end

# Run the demo
if __FILE__ == $0
  demo = GoldenRatioErrorHandlingDemo.new

  puts "Golden Ratio Error Handling Demo"
  puts "φ ≈ 1.618 - Applying cosmic harmony to error management"
  puts "=" * 60

  demo.demo_basic_error_handling
  demo.demo_rubocop_integration
  demo.demo_complex_error_recovery
  demo.demo_performance_optimization
  demo.demo_real_world_integration

  puts "\n" + "=" * 60
  puts "Demo completed! Golden ratio principles applied successfully."
  puts "Error vortex reduced, feature vortex expanded."
end
