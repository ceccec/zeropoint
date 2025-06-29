# frozen_string_literal: true

class PostsController < ApplicationController
  include CrudOperations
  include CrudAuthorization
  include FilterableController

  # Configure CRUD authorization
  configure_crud_authorization(
    actions: %i[index show new create edit update destroy],
    public_actions: [ :index, :show ],
    owner_only_actions: %i[edit update destroy],
    ownership: :user_id,
  )

  # Skip authentication for public actions
  skip_authentication :index, :show

  # Override index to use filtering
  def index
    @filters = extract_filters
    @query = extract_query
    @options = extract_options

    # Apply authorization filters
    @options[:authorization_filter] = ->(relation) { apply_authorization_filter(relation) }

    @posts = filter_resources(@filters, @query, @options)

    respond_to_formats
  end

  # Override search to use filtering
  def search
    @query = params[:q]
    return redirect_to posts_path, alert: t('demo.search_blank') if @query.blank?

    @filters = extract_filters
    @options = extract_options

    # Apply authorization filters
    @options[:authorization_filter] = ->(relation) { apply_authorization_filter(relation) }

    @posts = filter_resources(@filters, @query, @options)

    respond_to_formats
  end

  # Show filtered posts by tag
  def tagged
    @tag = params[:tag]
    @filters = { tagged_with: @tag }
    @options = extract_options

    # Apply authorization filters
    @options[:authorization_filter] = ->(relation) { apply_authorization_filter(relation) }

    @posts = filter_resources(@filters, nil, @options)

    respond_to_formats
  end

  # Show posts by user
  def by_user
    @user = User.find(params[:user_id])
    @filters = { user_id: @user.id }
    @options = extract_options

    # Apply authorization filters
    @options[:authorization_filter] = ->(relation) { apply_authorization_filter(relation) }

    @posts = filter_resources(@filters, nil, @options)

    respond_to_formats
  end

  # Advanced filtering demo
  def advanced_filter
    @filters = extract_advanced_filters
    @query = extract_query
    @options = extract_options

    # Apply authorization filters
    @options[:authorization_filter] = ->(relation) { apply_authorization_filter(relation) }

    @posts = filter_resources(@filters, @query, @options)

    respond_to_formats
  end

  # Filter statistics
  def filter_stats
    @filters = extract_filters
    @query = extract_query

    stats = {
      total_posts: Post.count,
      filtered_posts: filter_resources(@filters, @query, {}).count,
      filters_applied: @filters.keys,
      search_performed: @query.present?,
      popular_tags: Post.tag_counts.limit(10),
      recent_posts: Post.recent.limit(5),
      popular_posts: Post.popular.limit(5)
    }

    render json: stats
  end

  private

  def resource_class
    Post
  end

  def resource_params
    params.require(:post).permit(:title, :content, :status, tag_list: [])
  end

  # Apply authorization filter
  def apply_authorization_filter(relation)
    if current_user&.admin?
      relation
    elsif current_user
      relation.published.or(relation.where(user: current_user))
    else
      relation.published
    end
  end

  # Extract advanced filters
  def extract_advanced_filters
    filters = extract_filters

    # Add advanced filter options
    if params[:date_range].present?
      filters[:created_at] = {
        date_range: {
          start: params[:date_range][:start],
          end: params[:date_range][:end]
        }
      }
    end

    filters[:status] = { in: Array(params[:status_in]) } if params[:status_in].present?

    filters[:popular] = params[:popular] == 'true' if params[:popular].present?

    filters[:has_comments] = params[:has_comments] == 'true' if params[:has_comments].present?

    filters[:recent_days] = params[:recent_days].to_i if params[:recent_days].present?

    filters
  end

  # Override build_json_response for posts
  def build_json_response
    case action_name
    when 'index', 'search', 'tagged', 'by_user', 'advanced_filter'
      {
        posts: @posts,
        filters: @filters,
        query: @query,
        pagination: build_pagination_info,
        metadata: build_metadata,
        filter_options: @filter_service.filter_options
      }
    else
      super
    end
  end

  # Override build_metadata for posts
  def build_metadata
    super.merge({
                  total_posts: Post.count,
                  published_posts: Post.published.count,
                  draft_posts: Post.draft.count,
                  popular_tags: Post.tag_counts.limit(5).pluck(:name),
                  recent_authors: User.joins(:posts).where('posts.created_at > ?',
                                                           7.days.ago).distinct.limit(5).pluck(:username)
                })
  end
end
