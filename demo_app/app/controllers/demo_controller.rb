# frozen_string_literal: true

class DemoController < ActionController::Base
  include ApplicationControllerConfigurable
  include SearchableController

  before_action :authenticate_user!, except: %i[index health_check]
  before_action :set_demo_data

  def index
    load_demo_data
    setup_search_and_pagination
    track_page_analytics
    respond_to_formats
  end

  def health_check
    load_health_data
    respond_to_formats
  end

  private

  def set_demo_data
    @demo_config = Zeropoint.configuration
    @theme = Zeropoint.theme
    @app_config = Zeropoint.config
  end

  def load_demo_data
    @posts = Post.published.recent.limit(6)
    @trending_posts = Post.trending.limit(5)
    @users = User.active.limit(8)
  end

  def setup_search_and_pagination
    return if params[:q].blank?

    @search_results = SearchService.new.search(Post, params[:q])
    @paginated_posts = paginate_posts(Post.published, params[:page] || 1, 12)
  end

  def track_page_analytics
    AnalyticsService.new.track_page_view(
      page: 'home',
      user: current_user,
      metadata: { posts_count: @posts.count },
    )
  end

  def load_health_data
    @health_data = Zeropoint.health_check
    @available_gems = Zeropoint::DependencyContainer.instance.adapters_info
    @services_status = build_services_status
  end

  def build_services_status
    {
      search: Zeropoint.search_service.info,
      pagination: Zeropoint.pagination_service.info,
      authorization: Zeropoint.authorization_service.info,
      unified_api: Zeropoint.unified_api_service.info
    }
  end

  def respond_to_formats
    respond_to do |format|
      format.html
      format.json { render json: build_json_response }
    end
  end

  def build_json_response
    case action_name
    when 'index'
      { posts: @posts, trending: @trending_posts, users: @users }
    when 'search'
      { results: @search_results, query: params[:q] }
    when 'health_check'
      @health_data
    end
  end

  def searchable_class
    Post
  end

  def paginate_posts(posts, page, per_page)
    if defined?(Zeropoint) && Zeropoint.pagination_service
      Zeropoint.pagination_service.paginate(posts, page, per_page)
    else
      posts.offset((page - 1) * per_page).limit(per_page)
    end
  end

  # Demo methods for showcasing functionality
  def demo_search
    {
      basic_search: Post.where('title ILIKE ?', '%rails%').limit(5),
      service_search: SearchService.new.search(Post, 'rails', limit: 5),
      tagged_search: Post.tagged_with('ruby').limit(5)
    }
  end

  def demo_pagination
    posts = Post.published
    {
      basic_pagination: posts.offset(0).limit(5),
      service_pagination: paginate_posts(posts, 1, 5),
      kaminari_pagination: (defined?(Kaminari)) ? posts.page(1).per(5) : 'Kaminari not available'
    }
  end

  def demo_authorization
    user = current_user || User.first
    post = Post.first

    {
      can_read: post.can_view?(user),
      can_create: post.can_create?(user),
      can_update: post.can_edit?(user),
      can_delete: post.can_delete?(user),
      user_roles: user&.roles&.pluck(:name) || []
    }
  end

  def demo_cache
    cache_service = Zeropoint.cache_service
    return { status: 'Cache service not available' } unless cache_service

    test_key = "demo_test_#{Time.current.to_i}"
    test_value = { message: 'Hello from cache!', timestamp: Time.current }

    cache_service.set(test_key, test_value, 60)
    retrieved_value = cache_service.get(test_key)

    {
      set_operation: 'success',
      get_operation: (retrieved_value == test_value) ? 'success' : 'failed',
      test_key: test_key,
      test_value: test_value,
      retrieved_value: retrieved_value
    }
  end

  def demo_analytics
    analytics_service = AnalyticsService.new
    event_data = {
      event_type: 'demo_test',
      user_id: current_user&.id,
      timestamp: Time.current,
      properties: { demo: true, controller: 'demo' }
    }

    analytics_service.track_user_action(action: 'demo_test', user: current_user, metadata: event_data[:properties])

    {
      event_tracked: 'demo_test',
      event_data: event_data,
      status: 'success'
    }
  end

  def generate_performance_metrics
    {
      database_queries: ActiveRecord::Base.connection.query_cache.keys.count,
      memory_usage: `ps -o rss= -p #{Process.pid}`.to_i / 1024, # MB
      uptime: Time.current - Rails.application.config.start_time,
      cache_hits: cache_service.info[:keys_count] || 0
    }
  rescue StandardError
    { error: 'Could not generate metrics' }
  end

  def cache_service
    @cache_service ||= Zeropoint::Core::CacheService.new(Zeropoint.configuration)
  end
end
