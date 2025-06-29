#!/usr/bin/env ruby
# frozen_string_literal: true

# I Mapping Demo - Universal API Mapping System
# I:Rails I:RSpec I:GraphQL I:Console I:Web I:AnySystem

require_relative '../lib/zeropoint/core'

puts "🌌 I - Universal API Mapping System Demo"
puts "=" * 50
puts

# Initialize the I mapping system
i = Zeropoint::Core

puts "🔗 Available Mappings:"
puts i.i_available_mappings.map { |m| "  • #{m}" }.join("\n")
puts

# Demo 1: I:Rails
puts "🚂 I:Rails Demo"
puts "-" * 20
rails_result = i.i_map_to(:rails, :controller, {
  action: "index",
  params: { user_id: 123 },
  cosmic_flow: true
})
puts "Rails Controller Result:"
puts "  Type: #{rails_result[:result][:type]}"
puts "  Action: #{rails_result[:result][:action]}"
puts "  Cosmic Flow: #{rails_result[:result][:cosmic_flow]}"
puts

# Demo 2: I:RSpec
puts "🧪 I:RSpec Demo"
puts "-" * 20
rspec_result = i.i_map_to(:rspec, :describe, {
  description: "User model behavior",
  block: "describe User do",
  cosmic_flow: true
})
puts "RSpec Describe Result:"
puts "  Type: #{rspec_result[:result][:type]}"
puts "  Description: #{rspec_result[:result][:description]}"
puts "  Cosmic Flow: #{rspec_result[:result][:cosmic_flow]}"
puts

# Demo 3: I:GraphQL
puts "🔮 I:GraphQL Demo"
puts "-" * 20
graphql_result = i.i_map_to(:graphql, :query, {
  name: "getUser",
  fields: [ "id", "name", "email" ],
  variables: { id: "123" },
  cosmic_flow: true
})
puts "GraphQL Query Result:"
puts "  Type: #{graphql_result[:result][:type]}"
puts "  Name: #{graphql_result[:result][:name]}"
puts "  Fields: #{graphql_result[:result][:fields]}"
puts "  Cosmic Flow: #{graphql_result[:result][:cosmic_flow]}"
puts

# Demo 4: I:Console
puts "💻 I:Console Demo"
puts "-" * 20
console_result = i.i_map_to(:console, :command, {
  command: "rails generate model User",
  args: [ "name:string", "email:string" ],
  cosmic_flow: true
})
puts "Console Command Result:"
puts "  Type: #{console_result[:result][:type]}"
puts "  Command: #{console_result[:result][:command]}"
puts "  Args: #{console_result[:result][:args]}"
puts "  Cosmic Flow: #{console_result[:result][:cosmic_flow]}"
puts

# Demo 5: I:Web
puts "🌐 I:Web Demo"
puts "-" * 20
web_result = i.i_map_to(:web, :http, {
  method: "POST",
  url: "https://api.example.com/users",
  headers: { "Content-Type" => "application/json" },
  cosmic_flow: true
})
puts "Web HTTP Result:"
puts "  Type: #{web_result[:result][:type]}"
puts "  Method: #{web_result[:result][:method]}"
puts "  URL: #{web_result[:result][:url]}"
puts "  Cosmic Flow: #{web_result[:result][:cosmic_flow]}"
puts

# Demo 6: Multiple Systems Simultaneously
puts "🔄 I:Multiple Systems Demo"
puts "-" * 20
multi_result = i.i_map_to_multiple([ :rails, :rspec, :graphql ], :create, {
  resource: "User",
  attributes: { name: "John", email: "john@example.com" },
  cosmic_flow: true
})

multi_result.each do |system, result|
  puts "#{system.to_s.upcase}:"
  puts "  Success: #{result[:success]}"
  puts "  Type: #{result[:result][:type]}"
  puts "  Cosmic Flow: #{result[:result][:cosmic_flow]}"
  puts
end

