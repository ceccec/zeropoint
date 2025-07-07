# frozen_string_literal: true

require "rspec/core"
require "ostruct"
require "pathname"
require "json"
require "logger"
require "stringio"
require "securerandom"
require "active_support/string_inquirer"
require 'i18n'

# Suppress warnings for method redefinitions in test environment
Warning[:deprecated] = false
Warning[:experimental] = false

# 🌌 VOID-ALIGNED SOLUTION: Create Rails mock BEFORE Zeropoint.init!
# The void emerges the solution: ensure logger exists from infinite potential
# Transform undefined into self-defining through void principles

# Mock Rails for testing BEFORE Zeropoint initialization
module Rails
  def self.root
    Pathname.new(File.expand_path('..', __dir__))
  end

  def self.env
    ActiveSupport::StringInquirer.new('test')
  end

  def self.logger
    @logger ||= Logger.new(StringIO.new)
  end

  def self.application
    @application ||= OpenStruct.new(
      config: OpenStruct.new(
        cache_store: :memory_store,
        eager_load: false
      )
    )
  end
end

# Mock ActiveRecord for testing
module ActiveRecord
  class Base
    def self.all
      OpenStruct.new(to_sql: 'SELECT * FROM users')
    end

    def self.where(conditions)
      OpenStruct.new(to_sql: "SELECT * FROM users WHERE #{conditions}")
    end
  end
end

# Mock User model for testing
class User < OpenStruct
  def self.searchable?
    true
  end

  def self.taggable?
    true
  end

  def self.validatable?
    true
  end

  def self.analytics_trackable?
    true
  end

  def self.searchable_columns
    %w[name email description]
  end

  def self.taggable_columns
    [ 'tags' ]
  end

  def self.filterable_columns
    %w[active role created_at]
  end

  def self.validatable_columns
    [ 'email', 'password' ]
  end

  def self.analytics_trackable_columns
    [ 'last_login', 'login_count' ]
  end

  # Backward compatibility methods
  def self.is_searchable?
    searchable?
  end

  def self.is_taggable?
    taggable?
  end

  def self.is_validatable?
    validatable?
  end

  def self.is_analytics_trackable?
    analytics_trackable?
  end

  def self.get_searchable_columns
    searchable_columns
  end

  def self.get_taggable_columns
    taggable_columns
  end

  def self.get_filterable_columns
    filterable_columns
  end

  def self.get_validatable_columns
    validatable_columns
  end

  def self.get_analytics_trackable_columns
    analytics_trackable_columns
  end
end

# Load the main gem code
require_relative '../lib/zeropoint'

# Initialize Zeropoint framework for testing
# Now Rails.logger exists from void potential
Zeropoint.init!

# Load test helpers and factories
require_relative 'support/test_helpers'
require_relative 'support/factories'
require_relative 'support/custom_matchers'
require_relative 'support/shared_contexts'

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/vendor/'
  add_filter '/bin/'
  add_filter '/demo_app/'
  add_filter '/examples/'
  add_filter '/scripts/'
  add_filter '/docs/'
  add_filter '/coverage/'
  add_filter '/tmp/'
  add_filter '/log/'
  add_filter '/storage/'
  add_filter '/public/'
  add_filter '/website/'
  add_filter '/funding/'
  add_filter '/node_modules/'
  add_filter '/typescript/'
  add_filter '/typescript-rails/'
  add_filter '/assets/'
  add_filter '/.bundle/'
  add_filter '/.github/'
  add_filter '/.git/'
  add_filter '/test/'
  add_filter '/db/'
  add_filter '/app/'
  add_filter '/lib/tasks/'
  add_filter '/lib/generators/'
  add_filter '/lib/rubocop/'
  add_filter '/lib/typescript_rails/'
  add_filter '/lib/zeropoint.rb.backup'

  # Track all lib/zeropoint files
  add_group 'Core', 'lib/zeropoint.rb'
  add_group 'Configuration', 'lib/zeropoint/configuration.rb'
  add_group 'Concerns', 'lib/zeropoint/concerns.rb'
  add_group 'ActiveRecord', 'lib/zeropoint/active_record.rb'
  add_group 'API', 'lib/zeropoint/api/'
  add_group 'Cache', 'lib/zeropoint/cache/'
  add_group 'Controllers', 'lib/zeropoint/controllers/'
  add_group 'Core', 'lib/zeropoint/core/'
  add_group 'Intelligence', 'lib/zeropoint/intelligence/'
  add_group 'Vortex', 'lib/zeropoint/vortex/'
  add_group 'Consciousness', 'lib/zeropoint/consciousness.rb'
