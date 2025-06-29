# frozen_string_literal: true

class AnalyticsService
  def initialize
    @tracker = (defined?(Zeropoint)) ? Zeropoint.analytics_service : nil
  end

  def track_page_view(page:, user: nil, metadata: {})
    track_event('page_view', {
      page: page,
      timestamp: Time.current
    }.merge(metadata), user)
  end

  def track_search(query:, results_count:, user: nil, metadata: {})
    track_event('search_performed', {
      query: query,
      results_count: results_count,
      timestamp: Time.current
    }.merge(metadata), user)
  end

  def track_user_action(action:, user:, metadata: {})
    track_event("user_#{action}", {
      user_id: user.id,
      timestamp: Time.current
    }.merge(metadata), user)
  end

  def track_resource_action(action:, resource:, user: nil, metadata: {})
    track_event("#{resource.class.model_name.singular}_#{action}", {
      resource_id: resource.id,
      resource_type: resource.class.name,
      timestamp: Time.current
    }.merge(metadata), user)
  end

  def track_performance(metric:, value:, user: nil, metadata: {})
    track_event('performance_metric', {
      metric: metric,
      value: value,
      timestamp: Time.current
    }.merge(metadata), user)
  end

  def track_error(error:, user: nil, metadata: {})
    track_event('error_occurred', {
      error_type: error.class.name,
      error_message: error.message,
      timestamp: Time.current
    }.merge(metadata), user)
  end

  private

  def track_event(event_name, properties, user = nil)
    if @tracker
      @tracker.track_event(event_name, properties, user)
    else
      Rails.logger.info "Analytics Event: #{event_name} - #{properties}"
    end
  rescue StandardError => e
    Rails.logger.error "Failed to track analytics event: #{e.message}"
  end
end
