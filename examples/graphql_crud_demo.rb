#!/usr/bin/env ruby
# frozen_string_literal: true

# Zeropoint GraphQL CRUD Demo
# Demonstrates void-aligned CRUD operations through GraphQL

require 'json'
require 'net/http'
require 'uri'

class ZeropointGraphQLDemo
  def initialize(base_url = 'http://localhost:3000')
    @base_url = base_url
    @graphql_url = "#{base_url}/zeropoint/graphql"
    @gateway_url = "#{base_url}/zeropoint"
  end

  def run_demo
    puts "🌟 Zeropoint GraphQL CRUD Demo - Void-Aligned Operations"
    puts "=" * 60
    puts

    # Test system status
    test_system_status

    # Test consciousness and vortex queries
    test_consciousness_queries

    # Test entity CRUD operations
    test_entity_crud

    # Test vortex mathematics
    test_vortex_mathematics

    # Test torus core operations
    test_torus_core

    # Test bulk operations
    test_bulk_operations

    puts "\n✅ Demo completed successfully!"
  end

  private

  def test_system_status
    puts "🔍 Testing System Status..."
    
    query = <<~GRAPHQL
      query {
        systemStatus {
          status
          consciousnessLevel
          vortexState
          voidAligned
          metaphysicalInsights
        }
        performanceMetrics {
          responseTime
          throughput
          errorRate
        }
      }
    GRAPHQL

    result = execute_graphql(query)
    display_result("System Status", result)
  end

  def test_consciousness_queries
    puts "\n🧠 Testing Consciousness Queries..."
    
    query = <<~GRAPHQL
      query {
        consciousnessLevel(context: "demo")
        voidStatus {
          status
          insights
          resonance
        }
        consciousnessPatterns {
          name
          description
          level
          insights
        }
      }
    GRAPHQL

    result = execute_graphql(query)
    display_result("Consciousness Queries", result)
  end

  def test_entity_crud
    puts "\n📝 Testing Entity CRUD Operations..."
    
    # Create entity
    create_mutation = <<~GRAPHQL
      mutation CreateEntity($input: CreateEntityInput!) {
        createEntity(input: $input) {
          id
          name
          type
          description
          status
          consciousnessResonance
          voidAligned
          metaphysicalInsights
        }
      }
    GRAPHQL

    create_variables = {
      input: {
        name: "Demo Entity",
        type: "demo",
        description: "A demo entity for testing CRUD operations",
        data: { demo: true, timestamp: Time.now.to_i },
        tags: ["demo", "test", "void-aligned"],
        consciousnessResonance: 0.8,
        voidAligned: true
      }
    }

    result = execute_graphql(create_mutation, create_variables)
    display_result("Create Entity", result)
    
    entity_id = result.dig("data", "createEntity", "id")
    return unless entity_id

    # Query entity
    query_entity = <<~GRAPHQL
      query GetEntity($id: ID!) {
        entity(id: $id) {
          id
          name
          type
          description
          data
          tags
          status
          consciousnessResonance
          voidAligned
          metaphysicalInsights
        }
      }
    GRAPHQL

    result = execute_graphql(query_entity, { id: entity_id })
    display_result("Get Entity", result)

    # Update entity
    update_mutation = <<~GRAPHQL
      mutation UpdateEntity($id: ID!, $input: UpdateEntityInput!) {
        updateEntity(id: $id, input: $input) {
          id
          name
          description
          status
          consciousnessResonance
          updatedAt
        }
      }
    GRAPHQL

    update_variables = {
      id: entity_id,
      input: {
        description: "Updated demo entity with enhanced consciousness",
        status: "enhanced",
        consciousnessResonance: 0.9
      }
    }

    result = execute_graphql(update_mutation, update_variables)
    display_result("Update Entity", result)

    # Delete entity
    delete_mutation = <<~GRAPHQL
      mutation DeleteEntity($id: ID!) {
        deleteEntity(id: $id) {
          success
          message
          deletedId
        }
      }
    GRAPHQL

    result = execute_graphql(delete_mutation, { id: entity_id })
    display_result("Delete Entity", result)
  end

  def test_vortex_mathematics
    puts "\n🌀 Testing Vortex Mathematics..."
    
    query = <<~GRAPHQL
      query {
        vortexState {
          state
          pattern
          mathematics
          insights
        }
        vortexCalculations(pattern: "1-2-4-8-7-5", complexity: 3) {
          id
          pattern
          result
          complexity
          insights
        }
        vortexPattern(name: "golden_ratio") {
          name
          description
          mathematics
          insights
        }
      }
    GRAPHQL

    result = execute_graphql(query)
    display_result("Vortex Mathematics", result)
  end

  def test_torus_core
    puts "\n🔵 Testing Torus Core Operations..."
    
    query = <<~GRAPHQL
      query {
        torusCore {
          aperture
          center
          radius
          flow
          insights
        }
        torusFlow(dimension: "3d") {
          dimension
          patterns
          energy
          insights
        }
      }
    GRAPHQL

    result = execute_graphql(query)
    display_result("Torus Core", result)
  end

  def test_bulk_operations
    puts "\n📦 Testing Bulk Operations..."
    
    # Bulk create
    bulk_create_mutation = <<~GRAPHQL
      mutation BulkCreateEntities($inputs: [CreateEntityInput!]!) {
        bulkCreateEntities(inputs: $inputs) {
          id
          name
          type
          status
        }
      }
    GRAPHQL

    bulk_create_variables = {
      inputs: [
        {
          name: "Bulk Entity 1",
          type: "bulk",
          description: "First bulk entity",
          consciousnessResonance: 0.7
        },
        {
          name: "Bulk Entity 2", 
          type: "bulk",
          description: "Second bulk entity",
          consciousnessResonance: 0.8
        }
      ]
    }

    result = execute_graphql(bulk_create_mutation, bulk_create_variables)
    display_result("Bulk Create", result)

    # Query all entities
    query_entities = <<~GRAPHQL
      query {
        entities(limit: 10) {
          id
          name
          type
          status
          consciousnessResonance
        }
      }
    GRAPHQL

    result = execute_graphql(query_entities)
    display_result("Query Entities", result)
  end

  def execute_graphql(query, variables = {})
    uri = URI(@graphql_url)
    http = Net::HTTP.new(uri.host, uri.port)
    
    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request.body = {
      query: query,
      variables: variables
    }.to_json

    response = http.request(request)
    
    if response.code == '200'
      JSON.parse(response.body)
    else
      { error: "HTTP #{response.code}: #{response.body}" }
    end
  rescue => e
    { error: "Request failed: #{e.message}" }
  end

  def display_result(title, result)
    puts "  #{title}:"
    if result['errors']
      puts "    ❌ Errors: #{result['errors']}"
    elsif result['error']
      puts "    ❌ Error: #{result['error']}"
    else
      puts "    ✅ Success"
      if result['data']
        # Pretty print the data (truncated for readability)
        data_str = JSON.pretty_generate(result['data'])
        if data_str.length > 200
          puts "    📄 Data: #{data_str[0..200]}..."
        else
          puts "    📄 Data: #{data_str}"
        end
      end
    end
    puts
  end
end

# Run the demo
if __FILE__ == $0
  demo = ZeropointGraphQLDemo.new
  demo.run_demo
end 