# frozen_string_literal: true

class PostService
  def initialize(user = nil)
    @user = user
    @analytics_service = AnalyticsService.new
  end

  def create_post(params)
    post = @user.posts.build(params)

    if post.save
      @analytics_service.track_resource_action(action: 'created', resource: post, user: @user)
      notify_followers(post) if post.published?
      { success: true, post: post }
    else
      { success: false, errors: post.errors.full_messages }
    end
  end

  def update_post(post, params)
    if post.can_edit?(@user) && post.update(params)
      @analytics_service.track_resource_action(action: 'updated', resource: post, user: @user)
      { success: true, post: post }
    else
      { success: false, errors: post.errors.full_messages }
    end
  end

  def delete_post(post)
    if post.can_delete?(@user)
      @analytics_service.track_resource_action(action: 'deleted', resource: post, user: @user)
      post.destroy
      { success: true }
    else
      { success: false, error: 'Not authorized to delete this post' }
    end
  end

  def like_post(post)
    return { success: false, error: 'Post not found' } unless post
    return { success: false, error: 'Already liked' } if post.liked_by?(@user)

    like = post.likes.build(user: @user)
    if like.save
      @analytics_service.track_interaction('liked', post, @user)
      { success: true, like: like }
    else
      { success: false, errors: like.errors.full_messages }
    end
  end

  def unlike_post(post)
    return { success: false, error: 'Post not found' } unless post
    return { success: false, error: 'Not liked' } unless post.liked_by?(@user)

    like = post.likes.find_by(user: @user)
    if like&.destroy
      @analytics_service.track_interaction('unliked', post, @user)
      { success: true }
    else
      { success: false, error: 'Failed to unlike post' }
    end
  end

  def view_post(post)
    return { success: false, error: 'Post not found' } unless post
    return { success: false, error: 'Post not published' } unless post.published?

    post.increment_view_count!
    @analytics_service.track_interaction('viewed', post, @user)
    { success: true, post: post }
  end

  def search_posts(query, options = {})
    search_service = SearchService.new
    results = search_service.search(Post, query, options)

    @analytics_service.track_search(
      query: query,
      results_count: results.count,
      user: @user,
    )

    { success: true, results: results }
  end

  def get_trending_posts(limit = 10)
    Post.trending.limit(limit)
  end

  def get_user_posts(user, page = 1, per_page = 12)
    posts = user.posts.published.recent

    if defined?(Zeropoint) && Zeropoint.pagination_service
      Zeropoint.pagination_service.paginate(posts, page, per_page)
    else
      posts.offset((page - 1) * per_page).limit(per_page)
    end
  end

  def get_feed_posts(page = 1, per_page = 12)
    return Post.none unless @user

    following_ids = @user.follows.pluck(:followed_id)
    posts = Post.published.where(user_id: following_ids).or(Post.published.where(user: @user)).recent

    if defined?(Zeropoint) && Zeropoint.pagination_service
      Zeropoint.pagination_service.paginate(posts, page, per_page)
    else
      posts.offset((page - 1) * per_page).limit(per_page)
    end
  end

  private

  def notify_followers(post)
    post.user.followers.each do |follower|
      # In a real app, you'd use a notification service
      Rails.logger.info "Notifying #{follower.email} about new post: #{post.title}"
    end
  end
end
