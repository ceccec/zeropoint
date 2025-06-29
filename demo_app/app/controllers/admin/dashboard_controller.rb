# frozen_string_literal: true

module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @users_count = User.count
      @posts_count = Post.count
      @comments_count = Comment.count
      @likes_count = Like.count
      @follows_count = Follow.count
    end

    private

    def require_admin
      redirect_to root_path, alert: t('demo.messages.not_authorized') unless current_user&.admin?
    end
  end
end
