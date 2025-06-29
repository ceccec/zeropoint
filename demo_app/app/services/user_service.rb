# frozen_string_literal: true

class UserService
  def initialize(user = nil)
    @user = user
    @analytics_service = AnalyticsService.new
  end

  def authenticate_user(email, password)
    user = User.authenticate(email, password)

    if user
      @analytics_service.track_user_action(action: 'signed_in', user: user)
      { success: true, user: user }
    else
      { success: false, error: 'Invalid email or password' }
    end
  end

  def register_user(params)
    user = User.new(params)

    if user.save
      @analytics_service.track_user_action(action: 'registered', user: user)
      { success: true, user: user }
    else
      { success: false, errors: user.errors.full_messages }
    end
  end

  def update_user(user, params)
    if user.update(params)
      @analytics_service.track_user_action(action: 'updated', user: user)
      { success: true, user: user }
    else
      { success: false, errors: user.errors.full_messages }
    end
  end

  def delete_user(user)
    if user.destroy
      @analytics_service.track_user_action(action: 'deleted', user: user)
      { success: true }
    else
      { success: false, errors: user.errors.full_messages }
    end
  end

  def follow_user(user_to_follow)
    return { success: false, error: 'Cannot follow yourself' } if @user == user_to_follow
    return { success: false, error: 'Already following' } if @user.following?(user_to_follow)

    follow = @user.follows.build(followed: user_to_follow)
    if follow.save
      @analytics_service.track_interaction('followed', user_to_follow, @user)
      { success: true, follow: follow }
    else
      { success: false, errors: follow.errors.full_messages }
    end
  end

  def unfollow_user(user_to_unfollow)
    return { success: false, error: 'Not following' } unless @user.following?(user_to_unfollow)

    follow = @user.follows.find_by(followed: user_to_unfollow)
    if follow&.destroy
      @analytics_service.track_interaction('unfollowed', user_to_unfollow, @user)
      { success: true }
    else
      { success: false, error: 'Failed to unfollow' }
    end
  end

  def get_user_profile(user)
    return { success: false, error: 'User not found' } unless user

    @analytics_service.track_interaction('viewed', user, @user)
    { success: true, user: user }
  end

  def get_user_followers(user, page = 1, per_page = 20)
    followers = user.followers.includes(:follower)

    if defined?(Zeropoint) && Zeropoint.pagination_service
      Zeropoint.pagination_service.paginate(followers, page, per_page)
    else
      followers.offset((page - 1) * per_page).limit(per_page)
    end
  end

  def get_user_following(user, page = 1, per_page = 20)
    following = user.follows.includes(:followed)

    if defined?(Zeropoint) && Zeropoint.pagination_service
      Zeropoint.pagination_service.paginate(following, page, per_page)
    else
      following.offset((page - 1) * per_page).limit(per_page)
    end
  end

  def search_users(query, options = {})
    search_service = SearchService.new
    results = search_service.search(User, query, options)

    @analytics_service.track_search(
      query: query,
      results_count: results.count,
      user: @user,
    )

    { success: true, results: results }
  end

  def get_active_users(limit = 20)
    User.active.limit(limit)
  end

  def confirm_user_email(user)
    if user.confirm_email!
      @analytics_service.track_user_action(action: 'email_confirmed', user: user)
      { success: true, user: user }
    else
      { success: false, errors: user.errors.full_messages }
    end
  end

  def send_password_reset(user)
    user.send_password_reset_email
    @analytics_service.track_user_action(action: 'password_reset_requested', user: user)
    { success: true, message: 'Password reset email sent' }
  end

  def reset_password(user, password)
    user.password = password
    if user.save
      @analytics_service.track_user_action(action: 'password_reset', user: user)
      { success: true, user: user }
    else
      { success: false, errors: user.errors.full_messages }
    end
  end
end