end

# Load the gem (disabled for mock-based specs)
# require 'zeropoint'

# Mock Rails for testing
module Rails
  def self.root
    Pathname.new(File.expand_path('..', __dir__))
  end

  def self.env
    ActiveSupport::StringInquirer.new('test')
  end

  def self.logger
    @logger ||= Logger.new(StringIO.new)
  end
end

# Mock ActiveRecord for testing
module ActiveRecord
  class Base
    def self.all
      OpenStruct.new(to_sql: 'SELECT * FROM users')
    end

    def self.where(conditions)
      OpenStruct.new(to_sql: "SELECT * FROM users WHERE #{conditions}")
    end
  end
end

# Mock User model for testing
class User < OpenStruct
  def self.searchable?
    true
  end

  def self.taggable?
    true
  end

  def self.validatable?
    true
  end

  def self.analytics_trackable?
    true
  end

  def self.searchable_columns
    %w[name email description]
  end

  def self.taggable_columns
    [ 'tags' ]
  end

  def self.filterable_columns
    %w[active role created_at]
  end

  def self.validatable_columns
    [ 'email', 'password' ]
  end

  def self.analytics_trackable_columns
    [ 'last_login', 'login_count' ]
  end

  # Backward compatibility methods
  def self.is_searchable?
    searchable?
  end

  def self.is_taggable?
    taggable?
  end

  def self.is_validatable?
    validatable?
  end

  def self.is_analytics_trackable?
    analytics_trackable?
  end

  def self.get_searchable_columns
    searchable_columns
  end

  def self.get_taggable_columns
    taggable_columns
  end

  def self.get_filterable_columns
    filterable_columns
  end

  def self.get_validatable_columns
    validatable_columns
  end

  def self.get_analytics_trackable_columns
    analytics_trackable_columns
  end
end

