# frozen_string_literal: true

# Use Faker for generating random test data
require 'faker'

# Simplified factory system for DRY test data creation
module TestFactories
  # Base factory class with common functionality
  class BaseFactory
    def self.create(attributes = {})
      new.create!(attributes)
    end

    def self.build(attributes = {})
      new.build(attributes)
    end

    def self.create_list(count, attributes = {})
      Array.new(count) { create(attributes) }
    end

    def self.build_list(count, attributes = {})
      Array.new(count) { build(attributes) }
    end

    protected

    def merge_attributes(base_attrs, additional_attrs)
      base_attrs.merge(additional_attrs)
    end

    def generate_id
      rand(1000..9999)
    end

    def generate_uuid
      SecureRandom.uuid
    end

    def generate_timestamp
      Time.current
    end
  end

  # User factory
  class UserFactory < BaseFactory
    def create(attributes = {})
      # Use Faker for random names/emails, Time.current for timestamps
      base_attrs = {
        id: generate_id,
        name: Faker::Name.name, # Faker generates a random name
        email: Faker::Internet.email, # Faker generates a random email
        role: 'user',
        active: true,
        created_at: Time.current, # Use Time.current for timestamps
        updated_at: Time.current,
        tags: [ 'user' ],
        login_count: rand(0..100),
        last_login: Time.current - rand(1..30) * 24 * 3600, # days in seconds
      }
      User.new(merge_attributes(base_attrs, attributes))
    end

    def build(attributes = {})
      create(attributes)
    end

    # Traits as class methods for DRY usage
    class << self
      def admin(attributes = {})
        new.create(attributes.merge(role: 'admin', tags: [ 'admin', 'user' ]))
      end
      def moderator(attributes = {})
        new.create(attributes.merge(role: 'moderator', tags: [ 'moderator', 'user' ]))
      end
      def inactive(attributes = {})
        new.create(attributes.merge(active: false, tags: [ 'inactive', 'user' ]))
      end
      def with_posts(count = 3, attributes = {})
        user = new.create!(attributes)
        user.posts = PostFactory.create_list(count, user_id: user.id)
        user
      end
    end
  end

  # Post factory
  class PostFactory < BaseFactory
    def create(attributes = {})
      base_attrs = {
        id: generate_id,
        title: Faker::Lorem.sentence, # Faker generates a random sentence
        content: Faker::Lorem.paragraph, # Faker generates a random paragraph
        status: 'draft',
        user_id: generate_id,
        created_at: Time.current,
        updated_at: Time.current,
        tags: [ 'post' ],
        view_count: rand(0..1000),
        published_at: nil,
      }
      Post.new(merge_attributes(base_attrs, attributes))
    end

    def build(attributes = {})
      create(attributes)
    end

    # Traits as class methods for DRY usage
    class << self
      def published(attributes = {})
        new.create(attributes.merge(
          status: 'published',
          published_at: Time.current, # Use Time.current
          tags: [ 'published', 'post' ]
        ))
      end
      def draft(attributes = {})
        new.create(attributes.merge(
          status: 'draft',
          published_at: nil,
          tags: [ 'draft', 'post' ]
        ))
      end
      def archived(attributes = {})
        new.create(attributes.merge(
          status: 'archived',
          published_at: Time.current - 30 * 24 * 3600, # 30 days ago
          tags: [ 'archived', 'post' ]
        ))
      end
      def with_comments(count = 5, attributes = {})
        post = new.create!(attributes)
        post.comments = CommentFactory.create_list(count, post_id: post.id)
        post
      end
    end
  end

  # Comment factory
  class CommentFactory < BaseFactory
    def create(attributes = {})
      base_attrs = {
        id: generate_id,
        content: Faker::Lorem.sentence, # Faker generates a random sentence
        user_id: generate_id,
        post_id: generate_id,
        created_at: Time.current,
        updated_at: Time.current,
        tags: [ 'comment' ],
        approved: true,
      }
      OpenStruct.new(merge_attributes(base_attrs, attributes))
    end

    def build(attributes = {})
      create(attributes)
    end

    # Traits as class methods for DRY usage
    class << self
      def pending(attributes = {})
        new.create(attributes.merge(approved: false, tags: [ 'pending', 'comment' ]))
      end
      def approved(attributes = {})
        new.create(attributes.merge(approved: true, tags: [ 'approved', 'comment' ]))
      end
    end
  end

  # Cache data factory
  class CacheDataFactory < BaseFactory
    def create(attributes = {})
      base_attrs = {
        key: "cache_#{generate_id}",
        value: { data: 'test_value', timestamp: Time.current },
        expires_at: Time.current + 3600, # 1 hour in seconds
        metadata: { source: 'test', version: '1.0' },
        created_at: Time.current,
      }
      OpenStruct.new(merge_attributes(base_attrs, attributes))
    end

    def build(attributes = {})
      create(attributes)
    end

    # Traits as class methods for DRY usage
    class << self
      def expired(attributes = {})
        new.create(attributes.merge(expires_at: Time.current - 3600))
      end
      def persistent(attributes = {})
        new.create(attributes.merge(expires_at: nil))
      end
      def with_metadata(metadata = {}, attributes = {})
        new.create(attributes.merge(metadata: metadata))
      end
    end
  end

  # Vortex data factory
  class VortexDataFactory < BaseFactory
    def create(attributes = {})
      base_attrs = {
        pattern: "vortex_#{generate_id}",
        context: { test: true, timestamp: Time.current },
        uuid: SecureRandom.uuid,
        timestamp: Time.current,
        state: 'flowing',
        metadata: { source: 'test', version: '1.0' },
      }
      OpenStruct.new(merge_attributes(base_attrs, attributes))
    end

    def build(attributes = {})
      create(attributes)
    end

    # Traits as class methods for DRY usage
    class << self
      def stored(attributes = {})
        new.create(attributes.merge(state: 'stored'))
      end
      def flowing(attributes = {})
        new.create(attributes.merge(state: 'flowing'))
      end
      def offline(attributes = {})
        new.create(attributes.merge(state: 'offline'))
      end
      def with_context(context = {}, attributes = {})
        new.create(attributes.merge(context: context))
      end
    end
  end

  # Search query factory
  class SearchQueryFactory < BaseFactory
    def create(attributes = {})
      base_attrs = {
        query: Faker::Lorem.word, # Faker generates a random word
        filters: {},
        sort: { field: 'created_at', direction: 'desc' },
        pagination: { page: 1, per_page: 20 },
        metadata: { source: 'test' },
      }
      OpenStruct.new(merge_attributes(base_attrs, attributes))
    end

    def build(attributes = {})
      create(attributes)
    end

    # Traits as class methods for DRY usage
    class << self
      def with_filters(filters = {}, attributes = {})
        new.create(attributes.merge(filters: filters))
      end
      def with_sort(field = 'created_at', direction = 'desc', attributes = {})
        new.create(attributes.merge(sort: { field: field, direction: direction }))
      end
      def paginated(page = 1, per_page = 20, attributes = {})
        new.create(attributes.merge(pagination: { page: page, per_page: per_page }))
      end
    end
  end

  # Factory registry for easy access
  class Registry
    def self.user
      UserFactory
    end

    def self.post
      PostFactory
    end

    def self.comment
      CommentFactory
    end

    def self.cache_data
      CacheDataFactory
    end

    def self.vortex_data
      VortexDataFactory
    end

    def self.search_query
      SearchQueryFactory
    end
  end

  # Instance methods for RSpec helpers (DRY: available in all specs)
  def user(attributes = {})
    UserFactory.create(attributes)
  end
  def post(attributes = {})
    PostFactory.create(attributes)
  end
  def comment(attributes = {})
    CommentFactory.create(attributes)
  end
  def cache_data(attributes = {})
    CacheDataFactory.create(attributes)
  end
  def vortex_data(attributes = {})
    VortexDataFactory.create(attributes)
  end
  def search_query(attributes = {})
    SearchQueryFactory.create(attributes)
  end
  def users(count = 3, attributes = {})
    UserFactory.create_list(count, attributes)
  end
  def posts(count = 3, attributes = {})
    PostFactory.create_list(count, attributes)
  end
  def comments(count = 5, attributes = {})
    CommentFactory.create_list(count, attributes)
  end
  def cache_data_list(count = 3, attributes = {})
    CacheDataFactory.create_list(count, attributes)
  end
  def vortex_data_list(count = 3, attributes = {})
    VortexDataFactory.create_list(count, attributes)
  end
  def search_queries(count = 3, attributes = {})
    SearchQueryFactory.create_list(count, attributes)
  end
end

# Make Registry globally available for trait/class access
Registry = TestFactories::Registry unless defined?(Registry)
