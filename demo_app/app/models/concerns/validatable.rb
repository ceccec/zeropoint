# frozen_string_literal: true

module Validatable
  extend ActiveSupport::Concern

  included do
    # Common validations
    validates :created_at, presence: true
    validates :updated_at, presence: true
  end

  class_methods do
    def validates_email(field, options = {})
      validates field, presence: true, uniqueness: true,
                       format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t('activerecord.errors.models.user.attributes.email.invalid') },
                       **options
    end

    def validates_username(field, options = {})
      validates field, presence: true, uniqueness: true,
                       length: { minimum: 3, maximum: 30 },
                       format: { with: /\A[a-zA-Z0-9_]+\z/, message: I18n.t('activerecord.errors.models.user.attributes.username.invalid') },
                       **options
    end

    def validates_password(field, options = {})
      validates field, length: { minimum: 6 }, if: -> { send(field).present? }, **options
    end

    def validates_title(field, options = {})
      validates field, presence: true,
                       length: { minimum: 5, maximum: 200 },
                       **options
    end

    def validates_content(field, options = {})
      validates field, presence: true,
                       length: { minimum: 10, maximum: 10_000 },
                       **options
    end

    def validates_status(field, statuses, options = {})
      validates field,
                inclusion: { in: statuses, message: I18n.t('activerecord.errors.models.post.attributes.status.inclusion') }, **options
    end

    def validates_bio(field, options = {})
      validates field, length: { maximum: 500 }, **options
    end

    def validates_slug(field, options = {})
      validates field, presence: true, uniqueness: true,
                       format: { with: /\A[a-z0-9-]+\z/, message: I18n.t('activerecord.errors.models.post.attributes.slug.invalid') },
                       **options
    end
  end
end