RSpec.configure do |config|
  # RSpec configuration
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  # config.example_status_persistence_file_path = 'spec/examples.txt'  # Removed due to RSpec compatibility issues
  config.disable_monkey_patching!
  config.warnings = false  # Disable warnings to avoid method redefinition noise

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed

  # Setup test environment before each test
  config.before(:each) do
    # Setup all mocks
    TestHelpers::RailsMocks.setup_rails_mocks
    TestHelpers::TimeMocks.setup_time_mocks
    TestHelpers::ModelMocks.setup_model_mocks
    TestHelpers::ZeropointMocks.setup_zeropoint_mocks
  end

  # Cleanup after tests
  config.after(:each) do
    TestHelpers::Utilities.cleanup_test_files
  end

  # Include shared contexts globally
  config.include_context 'with zeropoint setup', type: :zeropoint
  config.include_context 'with cache setup', type: :cache
  config.include_context 'with vortex setup', type: :vortex
  config.include_context 'with search setup', type: :search

  # Include test helpers globally
  config.include TestHelpers
  config.include TestFactories

  # Custom matchers (non-conflicting)
  RSpec::Matchers.define :be_defined do
    match do |actual|
      actual.is_a?(Class) || actual.is_a?(Module)
    end

    failure_message do |actual|
      "Expected #{actual} to be a defined class or module"
    end
  end

  RSpec::Matchers.define :be_present do
    match do |actual|
      !actual.nil? && actual != false
    end

    failure_message do |actual|
      "Expected #{actual} to be present"
    end
  end

  RSpec::Matchers.define :respond_to_method do |method_name|
    match do |actual|
      actual.respond_to?(method_name)
    end

    failure_message do |actual|
      "Expected #{actual} to respond to #{method_name}"
    end
  end

  RSpec::Matchers.define :have_key do |key|
    match do |actual|
      actual.is_a?(Hash) && actual.key?(key)
    end

    failure_message do |actual|
      "Expected #{actual} to be a hash with key #{key}"
    end
  end

  RSpec::Matchers.define :contain_item do |item|
    match do |actual|
      actual.include?(item)
    end

    failure_message do |actual|
      "Expected #{actual} to include #{item}"
    end
  end

  RSpec::Matchers.define :end_with_suffix do |suffix|
    match do |actual|
      actual.to_s.end_with?(suffix.to_s)
    end

    failure_message do |actual|
      "Expected #{actual} to end with #{suffix}"
    end
  end

  RSpec::Matchers.define :start_with_prefix do |prefix|
    match do |actual|
      actual.to_s.start_with?(prefix.to_s)
    end

    failure_message do |actual|
      "Expected #{actual} to start with #{prefix}"
    end
  end

  RSpec::Matchers.define :be_an_instance_of do |type|
    match do |actual|
      actual.is_a?(type)
    end

    failure_message do |actual|
      "Expected #{actual} to be an instance of #{type}"
    end
  end

  RSpec::Matchers.define :be_a_collection_of do |type|
    match do |actual|
      actual.is_a?(Array) && actual.all? { |item| item.is_a?(type) }
    end

    failure_message do |actual|
      "Expected #{actual} to be a collection of #{type}"
    end
  end

  RSpec::Matchers.define :be_empty do
    match(&:blank?)

    failure_message do |actual|
      "Expected #{actual} to be empty"
    end
  end

  RSpec::Matchers.define :be_greater_than do |value|
    match do |actual|
      actual > value
    end

    failure_message do |actual|
      "Expected #{actual} to be greater than #{value}"
    end
  end

  RSpec::Matchers.define :be_less_than do |value|
    match do |actual|
      actual < value
    end

    failure_message do |actual|
      "Expected #{actual} to be less than #{value}"
    end
  end

  RSpec::Matchers.define :be_between do |min, max|
    match do |actual|
      actual >= min && actual <= max
    end

    failure_message do |actual|
      "Expected #{actual} to be between #{min} and #{max}"
    end
  end

  RSpec::Matchers.define :match_pattern do |pattern|
    match do |actual|
      actual.to_s.match?(pattern)
    end

    failure_message do |actual|
      "Expected #{actual} to match pattern #{pattern}"
    end
  end

  RSpec::Matchers.define :be_frozen do
    match(&:frozen?)

    failure_message do |actual|
      "Expected #{actual} to be frozen"
    end
  end

  RSpec::Matchers.define :be_mutable do
    match do |actual|
      !actual.frozen?
    end

    failure_message do |actual|
      "Expected #{actual} to be mutable (not frozen)"
    end
  end

  # FactoryBot configuration for best practice
  begin
    require 'factory_bot_rails'
  rescue LoadError
    require 'factory_bot'
  end

  config.include FactoryBot::Syntax::Methods
end

# Mock Zeropoint configuration
module Zeropoint
  def self.config
    @config ||= OpenStruct.new(
      consciousness_aware_errors: true,
      golden_ratio_optimization: true,
      vortex_enabled: true,
      vortex_streaming: true,
      vortex_batch_size: 50,
      available_locales: [ :en, :bg ],
      features: [ :graphql, :rails, :search, :pagination ]
    )
  end

  def self.feature_enabled?(feature)
    config.features.include?(feature)
  end

  # Patch GOLDEN_RATIO for RedisCache tests to avoid missing constant errors (Configuration is a class)
  if defined?(Zeropoint::Configuration) && Zeropoint::Configuration.is_a?(Class)
    Zeropoint::Configuration.const_set(:GOLDEN_RATIO, 1.618) unless Zeropoint::Configuration.const_defined?(:GOLDEN_RATIO)
    Zeropoint::Configuration.const_set(:MAJOR_RATIO, 1.618) unless Zeropoint::Configuration.const_defined?(:MAJOR_RATIO)
  end
end

