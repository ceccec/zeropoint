# frozen_string_literal: true

# Multi-Vortex Demo: Advanced streaming data processing system
# Demonstrates concurrent streams, cross-stream operations, and unified data flow

require_relative '../lib/zeropoint/vortex/multi_vortex'

module Zeropoint
  module Vortex
    class MultiVortexDemo
      def initialize
        @multi_vortex = MultiVortex.new
        setup_demo_streams
      end

      def run_demo
        puts '🌪️  MULTI-VORTEX DEMO'
        puts '=' * 50
        puts

        demo_concurrent_streams
        demo_cross_stream_joins
        demo_stream_aggregation
        demo_pipeline_processing
        demo_real_time_monitoring
        demo_advanced_operations

        cleanup
      end

      private

      def setup_demo_streams
        puts '📡 Setting up demo streams...'

        # Register multiple streams for different data sources
        @multi_vortex.register_stream('users', User, batch_size: 500)
        @multi_vortex.register_stream('posts', Post, batch_size: 1000)
        @multi_vortex.register_stream('comments', Comment, batch_size: 2000)
        @multi_vortex.register_stream('analytics', AnalyticsEvent, batch_size: 5000)

        puts "  ✅ Registered #{@multi_vortex.stream_stats.keys.size} streams"
        puts
      end

      def demo_concurrent_streams
        puts '1. CONCURRENT STREAMS'
        puts '-' * 30

        stream_configs = [
          {
            stream_id: 'users',
            filters: { 'active' => true, 'role' => 'user' },
            query: 'verified',
            options: { order: 'created_at DESC', limit: 100 }
          },
          {
            stream_id: 'posts',
            filters: { 'status' => 'published', 'featured' => true },
            query: 'trending',
            options: { order: 'views_count DESC', limit: 50 }
          },
          {
            stream_id: 'comments',
            filters: { 'moderated' => true },
            query: 'helpful',
            options: { order: 'likes_count DESC', limit: 200 }
          }
        ]

        puts '  🔄 Executing concurrent streams...'
        results = @multi_vortex.execute_streams(stream_configs) do |stream_results|
          puts "  📊 Processed #{stream_results.size} streams"
          stream_results.each_with_index do |result, index|
            puts "    Stream #{index + 1}: #{result.count} records"
          end
        end

        puts '  ✅ Concurrent execution completed'
        puts "  📈 Total records processed: #{results.sum(&:count)}"
        puts
      end

      def demo_cross_stream_joins
        puts '2. CROSS-STREAM JOINS'
        puts '-' * 30

        # Inner join: Users with their posts
        puts '  🔗 Performing inner join: Users ↔ Posts'
        user_posts_join = @multi_vortex.join_streams(
          'users',
          'posts',
          {
            type: :inner,
            primary_key: 'id',
            secondary_key: 'user_id'
          },
          primary_filters: { 'active' => true },
          secondary_filters: { 'status' => 'published' },
          cache_ttl: 600,
        )

        puts "    📊 Joined records: #{user_posts_join.size}"

        # Left join: Posts with comments (including posts without comments)
        puts '  🔗 Performing left join: Posts ↔ Comments'
        posts_comments_join = @multi_vortex.join_streams(
          'posts',
          'comments',
          {
            type: :left,
            primary_key: 'id',
            secondary_key: 'post_id'
          },
          primary_filters: { 'status' => 'published' },
          secondary_filters: { 'moderated' => true },
        )

        puts "    📊 Joined records: #{posts_comments_join.size}"

        # Full join: Analytics with user events
        puts '  🔗 Performing full join: Users ↔ Analytics'
        user_analytics_join = @multi_vortex.join_streams(
          'users',
          'analytics',
          {
            type: :full,
            primary_key: 'id',
            secondary_key: 'user_id'
          },
          transform: lambda do |record|
            # Transform joined records
            {
              user_id: record['id'] || record['secondary_user_id'],
              username: record['username'],
              event_type: record['event_type'],
              event_count: record['event_count'] || 0
            }
          end,
        )

        puts "    📊 Joined records: #{user_analytics_join.size}"
        puts '  ✅ Cross-stream joins completed'
        puts
      end

      def demo_stream_aggregation
        puts '3. STREAM AGGREGATION'
        puts '-' * 30

        stream_configs = [
          { stream_id: 'users', filters: { 'active' => true } },
          { stream_id: 'posts', filters: { 'status' => 'published' } },
          { stream_id: 'comments', filters: { 'moderated' => true } }
        ]

        aggregation_rules = [
          { type: :count, field: 'total_users', operation: 'id' },
          { type: :count, field: 'total_posts', operation: 'id' },
          { type: :count, field: 'total_comments', operation: 'id' },
          { type: :sum, field: 'total_views', operation: 'views_count' },
          { type: :average, field: 'avg_post_views', operation: 'views_count' },
          { type: :max, field: 'max_likes', operation: 'likes_count' },
          {
            type: :custom,
            field: 'engagement_rate',
            custom_operation: lambda do |results|
              total_interactions = results.sum { |r| (r['likes_count'] || 0) + (r['comments_count'] || 0) }
              total_posts = results.count
              total_interactions.to_f / total_posts
            end
          }
        ]

        puts '  📊 Aggregating stream data...'
        aggregated_data = @multi_vortex.aggregate_streams(stream_configs, aggregation_rules)

        puts '  📈 Aggregation Results:'
        aggregated_data.each do |field, value|
          puts "    #{field}: #{value}"
        end
        puts '  ✅ Stream aggregation completed'
        puts
      end

      def demo_pipeline_processing
        puts '4. PIPELINE PROCESSING'
        puts '-' * 30

        pipeline_stages = [
          {
            id: 'filter_active_users',
            stream_id: 'users',
            operation: :filter,
            params: { filters: { 'active' => true, 'verified' => true } }
          },
          {
            id: 'transform_user_data',
            stream_id: 'users',
            operation: :transform,
            params: {
              filters: { 'active' => true },
              transformer: lambda do |record, _input_data|
                {
                  user_id: record['id'],
                  display_name: "#{record['first_name']} #{record['last_name']}",
                  email: record['email'],
                  status: 'active'
                }
              end
            }
          },
          {
            id: 'join_user_posts',
            stream_id: 'users',
            operation: :join,
            params: {
              secondary_stream: 'posts',
              join_conditions: {
                type: :left,
                primary_key: 'id',
                secondary_key: 'user_id'
              }
            }
          },
          {
            id: 'aggregate_user_stats',
            stream_id: 'users',
            operation: :aggregate,
            params: {
              filters: { 'active' => true },
              rules: [
                { type: :count, field: 'active_users', operation: 'id' },
                { type: :sum, field: 'total_posts', operation: 'secondary_id' }
              ]
            }
          }
        ]

        puts '  🔄 Executing pipeline...'
        pipeline_result = @multi_vortex.pipeline(pipeline_stages, cache_ttl: 300)

        puts '  📊 Pipeline Results:'
        if pipeline_result.is_a?(Hash)
          pipeline_result.each do |key, value|
            puts "    #{key}: #{value}"
          end
        else
          puts "    Records processed: #{pipeline_result.size}"
        end
        puts '  ✅ Pipeline processing completed'
        puts
      end

      def demo_real_time_monitoring
        puts '5. REAL-TIME MONITORING'
        puts '-' * 30

        stream_ids = %w[users posts comments]

        puts '  📡 Starting real-time monitoring...'
        monitor = @multi_vortex.monitor_streams(stream_ids) do |stream_id, stats|
          puts "    📊 #{stream_id}: #{stats[:status]} (#{stats[:uptime].to_i}s uptime)"
        end

        # Simulate some activity
        puts '  ⏱️  Monitoring for 3 seconds...'
        sleep 3

        # Stop monitoring
        monitor.stop
        puts '  ✅ Real-time monitoring completed'
        puts
      end

      def demo_advanced_operations
        puts '6. ADVANCED OPERATIONS'
        puts '-' * 30

        # Complex multi-stage pipeline with custom operations
        puts '  🔧 Advanced pipeline with custom operations...'

        advanced_pipeline = [
          {
            id: 'custom_user_analysis',
            stream_id: 'users',
            operation: :custom,
            params: {
              custom_operation: lambda do |processor, _input_data, _params|
                # Custom analysis operation
                users = processor.stream(filters: { 'active' => true }).to_a

                analysis = {
                  total_users: users.size,
                  verified_users: users.count { |u| u['verified'] },
                  premium_users: users.count { |u| u['premium'] },
                  user_segments: {
                    new: users.count { |u| u['created_at'] > 30.days.ago },
                    active: users.count { |u| u['last_login_at'] > 7.days.ago },
                    inactive: users.count { |u| u['last_login_at'] < 30.days.ago }
                  }
                }

                analysis
              end
            }
          }
        ]

        result = @multi_vortex.pipeline(advanced_pipeline)
        puts '  📊 Advanced Analysis Results:'
        result.each do |key, value|
          if value.is_a?(Hash)
            puts "    #{key}:"
            value.each { |sub_key, sub_value| puts "      #{sub_key}: #{sub_value}" }
          else
            puts "    #{key}: #{value}"
          end
        end

        puts '  ✅ Advanced operations completed'
        puts
      end

      def cleanup
        puts '🧹 Cleaning up resources...'
        @multi_vortex.cleanup
        puts '  ✅ Multi-vortex demo completed'
        puts
        puts '🎉 Multi-Vortex system successfully demonstrated!'
        puts '   Key features showcased:'
        puts '   • Concurrent stream processing'
        puts '   • Cross-stream joins (inner, left, right, full)'
        puts '   • Stream aggregation with custom rules'
        puts '   • Multi-stage pipeline processing'
        puts '   • Real-time stream monitoring'
        puts '   • Advanced custom operations'
        puts '   • Resource management and cleanup'
      end
    end
  end
end

# Run the demo if this file is executed directly
if __FILE__ == $PROGRAM_NAME
  demo = Zeropoint::Vortex::MultiVortexDemo.new
  demo.run_demo
end