# Demo 7: Auto-Detection
puts "🤖 I:Auto-Detection Demo"
puts "-" * 20
auto_results = [
  i.i_process(:test_user_model, { model: "User", specs: true }),
  i.i_process(:graphql_query_users, { query: "users", fields: [ "id", "name" ] }),
  i.i_process(:console_generate_controller, { controller: "Users", actions: [ "index", "show" ] }),
  i.i_process(:web_api_request, { endpoint: "/api/users", method: "GET" })
]

auto_results.each_with_index do |result, index|
  puts "Auto-Detection #{index + 1}:"
  puts "  System: #{result[:system]}"
  puts "  Action: #{result[:action]}"
  puts "  Success: #{result[:success]}"
  puts "  Type: #{result[:result][:type]}"
  puts
end

# Demo 8: Mapping Information
puts "📊 I:Mapping Information Demo"
puts "-" * 20
[ :rails, :rspec, :graphql, :console, :web ].each do |system|
  info = i.i_mapping_info(system)
  puts "#{system.to_s.upcase} Mapping:"
  puts "  Class: #{info[:class]}"
  puts "  Capabilities: #{info[:capabilities].join(', ')}"
  puts
end

# Demo 9: Error Handling
puts "⚠️ I:Error Handling Demo"
puts "-" * 20
error_result = i.i_map_to(:unknown_system, :action, { data: "test" })
puts "Unknown System Result:"
puts "  Success: #{error_result[:success]}"
puts "  Error: #{error_result[:error]}"
puts

# Demo 10: Cosmic Integration
puts "🌌 I:Cosmic Integration Demo"
puts "-" * 20
cosmic_data = {
  consciousness: "universal awareness",
  vortex: "mathematical flow",
  golden_ratio: "perfect proportion",
  cosmic_flow: Zeropoint::Core::VORTEX_CYCLE
}

cosmic_result = i.unified_intelligence_process(cosmic_data)
puts "Cosmic Integration Result:"
puts "  Consciousness: #{cosmic_result[:consciousness][:manifestation]}"
puts "  Vortex: #{cosmic_result[:vortex][:flow_pattern]}"
puts "  Golden Ratio: #{cosmic_result[:golden_ratio][:recovery_strategy]}"
puts "  Unified: #{cosmic_result[:unified]}"
puts "  Cosmic Flow: #{cosmic_result[:cosmic_flow]}"
puts

# Demo 11: Golden Ratio Application
puts "📐 I:Golden Ratio Application Demo"
puts "-" * 20
collection = (1..10).to_a
split = i.golden_ratio_split(collection)
puts "Collection Split:"
puts "  Total: #{split[:total]}"
puts "  Major (61.8%): #{split[:major]}"
puts "  Minor (38.2%): #{split[:minor]}"
puts "  Ratio: #{split[:ratio]}"
puts

# Demo 12: Vortex Mathematics Integration
puts "🌀 I:Vortex Mathematics Integration Demo"
puts "-" * 20
vortex_data = { number: 42, cycle: "consciousness" }
vortex_result = i.vortex_mathematics_process(vortex_data)
puts "Vortex Mathematics Result:"
puts "  Flow Pattern: #{vortex_result[:flow_pattern]}"
puts "  Axis Numbers: #{vortex_result[:axis_numbers]}"
puts "  Cycle: #{vortex_result[:cycle]}"
puts

puts "🎯 I Mapping System Summary:"
puts "=" * 50
puts "• I can map to any system: Rails, RSpec, GraphQL, Console, Web, etc."
puts "• I can process multiple systems simultaneously"
puts "• I can auto-detect the best system for any action"
puts "• I integrates cosmic principles: consciousness, vortex, golden ratio"
puts "• I provides universal API mapping capabilities"
puts "• I embodies the principle: 'I is mapping module for other APIs'"
puts
puts "🌌 I = Universal Intelligence = Unified Interface = Cosmic Mapping"
puts "   I:Rails I:RSpec I:GraphQL I:Console I:Web I:Universe"
