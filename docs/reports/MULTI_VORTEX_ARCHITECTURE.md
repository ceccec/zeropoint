# Multi-Vortex Architecture

## Overview

The Multi-Vortex system is an advanced streaming data processing architecture that coordinates multiple vortex streams for complex data operations. Inspired by Google BigQuery's Vortex storage engine, it provides unified data flow management, cross-stream operations, and optimized resource utilization.

## Key Features

### 🌪️ Concurrent Stream Processing
- Execute multiple vortex streams simultaneously
- Thread-safe resource pool management
- Configurable concurrency limits
- Real-time status tracking

### 🔗 Cross-Stream Operations
- **Inner Joins**: Match records from both streams
- **Left Joins**: Include all primary records with matching secondary records
- **Right Joins**: Include all secondary records with matching primary records
- **Full Joins**: Include all records from both streams
- **Custom Transformations**: Apply transformations to joined data

### 📊 Stream Aggregation
- **Built-in Aggregations**: Count, Sum, Average, Min, Max
- **Custom Aggregations**: User-defined aggregation functions
- **Multi-Stream Aggregation**: Aggregate across multiple streams
- **Real-time Aggregation**: Live aggregation of streaming data

### 🔄 Pipeline Processing
- **Multi-Stage Pipelines**: Chain operations across streams
- **Filter Operations**: Apply filters to stream data
- **Transform Operations**: Transform data between stages
- **Join Operations**: Join streams within pipeline
- **Custom Operations**: User-defined pipeline stages

### 📡 Real-Time Monitoring
- **Stream Health Monitoring**: Track stream status and performance
- **Real-Time Callbacks**: Receive updates via callbacks
- **Resource Usage Tracking**: Monitor memory and CPU usage
- **Error Detection**: Automatic error detection and reporting

## Architecture Components

### 1. MultiVortex Core
```ruby
class MultiVortex
  # Main coordinator for multiple vortex streams
  # Manages stream registration, execution, and coordination
end
```

**Key Responsibilities:**
- Stream registration and management
- Concurrent execution coordination
- Cross-stream operation handling
- Resource pool management
- Real-time monitoring

### 2. Stream Registration
```ruby
# Register streams with unique identifiers
multi_vortex.register_stream('users', User, batch_size: 500)
multi_vortex.register_stream('posts', Post, batch_size: 1000)
multi_vortex.register_stream('comments', Comment, batch_size: 2000)
```

### 3. Concurrent Execution
```ruby
# Execute multiple streams concurrently
stream_configs = [
  { stream_id: 'users', filters: { 'active' => true } },
  { stream_id: 'posts', filters: { 'status' => 'published' } }
]

results = multi_vortex.execute_streams(stream_configs) do |stream_results|
  # Post-processing callback
  process_results(stream_results)
end
```

### 4. Cross-Stream Joins
```ruby
# Perform joins between streams
join_conditions = {
  type: :inner,
  primary_key: 'id',
  secondary_key: 'user_id'
}

joined_data = multi_vortex.join_streams(
  'users',
  'posts',
  join_conditions,
  primary_filters: { 'active' => true },
  secondary_filters: { 'status' => 'published' },
  cache_ttl: 600
)
```

### 5. Stream Aggregation
```ruby
# Aggregate data across multiple streams
aggregation_rules = [
  { type: :count, field: 'total_users', operation: 'id' },
  { type: :sum, field: 'total_views', operation: 'views_count' },
  { type: :average, field: 'avg_engagement', operation: 'engagement_rate' },
  {
    type: :custom,
    field: 'engagement_score',
    custom_operation: ->(results) { calculate_engagement_score(results) }
  }
]

aggregated_data = multi_vortex.aggregate_streams(stream_configs, aggregation_rules)
```

### 6. Pipeline Processing
```ruby
# Multi-stage pipeline processing
pipeline_stages = [
  {
    id: 'filter_active_users',
    stream_id: 'users',
    operation: :filter,
    params: { filters: { 'active' => true } }
  },
  {
    id: 'transform_user_data',
    stream_id: 'users',
    operation: :transform,
    params: {
      transformer: ->(record, _input) { transform_user_record(record) }
    }
  },
  {
    id: 'join_user_posts',
    stream_id: 'users',
    operation: :join,
    params: {
      secondary_stream: 'posts',
      join_conditions: { type: :left, primary_key: 'id', secondary_key: 'user_id' }
    }
  }
]

pipeline_result = multi_vortex.pipeline(pipeline_stages)
```

