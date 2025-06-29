# frozen_string_literal: true

module Paginatable
  extend ActiveSupport::Concern

  private

  def paginate_collection(collection, page = 1, per_page = 20)
    if defined?(Zeropoint) && Zeropoint.pagination_service
      Zeropoint.pagination_service.paginate(collection, page, per_page)
    elsif collection.respond_to?(:page)
      collection.page(page).per(per_page)
    else
      collection.offset((page - 1) * per_page).limit(per_page)
    end
  end

  def paginate_with_search(collection, query, page = 1, per_page = 20)
    if query.present?
      search_results = search_service.search(collection.class, query)
      paginate_collection(search_results, page, per_page)
    else
      paginate_collection(collection, page, per_page)
    end
  end

  def pagination_params
    {
      page: params[:page] || 1,
      per_page: params[:per_page] || 20
    }
  end

  def pagination_metadata(collection)
    return {} unless collection.respond_to?(:current_page)

    {
      current_page: collection.current_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count,
      per_page: collection.limit_value || collection.per_page
    }
  end
end
