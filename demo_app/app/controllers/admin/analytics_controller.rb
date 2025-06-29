# frozen_string_literal: true

module Admin
  class AnalyticsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @analytics_data = {
        total_users: User.count,
        total_posts: Post.count,
        total_comments: Comment.count,
        total_likes: Like.count,
        total_follows: Follow.count,
        trending_tags: Post.tag_counts_on(:tags).order('count DESC').limit(10),
        recent_activity: Post.recent.limit(10)
      }
      @analytics_service_info = Zeropoint.analytics_service&.info
    end

    private

    def require_admin
      redirect_to root_path, alert: t('demo.messages.not_authorized') unless current_user&.admin?
    end
  end
end