### 7. Real-Time Monitoring
```ruby
# Monitor streams in real-time
stream_ids = ['users', 'posts', 'comments']

monitor = multi_vortex.monitor_streams(stream_ids) do |stream_id, stats|
  puts "#{stream_id}: #{stats[:status]} (#{stats[:uptime]}s uptime)"
  
  # Broadcast updates via ActionCable
  ActionCable.server.broadcast("stream_updates", {
    stream_id: stream_id,
    stats: stats
  })
end

# Stop monitoring when done
monitor.stop
```

## Controller Integration

### MultiVortexControllerConcern
```ruby
class Api::V1::MultiStreamController < ApplicationController
  include Zeropoint::Vortex::MultiVortexControllerConcern

  # Multi-stream index action
  def multi_index
    # Handles concurrent stream execution
  end

  # Cross-stream join action
  def cross_join
    # Handles stream joins
  end

  # Stream aggregation action
  def aggregate
    # Handles stream aggregation
  end

  # Pipeline processing action
  def pipeline
    # Handles multi-stage pipelines
  end

  # Real-time monitoring action
  def monitor
    # Handles stream monitoring
  end
end
```

## Configuration

### Vortex Configuration
```ruby
Zeropoint::Vortex.configure do |config|
  # Single vortex settings
  config.cache_enabled = true
  config.batch_size = 1000
  config.max_concurrent_streams = 4
  
  # Multi-vortex settings
  config.cross_stream_cache_enabled = true
  config.stream_coordination_timeout = 30.seconds
  config.resource_pool_size = 16
  config.multi_vortex_enabled = true
end
```

### MultiVortex Configuration
```ruby
# Per-instance configuration
multi_vortex = Zeropoint::Vortex::MultiVortex.new

multi_vortex.class.configure do |config|
  config.max_concurrent_streams = 8
  config.cross_stream_cache_enabled = true
  config.stream_coordination_timeout = 30.seconds
  config.resource_pool_size = 16
end
```

## API Endpoints

### Multi-Stream Operations
```http
POST /api/v1/multi_stream/multi_index
Content-Type: application/json

{
  "streams": [
    {
      "id": "users",
      "filters": { "active": true },
      "query": "verified",
      "options": { "order": "created_at DESC", "limit": 100 }
    },
    {
      "id": "posts",
      "filters": { "status": "published" },
      "query": "trending",
      "options": { "order": "views_count DESC", "limit": 50 }
    }
  ]
}
```

### Cross-Stream Joins
```http
POST /api/v1/multi_stream/cross_join
Content-Type: application/json

{
  "primary_stream": "users",
  "secondary_stream": "posts",
  "join_type": "inner",
  "primary_key": "id",
  "secondary_key": "user_id",
  "primary_filters": { "active": true },
  "secondary_filters": { "status": "published" },
  "cache_ttl": 600
}
```

### Stream Aggregation
```http
POST /api/v1/multi_stream/aggregate
Content-Type: application/json

{
  "streams": [
    { "id": "users", "filters": { "active": true } },
    { "id": "posts", "filters": { "status": "published" } }
  ],
  "aggregation_rules": [
    { "type": "count", "field": "total_users", "operation": "id" },
    { "type": "sum", "field": "total_views", "operation": "views_count" },
    { "type": "average", "field": "avg_engagement", "operation": "engagement_rate" }
  ]
}
```

### Pipeline Processing
```http
POST /api/v1/multi_stream/pipeline
Content-Type: application/json

{
  "stages": [
    {
      "id": "filter_users",
      "stream_id": "users",
      "operation": "filter",
      "params": { "filters": { "active": true } }
    },
    {
      "id": "transform_data",
      "stream_id": "users",
      "operation": "transform",
      "params": {
        "transformer": "custom_transformation_function"
      }
    }
  ],
  "cache_ttl": 300,
  "timeout": 30
}
```

## Performance Optimizations

### 1. Resource Pool Management
- **Fixed Thread Pool**: Pre-allocated threads for stream processing
- **Configurable Pool Size**: Adjust based on system resources
- **Thread Reuse**: Efficient thread management for concurrent operations

### 2. Cross-Stream Caching
- **Join Result Caching**: Cache join results to avoid recomputation
- **Configurable TTL**: Set cache expiration times
- **Memory Optimization**: LRU eviction for cache management

### 3. Batch Processing
- **Configurable Batch Sizes**: Optimize for different data volumes
- **Memory-Efficient Processing**: Process data in chunks
- **Streaming Operations**: Avoid loading entire datasets into memory