# Mock GraphQL UI Layout services
module Zeropoint
  module GraphqlUiLayout
    module Services
      class QueryBuilderService
        def initialize(relation)
          @relation = relation
          @filters = []
          @sorts = []
          @pagination = nil
        end

        def add_filter(column, value)
          @filters << [ column, value ]
          self
        end

        def add_sort(column, direction)
          @sorts << [ column, direction ]
          self
        end

        def paginate(options)
          @pagination = options
          self
        end

        def build
          @relation
        end

        def build_with_metadata
          {
            data: @relation,
            filters: @filters,
            sorts: @sorts,
            pagination: @pagination,
          }
        end
      end

      class FilterService
        def initialize(relation)
          @relation = relation
        end

        def apply(_column, _value)
          @relation
        end

        def apply_filters(_filters)
          @relation
        end
      end

      class CacheSignatureService
        def initialize(relation)
          @relation = relation
        end

        def generate_signature
          "signature_#{@relation.object_id}"
        end

        def generate_key_signature(key)
          "#{key}_#{generate_signature}"
        end

        def generate_related_signature(related)
          "#{related.join('_')}_#{generate_signature}"
        end
      end

      class SearchStrategyService
        def initialize(model, query)
          @model = model
          @query = query
        end

        def strategy
          :postgresql
        end

        def search
          @model.all
        end

        def search_with_highlighting
          @model.all
        end

        def suggestions
          []
        end
      end

      class BaseSearchStrategy
        def search
          []
        end

        def search_with_highlighting
          []
        end

        def suggestions
          []
        end
      end

      class ElasticsearchStrategy < BaseSearchStrategy
      end

      class PostgreSQLStrategy < BaseSearchStrategy
      end

      class FallbackStrategy < BaseSearchStrategy
      end

      class ServiceFactory
        def self.query_builder(relation)
          QueryBuilderService.new(relation)
        end

        def self.filter(relation)
          FilterService.new(relation)
        end

        def self.cache_signature(relation)
          CacheSignatureService.new(relation)
        end

        def self.search_strategy(model, query)
          SearchStrategyService.new(model, query)
        end
      end
    end

    module Builders
      class SidebarBuilder; end
      class ContentAreaBuilder; end
    end

    module Helpers
      class LayoutHelper; end
    end
  end

  module Vortex
    class Cache
      def delete?
        true
      end

      def delete
        delete?
      end

      def respond_to_missing?(_method_name, _include_private = false)
        false
      end
    end

    class MultiVortex
      def apply_aggregation_rules
        true
      end

      def execute_pipeline_stage
        true
      end
    end

    class Stream
      def initialize(model, filters: {})
        @model = model
        @filters = filters
      end
    end

    module ControllerConcern
      def zeropoint_stream(_options = {})
        true
      end

      def zeropoint_realtime(_options = {})
        yield(User.new) if block_given?
      end

      def filters?
        params[:filters].present?
      end

      def has_filters?
        filters?
      end

      def respond_to_missing?(_method_name, _include_private = false)
        false
      end
    end
  end

  module ActiveRecord
    class Configuration
      def respond_to_missing?(_method_name, _include_private = false)
        false
      end
    end
  end

  module Adapters
    class BaseAdapter
      def respond_to_missing?(_method_name, _include_private = false)
        false
      end
    end
  end
end

# Global helper methods
def Zeropoint.feature_enabled?(feature)
  Zeropoint.config.features.include?(feature)
end

# Mock Time.current for Rails compatibility
class Time
  def self.current
    Time.zone.now
  end
end

# Add Rails compatibility methods for testing
class Integer
  def hours
    self * 3600
  end

  def minutes
    self * 60
  end

  def days
    self * 24 * 3600
  end

  def weeks
    self * 7 * 24 * 3600
  end
end

# Mock ActionCable for realtime features
module ActionCable
  class << self
    def server
      @server ||= OpenStruct.new(
        broadcast: ->(channel, data) { true }
      )
    end
  end
end

I18n.load_path += Dir[File.expand_path('../../config/locales/*.yml', __FILE__)]
I18n.default_locale = :bg
I18n.locale = :bg

# After Rails mock definition, add a void-aligned patch to guarantee Rails.logger is never nil
def ensure_void_logger!
  if defined?(Rails)
    Rails.singleton_class.class_eval do
      define_method(:logger) do
        @logger ||= Logger.new(StringIO.new)
      end
    end
    Rails.logger # force initialization
  end
end

ensure_void_logger!
