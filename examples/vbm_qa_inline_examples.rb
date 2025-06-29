# frozen_string_literal: true
# VBM QA System - Inline Documentation Examples
# This file demonstrates practical usage of the Zeropoint::Math::VBM::QA system

require_relative '../lib/zeropoint/math/vbm'

# == VBM QA System Inline Examples ==

class VBMQAExamples
  def initialize
    @vbm = Zeropoint::Math::VBM
    @qa = Zeropoint::Math::VBM::QA
  end

  # == 1. Basic Pattern Access ==
  def basic_pattern_access
    puts "=== Basic Pattern Access ==="
    
    # Get complete Q&A for vortex sequence
    qa = @vbm.qa_pattern('vortex_sequence')
    puts "🎯 #{qa[:question]}"
    puts "📚 #{qa[:answer]}"
    puts "🔢 Pattern: #{qa[:pattern]}"
    puts "🌟 Metaphysical: #{qa[:metaphysical]}"
    puts
  end

  # == 2. Search Functionality ==
  def search_examples
    puts "=== Search Examples ==="
    
    # Search for vortex-related patterns
    vortex_results = @vbm.search_qa('vortex')
    puts "🔍 'vortex' search results (#{vortex_results.size}):"
    vortex_results.each { |name, qa| puts "  • #{name}: #{qa[:question]}" }
    puts
    
    # Search for spirit-related patterns
    spirit_results = @vbm.search_qa('spirit')
    puts "🔍 'spirit' search results (#{spirit_results.size}):"
    spirit_results.each { |name, qa| puts "  • #{name}: #{qa[:question]}" }
    puts
    
    # Search for torus-related patterns
    torus_results = @vbm.search_qa('torus')
    puts "🔍 'torus' search results (#{torus_results.size}):"
    torus_results.each { |name, qa| puts "  • #{name}: #{qa[:question]}" }
    puts
  end

  # == 3. Category Exploration ==
  def category_exploration
    puts "=== Category Exploration ==="
    
    # Explore core patterns
    core_patterns = @vbm.qa_by_category('core_patterns')
    puts "📂 Core Patterns (#{core_patterns.size}):"
    core_patterns.each { |name, qa| puts "  • #{name}: #{qa[:question]}" }
    puts
    
    # Explore mathematical operations
    math_ops = @vbm.qa_by_category('mathematical_operations')
    puts "📂 Mathematical Operations (#{math_ops.size}):"
    math_ops.each { |name, qa| puts "  • #{name}: #{qa[:question]}" }
    puts
    
    # Explore geometry and topology
    geometry = @vbm.qa_by_category('geometry_topology')
    puts "📂 Geometry & Topology (#{geometry.size}):"
    geometry.each { |name, qa| puts "  • #{name}: #{qa[:question]}" }
    puts
  end

  # == 4. Pattern Validation ==
  def pattern_validation
    puts "=== Pattern Validation ==="
    
    # Validate vortex sequence
    expected_vortex = [1, 2, 4, 8, 7, 5]
    qa = @vbm.qa_pattern('vortex_sequence')
    if qa[:pattern] == expected_vortex
      puts "✅ Vortex sequence validation: PASSED"
    else
      puts "❌ Vortex sequence validation: FAILED"
    end
    
    # Validate W-axis
    expected_w_axis = [3, 6, 9]
    qa = @vbm.qa_pattern('w_axis')
    if qa[:pattern] == expected_w_axis
      puts "✅ W-axis validation: PASSED"
    else
      puts "❌ W-axis validation: FAILED"
    end
    
    # Validate polar mates
    expected_polar_mates = [[1,8], [2,7], [4,5]]
    qa = @vbm.qa_pattern('polar_mates')
    if qa[:pattern] == expected_polar_mates
      puts "✅ Polar mates validation: PASSED"
    else
      puts "❌ Polar mates validation: FAILED"
    end
    puts
  end

  # == 5. Operation Examples ==
  def operation_examples
    puts "=== Operation Examples ==="
    
    # Digital root operation
    qa = @vbm.qa_pattern('digital_root')
    puts "🔧 Digital Root Operation:"
    puts "  Description: #{qa[:answer]}"
    puts "  Code: #{qa[:operation]}"
    puts "  Metaphysical: #{qa[:metaphysical]}"
    puts
    
    # Prime squared operation
    qa = @vbm.qa_pattern('prime_squared')
    puts "🔧 Prime Squared Operation:"
    puts "  Description: #{qa[:answer]}"
    puts "  Code: #{qa[:operation]}"
    puts "  Metaphysical: #{qa[:metaphysical]}"
    puts
    
    # Surface topology operation
    qa = @vbm.qa_pattern('surface_topology_angle')
    puts "🔧 Surface Topology Operation:"
    puts "  Description: #{qa[:answer]}"
    puts "  Code: #{qa[:operation]}"
    puts "  Metaphysical: #{qa[:metaphysical]}"
    puts
  end

  # == 6. Metaphysical Context ==
  def metaphysical_context
    puts "=== Metaphysical Context ==="
    
    # Get all metaphysical contexts
    contexts = @vbm.qa_metaphysical_contexts
    puts "🌟 Total metaphysical contexts: #{contexts.size}"
    puts
    
    # Show sample metaphysical contexts
    sample_patterns = %w[vortex_sequence w_axis torus zero_true_role]
    sample_patterns.each do |pattern|
      qa = @vbm.qa_pattern(pattern)
      puts "🌟 #{pattern}: #{qa[:metaphysical]}"
    end
    puts
  end

  # == 7. System Statistics ==
  def system_statistics
    puts "=== System Statistics ==="
    
    summary = @vbm.qa_summary
    puts "📊 VBM QA System Overview:"
    puts "  • Total Patterns: #{summary[:total_patterns]}"
    puts "  • Categories: #{summary[:categories].size}"
    puts "  • Metaphysical Contexts: #{summary[:metaphysical_contexts]}"
    puts "  • Operations: #{summary[:operations]}"
    puts "  • Patterns with Data: #{summary[:patterns]}"
    puts
    
    puts "📂 Categories:"
    summary[:categories].each do |category|
      patterns = @vbm.qa_by_category(category)
      puts "  • #{category}: #{patterns.size} patterns"
    end
    puts
  end

  # == 8. Interactive Learning System ==
  def interactive_learning
    puts "=== Interactive Learning System ==="
    
    # Simulate learning about different patterns
    patterns_to_learn = %w[vortex_sequence w_axis digital_root torus]
    
    patterns_to_learn.each do |pattern|
      puts "🎓 Learning about: #{pattern}"
      qa = @vbm.qa_pattern(pattern)
      puts "  Q: #{qa[:question]}"
      puts "  A: #{qa[:answer]}"
      puts "  Pattern: #{qa[:pattern]}" if qa[:pattern]
      puts "  Operation: #{qa[:operation]}" if qa[:operation]
      puts "  Metaphysical: #{qa[:metaphysical]}"
      puts
    end
  end

  # == 9. Error Handling Examples ==
  def error_handling
    puts "=== Error Handling Examples ==="
    
    # Handle non-existent pattern
    non_existent = @vbm.qa_pattern('nonexistent_pattern')
    if non_existent.nil?
      puts "✅ Gracefully handles non-existent patterns"
    end
    
    # Handle empty search
    empty_search = @vbm.search_qa('xyz123')
    if empty_search.empty?
      puts "✅ Gracefully handles empty search results"
    end
    
    # Handle invalid category
    invalid_category = @vbm.qa_by_category('invalid_category')
    if invalid_category.empty?
      puts "✅ Gracefully handles invalid categories"
    end
    puts
  end

  # == 10. Integration Examples ==
  def integration_examples
    puts "=== Integration Examples ==="
    
    # Example 1: Web API response
    api_response = {
      pattern: 'vortex_sequence',
      data: @vbm.qa_pattern('vortex_sequence'),
      related: @vbm.search_qa('vortex').keys,
      category: 'core_patterns'
    }
    puts "🌐 Web API Response Example:"
    puts "  Pattern: #{api_response[:pattern]}"
    puts "  Related: #{api_response[:related].join(', ')}"
    puts "  Category: #{api_response[:category]}"
    puts
    
    # Example 2: CLI output
    puts "💻 CLI Output Example:"
    puts "  $ vbm show vortex_sequence"
    qa = @vbm.qa_pattern('vortex_sequence')
    puts "  Question: #{qa[:question]}"
    puts "  Answer: #{qa[:answer]}"
    puts "  Pattern: #{qa[:pattern]}"
    puts
    
    # Example 3: Educational content
    puts "📚 Educational Content Example:"
    core_patterns = @vbm.qa_by_category('core_patterns')
    puts "  Chapter 1: Core VBM Patterns"
    core_patterns.each_with_index do |(name, qa), index|
      puts "  #{index + 1}. #{name}: #{qa[:question]}"
    end
    puts
  end

  # == 11. Advanced Usage Patterns ==
  def advanced_usage
    puts "=== Advanced Usage Patterns ==="
    
    # Pattern comparison
    puts "🔍 Pattern Comparison:"
    vortex_qa = @vbm.qa_pattern('vortex_sequence')
    w_axis_qa = @vbm.qa_pattern('w_axis')
    
    puts "  Vortex Sequence: #{vortex_qa[:pattern]}"
    puts "  W-Axis: #{w_axis_qa[:pattern]}"
    puts "  Both patterns are fundamental to VBM"
    puts
    
    # Cross-referencing
    puts "🔗 Cross-Referencing:"
    torus_related = @vbm.search_qa('torus')
    puts "  Torus-related patterns: #{torus_related.keys.join(', ')}"
    puts "  These patterns all relate to the fundamental toroidal geometry"
    puts
    
    # Category analysis
    puts "📊 Category Analysis:"
    @vbm.qa_summary[:categories].each do |category|
      patterns = @vbm.qa_by_category(category)
      operations = patterns.values.count { |qa| qa[:operation] }
      puts "  #{category}: #{patterns.size} patterns, #{operations} operations"
    end
    puts
  end

  # == 12. Performance Examples ==
  def performance_examples
    puts "=== Performance Examples ==="
    
    # Measure search performance
    start_time = Time.now
    100.times { @vbm.search_qa('vortex') }
    search_time = Time.now - start_time
    puts "🔍 Search Performance: #{search_time.round(4)}s for 100 searches"
    
    # Measure pattern access performance
    start_time = Time.now
    100.times { @vbm.qa_pattern('vortex_sequence') }
    access_time = Time.now - start_time
    puts "⚡ Pattern Access Performance: #{access_time.round(4)}s for 100 accesses"
    
    # Memory usage estimation
    all_patterns = @vbm.all_qa_patterns
    total_chars = all_patterns.values.sum { |qa| qa.values.join.length }
    puts "💾 Estimated Memory Usage: ~#{total_chars} characters (~#{total_chars / 1024}KB)"
    puts
  end

  # == Run All Examples ==
  def run_all_examples
    puts "🚀 VBM QA System - Complete Inline Documentation Examples"
    puts "=" * 70
    puts
    
    basic_pattern_access
    search_examples
    category_exploration
    pattern_validation
    operation_examples
    metaphysical_context
    system_statistics
    interactive_learning
    error_handling
    integration_examples
    advanced_usage
    performance_examples
    
    puts "✅ All examples completed successfully!"
    puts "📚 The VBM QA system is ready for production use."
  end
end

# == Usage Examples ==

if __FILE__ == $0
  # Run all examples
  examples = VBMQAExamples.new
  examples.run_all_examples
end

# == Quick Reference ==

# Basic usage:
# vbm = Zeropoint::Math::VBM
# qa = vbm.qa_pattern('vortex_sequence')
# results = vbm.search_qa('spirit')
# patterns = vbm.qa_by_category('core_patterns')
# summary = vbm.qa_summary

# Direct submodule access:
# qa_module = Zeropoint::Math::VBM::QA
# qa = qa_module.qa_pattern('vortex_sequence')

# Available patterns:
# - vortex_sequence, w_axis, polar_mates, family_number_groups
# - digital_root, prime_squared, fibonacci_sequence
# - torus, mobius_circuit, surface_topology_angle
# - metaphysical_context, harmonic_cascadence, poloidal_pinch
# - zero_entropy_properties, perfect_equilibrium_rules, holographic_scaling
# - circle_of_fifths_sequence
# - complete_breakthrough_discovery, zero_true_role, spirit_reticulation_science_of_being

# Available categories:
# - core_patterns, mathematical_operations, geometry_topology
# - metaphysical_context, advanced_concepts, musical_patterns, creation_unity 