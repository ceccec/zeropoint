#!/usr/bin/env ruby

# frozen_string_literal: true

# Full-Text Search Demonstration
# This script demonstrates the advanced full-text search capabilities of the Filterable concern

require 'bundler/setup'
require 'active_record'
require 'sqlite3'

# Mock ActiveRecord setup for demonstration
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:',
)

# Create test tables
ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :name
    t.string :email
    t.text :description
    t.text :content
    t.string :status
    t.boolean :active, default: true
    t.timestamps
  end

  create_table :posts do |t|
    t.string :title
    t.text :content
    t.text :summary
    t.string :author
    t.string :category
    t.timestamps
  end

  create_table :articles do |t|
    t.string :title
    t.text :body
    t.text :abstract
    t.string :author
    t.string :tags
    t.timestamps
  end
end

# Include the Filterable concern
module Zeropoint
  module ActiveRecord
    module FullTextSearch
      extend ActiveSupport::Concern

      included do
        # Full-text search configuration
        def self.full_text_search_config
          @full_text_search_config ||= {
            # Default search fields (can be overridden per model)
            search_fields: %w[name description content],

            # Search engine configuration
            engine: detect_search_engine,

            # PostgreSQL full-text search configuration
            postgresql: {
              # Default language for stemming
              language: 'english',
              # Search rank threshold (0.0 to 1.0)
              rank_threshold: 0.1,
              # Use trigram similarity for fuzzy matching
              use_trigram: true,
              # Trigram similarity threshold (0.0 to 1.0)
              trigram_threshold: 0.3
            },

            # Elasticsearch configuration
            elasticsearch: {
              # Index name (defaults to table name)
              index_name: table_name,
              # Search type (match, match_phrase, multi_match)
              search_type: 'multi_match',
              # Fields to search with boost values
              fields: {
                'name^3' => 3.0,
                'description^2' => 2.0,
                'content' => 1.0
              },
              # Fuzzy matching settings
              fuzziness: 'AUTO',
              # Minimum should match
              minimum_should_match: '75%'
            },

            # Fallback search configuration (for non-PostgreSQL/Elasticsearch)
            fallback: {
              # Use LIKE queries for basic search
              use_like: true,
              # Use ILIKE for case-insensitive search (PostgreSQL only)
              use_ilike: true,
              # Search in multiple fields
              multi_field: true
            }
          }
        end

        # Detect available search engine
        def self.detect_search_engine
          if defined?(Elasticsearch::Model) && respond_to?(:__elasticsearch__)
            :elasticsearch
          elsif connection.adapter_name.downcase == 'postgresql'
            :postgresql
          else
            :fallback
          end
        end

        # Configure full-text search
        def self.configure_full_text_search(options = {})
          config = full_text_search_config
          config.deep_merge!(options)
          @full_text_search_config = config
        end

        # Full-text search method
        def self.full_text_search(query, options = {})
          return all if query.blank?

          config = full_text_search_config
          engine = options[:engine] || config[:engine]

          case engine
          when :elasticsearch
            elasticsearch_search(query, options)
          when :postgresql
            postgresql_full_text_search(query, options)
          else
            fallback_search(query, options)
          end
        end

        # PostgreSQL full-text search
        def self.postgresql_full_text_search(query, options = {})
          config = full_text_search_config[:postgresql]
          search_fields = options[:fields] || full_text_search_config[:search_fields]
          language = options[:language] || config[:language]
          rank_threshold = options[:rank_threshold] || config[:rank_threshold]
          use_trigram = options[:use_trigram] || config[:use_trigram]
          trigram_threshold = options[:trigram_threshold] || config[:trigram_threshold]

          # Build search vector
          search_vector = build_search_vector(search_fields, language)

          # Create search query
          search_query = build_postgresql_search_query(query, language)

          # Build the scope
          scope = select("#{table_name}.*, #{search_vector} AS search_vector")
            .where("#{search_vector} @@ ?", search_query)

          # Add ranking if threshold is specified
          if rank_threshold.positive?
            rank_expression = "ts_rank(#{search_vector}, #{search_query})"
            scope = scope.select("#{rank_expression} AS search_rank")
              .where("#{rank_expression} >= ?", rank_threshold)
              .order('search_rank DESC')
          end

          # Add trigram similarity for fuzzy matching
          if use_trigram && trigram_available?
            scope = add_trigram_similarity(scope, search_fields, query, trigram_threshold)
          end

          scope
        end

        # Build PostgreSQL search vector
        def self.build_search_vector(fields, language)
          vector_parts = fields.map do |field|
            "setweight(to_tsvector('#{language}', coalesce(#{field}, '')), 'A')"
          end
          vector_parts.join(' || ')
        end

        # Build PostgreSQL search query
        def self.build_postgresql_search_query(query, language)
          # Clean and prepare query
          cleaned_query = clean_search_query(query)

          # Convert to tsquery format
          cleaned_query.split(/\s+/).map do |term|
            "#{term}:*"
          end.join(' & ')

          "to_tsquery('#{language}', ?)"
        end

        # Add trigram similarity for fuzzy matching
        def self.add_trigram_similarity(scope, fields, _query, threshold)
          return scope unless trigram_available?

          similarity_expressions = fields.map do |field|
            "greatest_similarity(#{field}, ?)"
          end

          max_similarity = similarity_expressions.join(', ')

          scope.select("#{scope.to_sql}.*, #{max_similarity} AS similarity")
            .where("#{max_similarity} >= ?", threshold)
            .order('similarity DESC')
        end

        # Check if trigram extension is available
        def self.trigram_available?
          @trigram_available ||= begin
            connection.execute("SELECT 1 FROM pg_extension WHERE extname = 'pg_trgm'").any?
          rescue StandardError
            false
          end
        end

        # Elasticsearch search
        def self.elasticsearch_search(query, options = {})
          return all unless respond_to?(:__elasticsearch__)

          config = full_text_search_config[:elasticsearch]
          search_type = options[:search_type] || config[:search_type]
          fields = options[:fields] || config[:fields]
          fuzziness = options[:fuzziness] || config[:fuzziness]
          minimum_should_match = options[:minimum_should_match] || config[:minimum_should_match]

          # Build Elasticsearch query
          es_query = build_elasticsearch_query(
            query, search_type, fields, fuzziness, minimum_should_match
          )

          # Execute search
          __elasticsearch__.search(
            query: es_query,
            size: options[:size] || 100,
            from: options[:from] || 0,
            sort: options[:sort] || [ '_score' ],
          )
        end

        # Build Elasticsearch query
        def self.build_elasticsearch_query(query, search_type, fields, fuzziness, minimum_should_match)
          cleaned_query = clean_search_query(query)

          case search_type
          when 'match'
            {
              match: {
                fields.keys.first => {
                  query: cleaned_query,
                  fuzziness: fuzziness,
                  minimum_should_match: minimum_should_match
                }
              }
            }
          when 'match_phrase'
            {
              match_phrase: {
                fields.keys.first => {
                  query: cleaned_query,
                  slop: 2
                }
              }
            }
          when 'multi_match'
            {
              multi_match: {
                query: cleaned_query,
                fields: fields.keys,
                type: 'best_fields',
                fuzziness: fuzziness,
                minimum_should_match: minimum_should_match,
                boost: 1.0
              }
            }
          else
            {
              query_string: {
                query: cleaned_query,
                fields: fields.keys,
                fuzziness: fuzziness,
                minimum_should_match: minimum_should_match
              }
            }
          end
        end

        # Fallback search (for non-PostgreSQL/Elasticsearch databases)
        def self.fallback_search(query, options = {})
          config = full_text_search_config[:fallback]
          search_fields = options[:fields] || full_text_search_config[:search_fields]
          options[:use_like] || config[:use_like]
          use_ilike = options[:use_ilike] || config[:use_ilike]
          multi_field = options[:multi_field] || config[:multi_field]

          cleaned_query = clean_search_query(query)
          return all if cleaned_query.blank?

          if multi_field
            # Search across multiple fields
            conditions = search_fields.map do |field|
              build_like_condition(field, cleaned_query, use_ilike)
            end

            where(conditions.join(' OR '))
          else
            # Search in first field only
            field = search_fields.first
            where(build_like_condition(field, cleaned_query, use_ilike))
          end
        end

        # Build LIKE/ILIKE condition
        def self.build_like_condition(field, _query, use_ilike)
          operator = (use_ilike && connection.adapter_name.downcase == 'postgresql') ? 'ILIKE' : 'LIKE'
          "#{field} #{operator} ?"
        end

        # Clean search query
        def self.clean_search_query(query)
          return '' if query.blank?

          # Remove special characters and normalize
          cleaned = query.to_s.strip
            .gsub(/[^\w\s\-']/, ' ')  # Keep alphanumeric, spaces, hyphens, apostrophes
            .gsub(/\s+/, ' ')         # Normalize whitespace
            .strip

          # Add wildcards for partial matching (fallback search)
          cleaned.split(/\s+/).map { |term| "%#{term}%" }.join(' ')
        end

        # Advanced search with multiple criteria
        def self.advanced_search(criteria = {})
          scope = all

          # Full-text search
          scope = scope.full_text_search(criteria[:query], criteria[:search_options] || {}) if criteria[:query].present?

          # Apply other filters
          filters = criteria.except(:query, :search_options)
          scope = scope.filter_by(filters) if filters.any?

          scope
        end

        # Search with highlighting
        def self.search_with_highlighting(query, options = {})
          config = full_text_search_config
          engine = options[:engine] || config[:engine]

          case engine
          when :elasticsearch
            elasticsearch_search_with_highlighting(query, options)
          when :postgresql
            postgresql_search_with_highlighting(query, options)
          else
            fallback_search_with_highlighting(query, options)
          end
        end

        # PostgreSQL search with highlighting
        def self.postgresql_search_with_highlighting(query, options = {})
          config = full_text_search_config[:postgresql]
          search_fields = options[:fields] || full_text_search_config[:search_fields]
          language = options[:language] || config[:language]

          search_vector = build_search_vector(search_fields, language)
          search_query = build_postgresql_search_query(query, language)

          # Add highlighting
          highlight_expressions = search_fields.map do |field|
            "ts_headline('#{language}', #{field}, #{search_query}, 'StartSel=<mark>,StopSel=</mark>') AS #{field}_highlighted"
          end

          select("#{table_name}.*, #{highlight_expressions.join(', ')}")
            .where("#{search_vector} @@ ?", search_query)
        end

        # Elasticsearch search with highlighting
        def self.elasticsearch_search_with_highlighting(query, options = {})
          return all unless respond_to?(:__elasticsearch__)

          config = full_text_search_config[:elasticsearch]
          fields = options[:fields] || config[:fields]

          es_query = build_elasticsearch_query(
            query, 'multi_match', fields, config[:fuzziness], config[:minimum_should_match]
          )

          highlight = {
            fields: fields.keys.map { |field| { field => {} } }.reduce(:merge)
          }

          __elasticsearch__.search(
            query: es_query,
            highlight: highlight,
            size: options[:size] || 100,
            from: options[:from] || 0,
          )
        end

        # Fallback search with highlighting
        def self.fallback_search_with_highlighting(query, options = {})
          # Simple highlighting using string replacement
          scope = fallback_search(query, options)

          if scope.respond_to?(:map)
            scope.map do |record|
              highlight_record(record, query, options[:fields] || full_text_search_config[:search_fields])
            end
          else
            scope
          end
        end

        # Highlight record fields
        def self.highlight_record(record, query, fields)
          highlighted_record = record.dup

          fields.each do |field|
            next unless record.respond_to?(field)

            value = record.send(field)
            next if value.blank?

            # Simple highlighting by wrapping matched terms
            query.split(/\s+/).each do |term|
              value = value.to_s.gsub(/(#{Regexp.escape(term)})/i, '<mark>\1</mark>')
            end

            highlighted_record.define_singleton_method("#{field}_highlighted") { value }
          end

          highlighted_record
        end

        # Search suggestions/autocomplete
        def self.search_suggestions(query, options = {})
          config = full_text_search_config
          engine = options[:engine] || config[:engine]

          case engine
          when :elasticsearch
            elasticsearch_suggestions(query, options)
          when :postgresql
            postgresql_suggestions(query, options)
          else
            fallback_suggestions(query, options)
          end
        end

        # PostgreSQL suggestions
        def self.postgresql_suggestions(query, options = {})
          return [] if query.blank?

          config = full_text_search_config[:postgresql]
          search_fields = options[:fields] || full_text_search_config[:search_fields]
          options[:language] || config[:language]
          limit = options[:limit] || 10

          # Use trigram similarity for suggestions
          suggestions = if trigram_available?
                          search_fields.map do |field|
                            select("DISTINCT #{field} as suggestion, similarity(#{field}, ?) as score")
                              .where("#{field} ILIKE ?", "%#{query}%")
                              .where("similarity(#{field}, ?) > ?", query, 0.3)
                              .order('score DESC')
                              .limit(limit)
                          end

          else
                          # Fallback to simple LIKE suggestions
                          search_fields.map do |field|
                            select("DISTINCT #{field} as suggestion")
                              .where("#{field} ILIKE ?", "%#{query}%")
                              .limit(limit)
                          end

          end
          suggestions.flatten.uniq(&:suggestion).first(limit)
        end

        # Elasticsearch suggestions
        def self.elasticsearch_suggestions(query, options = {})
          return [] unless respond_to?(:__elasticsearch__)

          config = full_text_search_config[:elasticsearch]
          options[:fields] || config[:fields]
          limit = options[:limit] || 10

          # Use completion suggester if available
          suggest_query = {
            suggestions: {
              prefix: query,
              completion: {
                field: 'suggest',
                size: limit,
                skip_duplicates: true
              }
            }
          }

          result = __elasticsearch__.search(suggest: suggest_query)
          result.response['suggest']['suggestions'].first['options'].map { |opt| opt['text'] }
        rescue StandardError
          # Fallback to regular search
          elasticsearch_search(query, size: limit).map(&:name)
        end

        # Fallback suggestions
        def self.fallback_suggestions(query, options = {})
          return [] if query.blank?

          search_fields = options[:fields] || full_text_search_config[:search_fields]
          limit = options[:limit] || 10

          suggestions = search_fields.map do |field|
            select("DISTINCT #{field} as suggestion")
              .where("#{field} LIKE ?", "%#{query}%")
              .limit(limit)
          end

          suggestions.flatten.uniq(&:suggestion).first(limit)
        end

        # Search statistics
        def self.search_stats(query, options = {})
          config = full_text_search_config
          engine = options[:engine] || config[:engine]

          case engine
          when :elasticsearch
            elasticsearch_stats(query, options)
          when :postgresql
            postgresql_search_stats(query, options)
          else
            fallback_search_stats(query, options)
          end
        end

        # PostgreSQL search statistics
        def self.postgresql_search_stats(query, options = {})
          config = full_text_search_config[:postgresql]
          search_fields = options[:fields] || full_text_search_config[:search_fields]
          language = options[:language] || config[:language]

          search_vector = build_search_vector(search_fields, language)
          search_query = build_postgresql_search_query(query, language)

          result = select("COUNT(*) as total_count, AVG(ts_rank(#{search_vector}, #{search_query})) as avg_rank")
            .where("#{search_vector} @@ ?", search_query)
            .first

          {
            total_count: result.total_count,
            average_rank: result.avg_rank,
            engine: 'postgresql'
          }
        end

        # Elasticsearch search statistics
        def self.elasticsearch_stats(query, options = {})
          return {} unless respond_to?(:__elasticsearch__)

          result = elasticsearch_search(query, options)

          {
            total_count: result.total_count,
            max_score: result.max_score,
            engine: 'elasticsearch'
          }
        end

        # Fallback search statistics
        def self.fallback_search_stats(query, options = {})
          result = fallback_search(query, options)

          {
            total_count: result.count,
            engine: 'fallback'
          }
        end

        # Create search index (PostgreSQL)
        def self.create_search_index(fields = nil, language = 'english')
          return unless connection.adapter_name.downcase == 'postgresql'

          fields ||= full_text_search_config[:search_fields]
          index_name = "#{table_name}_search_idx"

          # Create GIN index for full-text search
          connection.execute(<<~SQL.squish)
            CREATE INDEX IF NOT EXISTS #{index_name}#{' '}
            ON #{table_name}#{' '}
            USING GIN (to_tsvector('#{language}', #{fields.join(" || ' ' || ")}))
          SQL

          # Create trigram index if available
          return unless trigram_available?

          fields.each do |field|
            trigram_index_name = "#{table_name}_#{field}_trigram_idx"
            connection.execute(<<~SQL.squish)
              CREATE INDEX IF NOT EXISTS #{trigram_index_name}#{' '}
              ON #{table_name}#{' '}
              USING GIN (#{field} gin_trgm_ops)
            SQL
          end
        end

        # Drop search index
        def self.drop_search_index
          return unless connection.adapter_name.downcase == 'postgresql'

          index_name = "#{table_name}_search_idx"
          connection.execute("DROP INDEX IF EXISTS #{index_name}")

          # Drop trigram indexes
          return unless trigram_available?

          full_text_search_config[:search_fields].each do |field|
            trigram_index_name = "#{table_name}_#{field}_trigram_idx"
            connection.execute("DROP INDEX IF EXISTS #{trigram_index_name}")
          end
        end

        # Rebuild search index
        def self.rebuild_search_index
          drop_search_index
          create_search_index
        end
      end
    end
  end
end

# Test models
class User < ApplicationRecord
  include Zeropoint::ActiveRecord::FullTextSearch

  # Configure search fields for users
  configure_full_text_search(
    search_fields: %w[name email description],
    fallback: {
      use_like: true,
      multi_field: true
    },
  )
end

class Post < ApplicationRecord
  include Zeropoint::ActiveRecord::FullTextSearch

  # Configure search fields for posts
  configure_full_text_search(
    search_fields: %w[title content summary author],
    fallback: {
      use_like: true,
      multi_field: true
    },
  )
end

class Article < ApplicationRecord
  include Zeropoint::ActiveRecord::FullTextSearch

  # Configure search fields for articles
  configure_full_text_search(
    search_fields: %w[title body abstract author tags],
    fallback: {
      use_like: true,
      multi_field: true
    },
  )
end

# Create test data
puts 'Creating test data...'

# Users
users_data = [
  {
    name: 'Alice Johnson',
    email: 'alice@example.com',
    description: 'Software developer specializing in Ruby on Rails and JavaScript',
    content: 'Experienced full-stack developer with 5+ years in web development',
    status: 'active',
    active: true
  },
  {
    name: 'Bob Smith',
    email: 'bob@example.com',
    description: 'UI/UX designer with expertise in modern design systems',
    content: 'Creative designer focused on user experience and accessibility',
    status: 'active',
    active: true
  },
  {
    name: 'Charlie Brown',
    email: 'charlie@example.com',
    description: 'DevOps engineer specializing in cloud infrastructure',
    content: 'Infrastructure expert with experience in AWS, Docker, and Kubernetes',
    status: 'inactive',
    active: false
  },
  {
    name: 'Diana Prince',
    email: 'diana@example.com',
    description: 'Product manager with background in agile methodologies',
    content: 'Strategic product leader with 8+ years in software product management',
    status: 'active',
    active: true
  }
]

users_data.each { |data| User.create!(data) }

# Posts
posts_data = [
  {
    title: 'Getting Started with Ruby on Rails',
    content: 'Ruby on Rails is a powerful web framework that makes web development simple and fun. This guide will help you get started with Rails development.',
    summary: 'A comprehensive guide to Ruby on Rails for beginners',
    author: 'Alice Johnson',
    category: 'programming'
  },
  {
    title: 'Modern JavaScript Best Practices',
    content: 'JavaScript has evolved significantly over the years. Learn about modern JavaScript features, ES6+, and best practices for writing clean, maintainable code.',
    summary: 'Explore modern JavaScript features and best practices',
    author: 'Bob Smith',
    category: 'programming'
  },
  {
    title: 'Design Systems for Web Applications',
    content: 'Design systems help create consistent, scalable user interfaces. Learn how to build and maintain effective design systems for your web applications.',
    summary: 'Building scalable design systems for web applications',
    author: 'Bob Smith',
    category: 'design'
  },
  {
    title: 'Cloud Infrastructure with AWS',
    content: 'Amazon Web Services provides a comprehensive suite of cloud computing services. Learn how to design and deploy scalable infrastructure on AWS.',
    summary: 'Guide to AWS cloud infrastructure and deployment',
    author: 'Charlie Brown',
    category: 'devops'
  }
]

posts_data.each { |data| Post.create!(data) }

# Articles
articles_data = [
  {
    title: 'The Future of Web Development',
    body: 'Web development is constantly evolving with new technologies and frameworks. This article explores emerging trends and what the future holds for web developers.',
    abstract: 'Exploring emerging trends in web development',
    author: 'Alice Johnson',
    tags: 'web-development, trends, future'
  },
  {
    title: 'User Experience Design Principles',
    body: 'Good user experience is crucial for the success of any application. Learn about fundamental UX design principles and how to apply them in your projects.',
    abstract: 'Core principles of user experience design',
    author: 'Bob Smith',
    tags: 'ux, design, user-experience'
  },
  {
    title: 'Microservices Architecture',
    body: 'Microservices architecture is a modern approach to building scalable applications. This article covers the benefits, challenges, and best practices of microservices.',
    abstract: 'Understanding microservices architecture and implementation',
    author: 'Charlie Brown',
    tags: 'microservices, architecture, scalability'
  },
  {
    title: 'Agile Product Management',
    body: 'Agile methodologies have revolutionized product management. Learn how to effectively manage products using agile principles and practices.',
    abstract: 'Effective product management with agile methodologies',
    author: 'Diana Prince',
    tags: 'agile, product-management, methodology'
  }
]

articles_data.each { |data| Article.create!(data) }

puts 'Test data created successfully!'
puts "Total records: #{User.count} users, #{Post.count} posts, #{Article.count} articles"
puts

# Demonstration functions
def demonstrate_search(model_class, search_queries, title)
  puts '=' * 80
  puts "🔍 #{title}"
  puts '=' * 80
  puts "Model: #{model_class.name}"
  puts "Search Engine: #{model_class.full_text_search_config[:engine]}"
  puts "Search Fields: #{model_class.full_text_search_config[:search_fields].join(', ')}"
  puts

  search_queries.each do |query|
    puts "🔍 Searching for: '#{query}'"
    results = model_class.full_text_search(query)

    if results.any?
      puts "✅ Found #{results.count} results:"
      results.each do |result|
        if result.respond_to?(:name)
          puts "   • #{result.name} (#{result.email})"
        elsif result.respond_to?(:title)
          puts "   • #{result.title} by #{result.author}"
        end
      end
    else
      puts '❌ No results found'
    end
    puts
  end
end

def demonstrate_advanced_search(model_class, search_criteria, title)
  puts '=' * 80
  puts "🚀 #{title}"
  puts '=' * 80
  puts "Model: #{model_class.name}"
  puts

  search_criteria.each do |criteria|
    puts "🔍 Advanced search: #{criteria.inspect}"
    results = model_class.advanced_search(criteria)

    if results.any?
      puts "✅ Found #{results.count} results:"
      results.each do |result|
        if result.respond_to?(:name)
          puts "   • #{result.name} (#{result.email})"
        elsif result.respond_to?(:title)
          puts "   • #{result.title} by #{result.author}"
        end
      end
    else
      puts '❌ No results found'
    end
    puts
  end
end

def demonstrate_highlighting(model_class, search_queries, title)
  puts '=' * 80
  puts "✨ #{title}"
  puts '=' * 80
  puts "Model: #{model_class.name}"
  puts

  search_queries.each do |query|
    puts "🔍 Searching with highlighting: '#{query}'"
    results = model_class.search_with_highlighting(query)

    if results.any?
      puts "✅ Found #{results.count} results:"
      results.first(3).each do |result|
        if result.respond_to?(:name_highlighted)
          puts "   • #{result.name_highlighted}"
        elsif result.respond_to?(:title_highlighted)
          puts "   • #{result.title_highlighted}"
        end
      end
    else
      puts '❌ No results found'
    end
    puts
  end
end

def demonstrate_suggestions(model_class, search_queries, title)
  puts '=' * 80
  puts "💡 #{title}"
  puts '=' * 80
  puts "Model: #{model_class.name}"
  puts

  search_queries.each do |query|
    puts "🔍 Getting suggestions for: '#{query}'"
    suggestions = model_class.search_suggestions(query, limit: 5)

    if suggestions.any?
      puts "✅ Found #{suggestions.count} suggestions:"
      suggestions.each do |suggestion|
        puts "   • #{suggestion.suggestion}"
      end
    else
      puts '❌ No suggestions found'
    end
    puts
  end
end

def demonstrate_stats(model_class, search_queries, title)
  puts '=' * 80
  puts "📊 #{title}"
  puts '=' * 80
  puts "Model: #{model_class.name}"
  puts

  search_queries.each do |query|
    puts "🔍 Getting stats for: '#{query}'"
    stats = model_class.search_stats(query)

    puts '✅ Search Statistics:'
    puts "   • Engine: #{stats[:engine]}"
    puts "   • Total Count: #{stats[:total_count]}"
    puts "   • Average Rank: #{stats[:average_rank].round(4)}" if stats[:average_rank]
    puts "   • Max Score: #{stats[:max_score].round(4)}" if stats[:max_score]
    puts
  end
end

# Run demonstrations
puts '🚀 STARTING FULL-TEXT SEARCH DEMONSTRATIONS'
puts

# User search demonstrations
user_search_queries = [
  'alice',
  'developer',
  'design',
  'ruby rails',
  'javascript',
  'cloud infrastructure'
]

demonstrate_search(User, user_search_queries, 'USER SEARCH DEMONSTRATION')

# Post search demonstrations
post_search_queries = [
  'rails',
  'javascript',
  'design systems',
  'aws cloud',
  'web development',
  'best practices'
]

demonstrate_search(Post, post_search_queries, 'POST SEARCH DEMONSTRATION')

# Article search demonstrations
article_search_queries = [
  'web development',
  'user experience',
  'microservices',
  'agile',
  'product management',
  'architecture'
]

demonstrate_search(Article, article_search_queries, 'ARTICLE SEARCH DEMONSTRATION')

# Advanced search demonstrations
advanced_search_criteria = [
  { query: 'developer', active: true },
  { query: 'design', status: 'active' },
  { query: 'rails', category: 'programming' },
  { query: 'cloud', category: 'devops' }
]

demonstrate_advanced_search(Post, advanced_search_criteria, 'ADVANCED SEARCH DEMONSTRATION')

# Highlighting demonstrations
highlighting_queries = %w[
  ruby
  javascript
  design
  cloud
]

demonstrate_highlighting(Post, highlighting_queries, 'SEARCH HIGHLIGHTING DEMONSTRATION')

# Suggestions demonstrations
suggestion_queries = %w[
  al
  dev
  des
  clo
]

demonstrate_suggestions(User, suggestion_queries, 'SEARCH SUGGESTIONS DEMONSTRATION')

# Statistics demonstrations
stats_queries = %w[
  developer
  design
  rails
  cloud
]

demonstrate_stats(User, stats_queries, 'SEARCH STATISTICS DEMONSTRATION')

# Configuration demonstrations
puts '=' * 80
puts '⚙️ CONFIGURATION DEMONSTRATION'
puts '=' * 80

puts 'User model configuration:'
puts "  • Search Engine: #{User.full_text_search_config[:engine]}"
puts "  • Search Fields: #{User.full_text_search_config[:search_fields].join(', ')}"
puts "  • Fallback Multi-field: #{User.full_text_search_config[:fallback][:multi_field]}"
puts

puts 'Post model configuration:'
puts "  • Search Engine: #{Post.full_text_search_config[:engine]}"
puts "  • Search Fields: #{Post.full_text_search_config[:search_fields].join(', ')}"
puts "  • Fallback Multi-field: #{Post.full_text_search_config[:fallback][:multi_field]}"
puts

puts 'Article model configuration:'
puts "  • Search Engine: #{Article.full_text_search_config[:engine]}"
puts "  • Search Fields: #{Article.full_text_search_config[:search_fields].join(', ')}"
puts "  • Fallback Multi-field: #{Article.full_text_search_config[:fallback][:multi_field]}"
puts

# Performance demonstration
puts '=' * 80
puts '⚡ PERFORMANCE DEMONSTRATION'
puts '=' * 80

require 'benchmark'

search_terms = %w[developer design rails cloud javascript]

search_terms.each do |term|
  time = Benchmark.measure do
    User.full_text_search(term)
    Post.full_text_search(term)
    Article.full_text_search(term)
  end

  puts "🔍 Search for '#{term}' across all models: #{time.real.round(4)} seconds"
end

puts
puts '=' * 80
puts '🎉 FULL-TEXT SEARCH DEMONSTRATION COMPLETED!'
puts '=' * 80
puts
puts '✅ Features demonstrated:'
puts '   • Basic full-text search'
puts '   • Advanced search with filters'
puts '   • Search highlighting'
puts '   • Search suggestions/autocomplete'
puts '   • Search statistics'
puts '   • Configuration management'
puts '   • Performance benchmarking'
puts
puts '🔧 Supported search engines:'
puts '   • PostgreSQL full-text search (with ranking and trigram similarity)'
puts '   • Elasticsearch (with fuzzy matching and highlighting)'
puts '   • Fallback search (LIKE/ILIKE queries)'
puts
puts '📚 Usage examples:'
puts "   • Model.full_text_search('query')"
puts "   • Model.advanced_search(query: 'term', active: true)"
puts "   • Model.search_with_highlighting('query')"
puts "   • Model.search_suggestions('query')"
puts "   • Model.search_stats('query')"
puts
puts '🎯 Ready for production use!'
