# frozen_string_literal: true

module Taggable
  extend ActiveSupport::Concern

  included do
    # Include acts_as_taggable_on if available
    acts_as_taggable_on :tags, :categories if defined?(ActsAsTaggableOn)
  end

  class_methods do
    def tagged_with(tag)
      return all unless defined?(ActsAsTaggableOn)

      tagged_with(tag)
    end

    def popular_tags(limit = 10)
      return [] unless defined?(ActsAsTaggableOn)

      ActsAsTaggableOn::Tag.joins(:taggings)
        .where(taggings: { context: 'tags' })
        .group('tags.id')
        .order('COUNT(taggings.id) DESC')
        .limit(limit)
    end
  end

  def tag_list_display
    return [] unless respond_to?(:tag_list)

    tag_list
  end

  def category_list_display
    return [] unless respond_to?(:category_list)

    category_list
  end

  def add_tags(*tags)
    return unless respond_to?(:tag_list=)

    self.tag_list = (tag_list_display + tags.flatten).uniq
  end

  def remove_tags(*tags)
    return unless respond_to?(:tag_list=)

    self.tag_list = (tag_list_display - tags.flatten)
  end

  def has_tag?(tag)
    return false unless respond_to?(:tag_list)

    tag_list_display.include?(tag.to_s)
  end

  def has_category?(category)
    return false unless respond_to?(:category_list)

    category_list_display.include?(category.to_s)
  end
end
