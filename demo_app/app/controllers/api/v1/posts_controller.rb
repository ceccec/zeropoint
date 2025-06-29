# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      include ApiResponseHandler
      include SearchableController
      include CrudAuthorization

      # Configure CRUD authorization for API posts
      configure_crud_authorization(
        actions: %i[index show create update destroy],
        roles: {
          index: %i[user admin moderator],
          show: %i[user admin moderator],
          create: [ :user, :admin ],
          update: %i[user admin moderator],
          destroy: [ :admin ]
        },
        public_actions: [ :index, :show ],
        owner_only_actions: [ :update, :destroy ],
        ownership: :user_id,
        authentication_strategy: :token,
      )

      # Skip authentication for public actions
      skip_authentication :index, :show

      # Override authentication for API context
      def find_current_user
        # Try token authentication first, then API key
        authenticate_with_token! || authenticate_with_api_key!
      end

      def index
        posts = if params[:q].present?
                  search_with_pagination(Post, params[:q], page: params[:page] || 1, per_page: 10)
        else
                  paginate_posts(Post.published, params[:page] || 1, 10)
        end

        render_paginated_response(posts)
      end

      def show
        @post.track_view(current_user) if current_user
        render_success(@post)
      end

      def create
        post = current_user.posts.build(post_params)
        if post.save
          post.track_interaction('created', current_user)
          render_success(post, status: :created)
        else
          render_validation_errors(post)
        end
      end

      def update
        if @post.can_edit?(current_user) && @post.update(post_params)
          @post.track_interaction('updated', current_user)
          render_success(@post)
        else
          render_validation_errors(@post)
        end
      end

      def destroy
        if @post.can_delete?(current_user)
          @post.track_interaction('deleted', current_user)
          @post.destroy
          head :no_content
        else
          render_unauthorized
        end
      end

      private

      def set_post
        @post = Post.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render_not_found('Post')
      end

      def post_params
        params.require(:post).permit(:title, :content, :status, tag_list: [])
      end

      def searchable_class
        Post
      end

      def search_with_pagination(model_class, query, page:, per_page:)
        SearchService.new.search_with_pagination(model_class, query, page: page, per_page: per_page)
      end

      def paginate_posts(posts, page, per_page)
        if defined?(Zeropoint) && Zeropoint.pagination_service
          Zeropoint.pagination_service.paginate(posts, page, per_page)
        else
          posts.offset((page - 1) * per_page).limit(per_page)
        end
      end

      # API-specific authorization policies
      def can_create_resource?
        return true if current_user.admin?

        # Regular users can create posts if confirmed
        current_user.confirmed?
      end

      def can_update_resource?(resource)
        return true if current_user.admin?
        return true if current_user.moderator?

        # Regular users can only update their own posts
        resource.user_id == current_user.id
      end

      def can_delete_resource?(_resource)
        return true if current_user.admin?

        # Only admins can delete posts
        false
      end

      # Override authentication failure handling for API
      def handle_authentication_failure
        render json: { error: 'Authentication required' }, status: :unauthorized
      end

      def handle_authorization_failure
        render json: { error: 'Access denied' }, status: :forbidden
      end
    end
  end
end