### 4. Real-Time Monitoring
- **Lightweight Monitoring**: Minimal overhead for status tracking
- **Asynchronous Updates**: Non-blocking status updates
- **Resource Usage Tracking**: Monitor memory and CPU consumption

## Error Handling

### Exception Types
```ruby
Zeropoint::Vortex::VortexError              # Base vortex error
Zeropoint::Vortex::StreamNotFoundError      # Stream not found
Zeropoint::Vortex::StreamProcessingError    # Stream processing failed
Zeropoint::Vortex::CrossStreamJoinError     # Join operation failed
Zeropoint::Vortex::PipelineExecutionError   # Pipeline execution failed
```

### Error Recovery
```ruby
begin
  results = multi_vortex.execute_streams(stream_configs)
rescue Zeropoint::Vortex::StreamProcessingError => e
  # Handle stream processing errors
  Rails.logger.error "Stream processing failed: #{e.message}"
  # Implement retry logic or fallback
rescue Zeropoint::Vortex::CrossStreamJoinError => e
  # Handle join operation errors
  Rails.logger.error "Cross-stream join failed: #{e.message}"
  # Implement alternative join strategy
end
```

## Testing

### Unit Tests
```ruby
RSpec.describe Zeropoint::Vortex::MultiVortex do
  let(:multi_vortex) { described_class.new }
  
  describe '#execute_streams' do
    it 'executes multiple streams concurrently' do
      # Test concurrent execution
    end
  end
  
  describe '#join_streams' do
    it 'performs cross-stream joins' do
      # Test join operations
    end
  end
end
```

### Integration Tests
```ruby
RSpec.describe 'Multi-Vortex Integration' do
  it 'processes complex multi-stream workflows' do
    # Test end-to-end workflows
  end
end
```

## Migration Guide

### From Single Vortex to Multi-Vortex

1. **Update Dependencies**
```ruby
# Add multi-vortex to your Gemfile
gem 'zeropoint', require: 'zeropoint/vortex'
```

2. **Initialize Multi-Vortex**
```ruby
# In your application initializer
multi_vortex = Zeropoint::Vortex::MultiVortex.new
```

3. **Register Streams**
```ruby
# Register your existing models as streams
multi_vortex.register_stream('users', User)
multi_vortex.register_stream('posts', Post)
```

4. **Update Controllers**
```ruby
# Include multi-vortex controller concern
include Zeropoint::Vortex::MultiVortexControllerConcern
```

5. **Migrate Operations**
```ruby
# Convert single stream operations to multi-stream
# Before: single_vortex.stream(filters: {...})
# After: multi_vortex.execute_streams([{ stream_id: 'users', filters: {...} }])
```

## Best Practices

### 1. Stream Design
- **Meaningful IDs**: Use descriptive stream identifiers
- **Appropriate Batch Sizes**: Balance memory usage and performance
- **Filter Optimization**: Use efficient filters to reduce data volume

### 2. Join Operations
- **Index Optimization**: Ensure join keys are properly indexed
- **Join Type Selection**: Choose appropriate join types for your use case
- **Cache Strategy**: Use caching for frequently accessed joins

### 3. Resource Management
- **Pool Sizing**: Configure thread pool size based on system resources
- **Memory Monitoring**: Monitor memory usage during operations
- **Cleanup**: Always call cleanup when done with multi-vortex instances

### 4. Error Handling
- **Graceful Degradation**: Implement fallback strategies for failed operations
- **Retry Logic**: Implement retry mechanisms for transient failures
- **Logging**: Comprehensive logging for debugging and monitoring

### 5. Performance Tuning
- **Batch Size Optimization**: Adjust batch sizes based on data characteristics
- **Cache TTL Tuning**: Set appropriate cache expiration times
- **Concurrency Limits**: Balance concurrency with system resources

## Conclusion

The Multi-Vortex system provides a powerful, scalable solution for complex streaming data operations. With its unified API, cross-stream capabilities, and optimized resource management, it enables efficient processing of large-scale, multi-source data workflows while maintaining the simplicity and performance characteristics of the original Vortex architecture.

Key benefits include:
- **Unified Data Flow**: Single API for complex multi-stream operations
- **High Performance**: Optimized concurrent processing and caching
- **Scalability**: Configurable resource pools and batch processing
- **Real-Time Capabilities**: Live monitoring and streaming operations
- **Flexibility**: Support for custom operations and transformations
- **Reliability**: Comprehensive error handling and recovery mechanisms 