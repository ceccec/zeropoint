# frozen_string_literal: true

module Authorizable
  extend ActiveSupport::Concern

  included do
    # Define authorization methods
    def user_can?(*args, &block)
      user&.can?(*args, &block)
    end
  end

  def can_edit?(user)
    return false unless user

    user.admin? || (respond_to?(:user_id) && user_id == user.id)
  end

  def can_delete?(user)
    return false unless user

    user.admin? || (respond_to?(:user_id) && user_id == user.id)
  end

  def can_view?(user)
    return true unless respond_to?(:published?)

    published? || can_edit?(user)
  end

  def can_create?(user)
    return false unless user

    user.confirmed?
  end

  def owned_by?(user)
    return false unless user && respond_to?(:user_id)

    user_id == user.id
  end

  def editable_by?(user)
    can_edit?(user)
  end

  def deletable_by?(user)
    can_delete?(user)
  end

  def viewable_by?(user)
    can_view?(user)
  end

  def creatable_by?(user)
    can_create?(user)
  end

  class_methods do
    def accessible_by(user)
      return all if user&.admin?

      if respond_to?(:published)
        published
      else
        all
      end
    end

    def editable_by(user)
      return all if user&.admin?

      where(user: user) if column_names.include?('user_id')
    end

    def deletable_by(user)
      editable_by(user)
    end
  end
end
