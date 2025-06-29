# frozen_string_literal: true

class User < ApplicationRecord
  # Include concerns
  include Taggable
  include AnalyticsTrackable
  include Filterable

  # Configure filterable options
  filterable(
    searchable_columns: %w[username email first_name last_name bio],
    filterable_columns: %w[username email first_name last_name bio confirmed_at last_sign_in_at],
    excluded_columns: %w[id password_digest],
    custom_filters: {},
    default_filters: {},
  )

  # Rails 8 Authentication
  has_secure_password

  # Email validation
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t('activerecord.errors.models.user.attributes.email.invalid') }

  # Associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :follows, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy, inverse_of: :follower
  has_many :followers, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy, inverse_of: :followed

  # Roles
  rolify
  after_create :assign_default_role

  # Validations
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :bio, length: { maximum: 500 }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }

  # Scopes
  scope :active, -> { where('last_sign_in_at > ?', 30.days.ago) }
  scope :admins, -> { with_role(:admin) }
  scope :moderators, -> { with_role(:moderator) }

  # Custom filters for User model
  add_custom_filter :with_role do |relation, _field, value|
    relation.with_role(value) if respond_to?(:with_role)
  end

  add_custom_filter :active_users do |relation, _field, value|
    if value
      relation.where('last_sign_in_at > ?', 30.days.ago)
    else
      relation.where('last_sign_in_at <= ? OR last_sign_in_at IS NULL', 30.days.ago)
    end
  end

  add_custom_filter :confirmed do |relation, _field, value|
    if value
      relation.where.not(confirmed_at: nil)
    else
      relation.where(confirmed_at: nil)
    end
  end

  add_custom_filter :with_posts do |relation, _field, value|
    if value
      relation.joins(:posts).distinct
    else
      relation.where.missing(:posts)
    end
  end

  add_custom_filter :post_count do |relation, _field, value|
    relation.joins(:posts).group('users.id').having('COUNT(posts.id) >= ?', value.to_i)
  end

  # Instance methods
  def admin?
    has_role?(:admin)
  end

  def moderator?
    has_role?(:moderator)
  end

  def confirmed?
    email_confirmed_at.present?
  end

  def full_name
    "#{first_name} #{last_name}".strip.presence || username
  end

  def avatar_url
    (avatar.attached?) ? avatar : "https://ui-avatars.com/api/?name=#{full_name}&background=random"
  end

  def following?(user)
    follows.exists?(followed: user)
  end

  def follow(user)
    follows.create(followed: user) unless following?(user)
  end

  def unfollow(user)
    follows.find_by(followed: user)&.destroy
  end

  def can?(action, resource)
    case action.to_sym
    when :read
      true
    when :create
      confirmed?
    when :update, :destroy
      admin? || (resource.respond_to?(:user_id) && resource.user_id == id)
    when :manage
      admin?
    else
      false
    end
  end

  # Rails 8 Authentication methods
  def self.authenticate(email, password)
    user = find_by(email: email)
    user&.authenticate(password)
  end

  def confirm_email!
    update!(email_confirmed_at: Time.current)
  end

  def send_confirmation_email
    # In a real app, you'd use ActionMailer
    Rails.logger.info "Confirmation email sent to #{email}"
  end

  def send_password_reset_email
    # In a real app, you'd use ActionMailer
    Rails.logger.info "Password reset email sent to #{email}"
  end

  # Override custom filter for User-specific logic
  def self.apply_custom_filter(relation, field, value)
    case field.to_s
    when 'with_role'
      relation.with_role(value) if respond_to?(:with_role)
    when 'active_users'
      if value
        relation.where('last_sign_in_at > ?', 30.days.ago)
      else
        relation.where('last_sign_in_at <= ? OR last_sign_in_at IS NULL', 30.days.ago)
      end
    when 'confirmed'
      if value
        relation.where.not(confirmed_at: nil)
      else
        relation.where(confirmed_at: nil)
      end
    when 'with_posts'
      if value
        relation.joins(:posts).distinct
      else
        relation.where.missing(:posts)
      end
    when 'post_count'
      relation.joins(:posts).group('users.id').having('COUNT(posts.id) >= ?', value.to_i)
    else
      super
    end
  end

  private

  def assign_default_role
    add_role(:user) if roles.blank?
  end
end
