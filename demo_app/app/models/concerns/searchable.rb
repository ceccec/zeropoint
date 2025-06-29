# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  included do
    # Include pg_search if available
    include PgSearch::Model if defined?(PgSearch)

    # Define search scope if pg_search is available
    if defined?(PgSearch)
      pg_search_scope :search_by_content,
                      against: searchable_columns,
                      using: {
                        tsearch: { prefix: true, dictionary: 'english' }
                      }
    end

    # Define class method for search
    scope :search, ->(query, options = {}) { perform_search(query, options) }
  end

  class_methods do
    def perform_search(query, options = {})
      return all if query.blank?

      if defined?(PgSearch) && respond_to?(:search_by_content)
        search_by_content(query)
      elsif defined?(Searchkick) && respond_to?(:search)
        search(query, options)
      else
        # Fallback to basic ILIKE search
        where(search_conditions(query))
      end
    end

    def searchable_columns
      %i[title content]
    end

    def search_conditions(_query)
      searchable_columns.map { |column| "#{column} ILIKE :query" }.join(' OR ')
    end

    def searchable_content
      searchable_columns.join(' ')
    end
  end

  def searchable_content
    searchable_columns.filter_map { |column| send(column) }.join(' ')
  end

  private

  def searchable_columns
    self.class.searchable_columns
  end
end
