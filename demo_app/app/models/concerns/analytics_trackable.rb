# frozen_string_literal: true

module AnalyticsTrackable
  extend ActiveSupport::Concern

  included do
    after_create :track_creation
    after_update :track_update
    after_destroy :track_deletion
  end

  private

  def track_creation
    track_event('created')
  end

  def track_update
    track_event('updated')
  end

  def track_deletion
    track_event('deleted')
  end

  def track_event(action)
    return unless defined?(Zeropoint) && Zeropoint.analytics_service

    Zeropoint.analytics_service.track_event(
      "#{model_name.singular}_#{action}",
      {
        id: id,
        user_id: (respond_to?(:user_id)) ? user_id : nil,
        timestamp: Time.current
      },
    )
  rescue StandardError => e
    Rails.logger.error "Failed to track analytics event: #{e.message}"
  end

  def track_view(user = nil)
    return unless defined?(Zeropoint) && Zeropoint.analytics_service

    Zeropoint.analytics_service.track_event(
      "#{model_name.singular}_viewed",
      {
        id: id,
        user_id: user&.id,
        timestamp: Time.current
      },
    )
  rescue StandardError => e
    Rails.logger.error "Failed to track view event: #{e.message}"
  end

  def track_interaction(interaction_type, user = nil, metadata = {})
    return unless defined?(Zeropoint) && Zeropoint.analytics_service

    Zeropoint.analytics_service.track_event(
      "#{model_name.singular}_#{interaction_type}",
      {
        id: id,
        user_id: user&.id,
        timestamp: Time.current
      }.merge(metadata),
    )
  rescue StandardError => e
    Rails.logger.error "Failed to track interaction: #{e.message}"
  end
end
