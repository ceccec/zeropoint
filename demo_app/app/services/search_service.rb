# frozen_string_literal: true

class SearchService
  def initialize
    @graphql_search_service = defined?(Zeropoint) ? Zeropoint.search_service : nil
  end

  def search(model_class, query, options = {})
    return model_class.none if query.blank?

    if @graphql_search_service
      @graphql_search_service.search(model_class, query, options)
    else
      perform_basic_search(model_class, query, options)
    end
  end

  def search_with_pagination(model_class, query, page = 1, per_page = 20, options = {})
    results = search(model_class, query, options)
    paginate_results(results, page, per_page)
  end

  def search_by_tags(model_class, tags, options = {})
    return model_class.none if tags.blank?

    if model_class.respond_to?(:tagged_with)
      model_class.tagged_with(tags, options)
    else
      model_class.none
    end
  end

  def search_by_user(model_class, user, options = {})
    return model_class.none unless user

    if model_class.column_names.include?('user_id')
      model_class.where(user: user)
    else
      model_class.none
    end
  end

  def search_by_status(model_class, status, options = {})
    return model_class.none if status.blank?

    if model_class.respond_to?(status)
      model_class.send(status)
    elsif model_class.column_names.include?('status')
      model_class.where(status: status)
    else
      model_class.none
    end
  end

  def advanced_search(model_class, criteria = {})
    results = model_class.all

    criteria.each do |field, value|
      next if value.blank?

      results = apply_search_criteria(results, field, value)
    end

    results
  end

  private

  def perform_basic_search(model_class, query, options = {})
    if model_class.respond_to?(:search)
      model_class.search(query, options)
    elsif model_class.respond_to?(:search_by_content)
      model_class.search_by_content(query)
    else
      perform_ilike_search(model_class, query, options)
    end
  end

  def perform_ilike_search(model_class, query, options = {})
    searchable_columns = options[:columns] || %w[title content]
    conditions = searchable_columns.map { |col| "#{col} ILIKE :query" }.join(' OR ')
    model_class.where(conditions, query: "%#{query}%")
  end

  def paginate_results(results, page, per_page)
    if results.respond_to?(:page)
      results.page(page).per(per_page)
    elsif defined?(Kaminari) && results.respond_to?(:page)
      results.page(page).per(per_page)
    else
      results.offset((page - 1) * per_page).limit(per_page)
    end
  end

  def apply_search_criteria(results, field, value)
    case field.to_sym
    when :tags
      search_by_tags(results.class, value)
    when :user_id
      results.where(user_id: value)
    when :status
      search_by_status(results.class, value)
    when :date_range
      apply_date_range_filter(results, value)
    when :category
      results.where(category: value) if results.column_names.include?('category')
    else
      results
    end
  end

  def apply_date_range_filter(results, date_range)
    return results unless date_range.is_a?(Hash)

    start_date = date_range[:start]
    end_date = date_range[:end]

    if start_date && end_date
      results.where(created_at: start_date..end_date)
    elsif start_date
      results.where('created_at >= ?', start_date)
    elsif end_date
      results.where('created_at <= ?', end_date)
    else
      results
    end
  end
end
