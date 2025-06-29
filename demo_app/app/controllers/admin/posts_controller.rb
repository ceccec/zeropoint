# frozen_string_literal: true

module Admin
  class PostsController < ApplicationController
    include CrudOperations
    include CrudAuthorization

    # Configure CRUD authorization for admin posts
    configure_crud_authorization(
      actions: %i[index show new create edit update destroy],
      roles: {
        index: [ :admin, :moderator ],
        show: [ :admin, :moderator ],
        new: [ :admin ],
        create: [ :admin ],
        edit: [ :admin, :moderator ],
        update: [ :admin, :moderator ],
        destroy: [ :admin ]
      },
      admin_only_actions: [ :destroy ],
      ownership: :user_id,
    )

    # Skip authentication for public actions (if any)
    skip_authentication :index, :show

    # Override authorization for admin-specific needs
    def action_authorized?
      return true if current_user&.admin?
      return true if current_user&.moderator? && moderator_allowed_action?

      super
    end

    before_action :set_post, only: %i[show edit update destroy]

    def index
      @resources = Post.includes(:user, :tags).order(:created_at)
      respond_to_formats
    end

    def show; end

    def edit; end

    def update
      if @post.update(post_params)
        redirect_to admin_post_path(@post), notice: t('demo.post_updated')
      else
        render :edit
      end
    end

    def destroy
      @post.destroy
      redirect_to admin_posts_path, notice: t('demo.post_deleted')
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def resource_class
      Post
    end

    def resource_params
      params.require(:post).permit(:title, :content, :status, tag_list: [])
    end

    def moderator_allowed_action?
      # Moderators can edit posts but not delete them
      %i[index show edit update].include?(action_name.to_sym)
    end

    # Override resource loading for admin scope
    def set_resource
      @resource = Post.find(params[:id])
    end

    # Admin-specific authorization policies
    def can_update_resource?(resource)
      return true if current_user.admin?
      return true if current_user.moderator? && resource.published?

      false
    end

    def can_delete_resource?(_resource)
      current_user.admin?
    end
  end
end
