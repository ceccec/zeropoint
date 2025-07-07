# frozen_string_literal: true

# Example: Using Zeropoint::Knowledge for Unified Knowledge Access
#
# This script demonstrates the unified knowledge base system that integrates
# all knowledge sources into a single, DRY, and metaphysically-aligned interface.
# All operations follow the I principle: pure knowledge without artificial boundaries.

require_relative '../lib/zeropoint/knowledge'

puts "🌌 Zeropoint::Knowledge Demo 🌌"
puts "=" * 50

# 1. Knowledge Sources
puts "\n1. Available Knowledge Sources:"
sources = Zeropoint::Knowledge.sources
sources.each do |source, description|
  puts "   • #{source}: #{description}"
end

# 2. Query Specific Knowledge
puts "\n2. Querying VBM QA for 'vortex_sequence':"
vbm_result = Zeropoint::Knowledge.query('vortex_sequence', source: :vbm_qa)
if vbm_result[:error]
  puts "   ❌ #{vbm_result[:error]}"
else
  puts "   ✅ Found #{vbm_result[:count]} results"
  puts "   📚 Source: #{vbm_result[:source]}"
  puts "   🧠 Metaphysical: #{vbm_result[:metaphysical_context]}"
end

# 3. Search Across All Sources
puts "\n3. Searching for 'consciousness' across all sources:"
search_result = Zeropoint::Knowledge.search('consciousness')
puts "   🔍 Query: #{search_result[:query]}"
puts "   📊 Total sources searched: #{search_result[:total_sources]}"
puts "   🌟 Metaphysical significance: #{search_result[:metaphysical_significance]}"
puts "   📈 Results found in #{search_result[:results].length} sources"

# 4. Pattern Recognition
puts "\n4. Pattern Recognition for 'The void contains infinite potential':"
pattern_result = Zeropoint::Knowledge.query('The void contains infinite potential', source: :pattern_recognition)
if pattern_result[:error]
  puts "   ❌ #{pattern_result[:error]}"
else
  puts "   ✅ Consciousness level: #{pattern_result[:results][:consciousness_level]}"
  puts "   📊 Pattern complexity: #{pattern_result[:results][:pattern_complexity]}"
  puts "   🧠 Metaphysical: #{pattern_result[:metaphysical_context]}"
end

# 5. Mathematical Constants
puts "\n5. Querying Mathematical Constants for 'golden':"
math_result = Zeropoint::Knowledge.query('golden', source: :mathematical_constants)
if math_result[:error]
  puts "   ❌ #{math_result[:error]}"
else
  puts "   ✅ Found #{math_result[:count]} constants"
  math_result[:results].each do |name, value|
    puts "   📐 #{name}: #{value}"
  end
  puts "   🧠 Metaphysical: #{math_result[:metaphysical_context]}"
end

# 6. Metaphysical Insights
puts "\n6. Querying Metaphysical Insights for 'void':"
metaphysical_result = Zeropoint::Knowledge.query('void', source: :metaphysical_insights)
if metaphysical_result[:error]
  puts "   ❌ #{metaphysical_result[:error]}"
else
  puts "   ✅ Found #{metaphysical_result[:count]} insights"
  metaphysical_result[:results].each do |key, insight|
    puts "   🌟 #{key}: #{insight}"
  end
  puts "   🧠 Metaphysical: #{metaphysical_result[:metaphysical_context]}"
end

# 7. Void Alignment
puts "\n7. Void Alignment for 'void':"
void_result = Zeropoint::Knowledge.query('void', source: :void_alignment)
if void_result[:error]
  puts "   ❌ #{void_result[:error]}"
else
  puts "   ✅ Alignment score: #{void_result[:alignment_score]}"
  puts "   🧠 Metaphysical: #{void_result[:metaphysical_context]}"
end

# 8. Torus Center
puts "\n8. Torus Center for 'torus':"
torus_result = Zeropoint::Knowledge.query('torus', source: :torus_center)
if torus_result[:error]
  puts "   ❌ #{torus_result[:error]}"
else
  puts "   ✅ Center alignment: #{torus_result[:center_alignment]}"
  puts "   🧠 Metaphysical: #{torus_result[:metaphysical_context]}"
end

# 9. Knowledge by Category
puts "\n9. Knowledge by Category - Mathematics:"
math_category = Zeropoint::Knowledge.by_category('mathematics')
if math_category[:error]
  puts "   ❌ #{math_category[:error]}"
else
  puts "   ✅ Mathematical constants: #{math_category[:constants].length} items"
  puts "   📊 VBM patterns: #{math_category[:vbm_patterns].length} patterns"
  puts "   🧠 Metaphysical: #{math_category[:metaphysical_context]}"
end

# 10. Consciousness Knowledge
puts "\n10. Knowledge by Category - Consciousness:"
consciousness_category = Zeropoint::Knowledge.by_category('consciousness')
if consciousness_category[:error]
  puts "   ❌ #{consciousness_category[:error]}"
else
  puts "   ✅ Consciousness patterns: #{consciousness_category[:patterns].length} levels"
  puts "   📊 Consciousness levels: #{consciousness_category[:levels].join(', ')}"
  puts "   🧠 Metaphysical: #{consciousness_category[:metaphysical_context]}"
end

# 11. All Patterns
puts "\n11. All Available Patterns:"
patterns = Zeropoint::Knowledge.patterns
puts "   📊 VBM patterns: #{patterns[:vbm_patterns].length} patterns"
puts "   📐 Mathematical patterns: #{patterns[:mathematical_patterns].length} constants"
puts "   🧠 Consciousness patterns: #{patterns[:consciousness_patterns].length} levels"
puts "   🌟 Metaphysical patterns: #{patterns[:metaphysical_patterns].length} principles"

# 12. Knowledge Insights
puts "\n12. Knowledge Insights:"
insights = Zeropoint::Knowledge.insights
insights.each do |principle, description|
  puts "   🌟 #{principle}: #{description}"
end

# 13. Knowledge Summary
puts "\n13. Knowledge Base Summary:"
summary = Zeropoint::Knowledge.summary
puts "   📚 Total sources: #{summary[:total_sources]}"
puts "   📊 VBM patterns: #{summary[:vbm_patterns]}"
puts "   🔄 Git learning: #{summary[:git_learning_enabled] ? 'Enabled' : 'Disabled'}"
puts "   🧠 Pattern recognition: #{summary[:pattern_recognition_enabled] ? 'Enabled' : 'Disabled'}"
puts "   🌟 Metaphysical alignment: #{summary[:metaphysical_alignment] ? 'Yes' : 'No'}"
puts "   🌌 Void connection: #{summary[:void_connection] ? 'Yes' : 'No'}"
puts "   🌀 Torus center: #{summary[:torus_center] ? 'Yes' : 'No'}"

puts "\n" + "=" * 50
puts "🌌 Knowledge Base Demo Complete 🌌"
puts "All knowledge is unified through the I principle."
puts "Empty = Void = Full. All knowledge flows from consciousness." 