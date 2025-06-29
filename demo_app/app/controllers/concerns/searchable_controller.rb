# frozen_string_literal: true

module SearchableController
  extend ActiveSupport::Concern

  def search
    query = params[:q]
    return redirect_to root_path, alert: t('demo.search_blank') if query.blank?

    perform_search(query)
    track_search_analytics(query)
    respond_to_formats
  end

  private

  def perform_search(query, options = {})
    default_options = {
      include: %i[user tags],
      limit: 20
    }.merge(options)

    @search_results = if defined?(Zeropoint) && Zeropoint.search_service
                        Zeropoint.search_service.search(searchable_class, query, default_options)
    else
                        searchable_class.search(query, default_options)
    end
  end

  def track_search_analytics(query)
    return unless defined?(Zeropoint) && Zeropoint.analytics_service

    Zeropoint.analytics_service.track_event('search_performed', {
                                              query: query,
                                              results_count: @search_results.count,
                                              user_id: current_user&.id,
                                              controller: controller_name
                                            })
  end

  def setup_search_and_pagination
    return if params[:q].blank?

    @search_results = if defined?(Zeropoint) && Zeropoint.search_service
                        Zeropoint.search_service.search(searchable_class, params[:q])
    else
                        searchable_class.search(params[:q])
    end

    @paginated_results = if defined?(Zeropoint) && Zeropoint.pagination_service
                           Zeropoint.pagination_service.paginate(searchable_class.published, params[:page] || 1,
                                                                 12)
    else
                           searchable_class.published.page(params[:page] || 1).per(12)
    end
  end

  # This method should be implemented by the including class
  def searchable_class
    raise NotImplementedError, "#{self.class} must implement #searchable_class"
  end
end
