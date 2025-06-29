# frozen_string_literal: true

class Post < ApplicationRecord
  # Include concerns
  include Searchable
  include Taggable
  include Authorizable
  include AnalyticsTrackable
  include Filterable

  # Configure filterable options
  filterable(
    searchable_columns: %w[title content slug],
    filterable_columns: %w[title content status user_id created_at updated_at views],
    excluded_columns: %w[id],
    custom_filters: {},
    default_filters: { status: 'published' },
  )

  # Associations
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_by, through: :likes, source: :user
  has_many_attached :images

  # Validations
  validates :title, presence: true, length: { minimum: 5, maximum: 200 }
  validates :content, presence: true, length: { minimum: 10, maximum: 10_000 }
  validates :status,
            inclusion: { in: %w[draft published archived],
                         message: I18n.t('activerecord.errors.models.post.attributes.status.inclusion') }

  # Scopes
  scope :published, -> { where(status: 'published') }
  scope :draft, -> { where(status: 'draft') }
  scope :archived, -> { where(status: 'archived') }
  scope :recent, -> { order(created_at: :desc) }
  scope :popular, -> { joins(:likes).group('posts.id').order('COUNT(likes.id) DESC') }
  scope :by_user, ->(user) { where(user: user) }

  # Pagination
  paginates_per 12 if defined?(Kaminari)

  # Callbacks
  before_save :set_slug
  after_create :notify_followers

  # Custom filters for Post model
  add_custom_filter :tagged_with do |relation, _field, value|
    relation.tagged_with(value) if respond_to?(:tagged_with)
  end

  add_custom_filter :by_author do |relation, _field, value|
    relation.joins(:user).where(users: { username: value })
  end

  add_custom_filter :popular do |relation, _field, value|
    if value
      relation.joins(:likes).group('posts.id').having('COUNT(likes.id) >= ?', 5)
    else
      relation
    end
  end

  add_custom_filter :recent_days do |relation, _field, value|
    days = value.to_i
    relation.where(created_at: days.days.ago..)
  end

  add_custom_filter :has_comments do |relation, _field, value|
    if value
      relation.joins(:comments).distinct
    else
      relation.where.missing(:comments)
    end
  end

  # Instance methods
  def slug
    title.parameterize
  end

  def excerpt(length = 150)
    content.truncate(length, separator: ' ')
  end

  def liked_by?(user)
    return false unless user

    likes.exists?(user: user)
  end

  def like_count
    likes.count
  end

  def comment_count
    comments.count
  end

  def view_count
    views || 0
  end

  def increment_view_count!
    increment(:views)
    save!
  end

  def published?
    status == 'published'
  end

  def draft?
    status == 'draft'
  end

  def archived?
    status == 'archived'
  end

  def searchable_content
    [ title, content, tag_list.join(' ') ].compact.join(' ')
  end

  # Class methods
  def self.trending
    joins(:likes)
      .where('posts.created_at > ?', 7.days.ago)
      .group('posts.id')
      .order('COUNT(likes.id) DESC')
      .limit(10)
  end

  # Override custom filter for Post-specific logic
  def self.apply_custom_filter(relation, field, value)
    case field.to_s
    when 'tagged_with'
      relation.tagged_with(value) if respond_to?(:tagged_with)
    when 'by_author'
      relation.joins(:user).where(users: { username: value })
    when 'popular'
      if value
        relation.joins(:likes).group('posts.id').having('COUNT(likes.id) >= ?', 5)
      else
        relation
      end
    when 'recent_days'
      days = value.to_i
      relation.where(created_at: days.days.ago..)
    when 'has_comments'
      if value
        relation.joins(:comments).distinct
      else
        relation.where.missing(:comments)
      end
    else
      super
    end
  end

  private

  def set_slug
    self.slug = title.parameterize if title_changed?
  end

  def notify_followers
    return unless published?

    user.followers.each do |follower|
      # In a real app, you'd use a notification service
      Rails.logger.info "Notifying #{follower.email} about new post: #{title}"
    end
  end
end
