# frozen_string_literal: true

# Users Controller
# Handles user registration and profile management with Zeropoint integration

class UsersController < ApplicationController
  include ZeropointAuthenticatable

  skip_before_action :authenticate_user!, only: [ :new, :create ]
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      # Sign in the user automatically after registration
      sign_in(@user)

      # Initialize vortex session
      initialize_vortex_session(@user)

      # Set consciousness context
      set_consciousness_context_for_user(@user)

      # Redirect to profile page
      redirect_to @user, notice: t('zeropoint.users.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /users/:id
  def show
    # Add vortex data to user profile
    @vortex_data = get_vortex_data_for_user(@user) if vortex_authenticated?

    # Add consciousness data to user profile
    @consciousness_data = get_consciousness_data_for_user(@user) if consciousness_authenticated?
  end

  # GET /users/:id/edit
  def edit
    # Ensure user can only edit their own profile
    unless @user == current_user
      redirect_to @user, alert: t('zeropoint.users.not_authorized')
    end
  end

  # PATCH/PUT /users/:id
  def update
    if @user.update(user_params)
      # Update vortex session if email changed
      update_vortex_session(@user) if user_params[:email]

      redirect_to @user, notice: t('zeropoint.users.updated_successfully')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    if @user == current_user
      # Clear vortex session
      clear_vortex_session(@user)

      # Sign out user
      sign_out

      # Delete user account
      @user.destroy!

      redirect_to root_path, notice: t('zeropoint.users.deleted_successfully')
    else
      redirect_to @user, alert: t('zeropoint.users.not_authorized')
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  # Initialize vortex session for new user
  def initialize_vortex_session(user)
    return unless Zeropoint.config.vortex.enabled

    # Generate vortex session ID
    session[:vortex_session_id] = generate_vortex_session_id(user)

    # Initialize vortex storage for user
    if defined?(Zeropoint::Vortex::Storage)
      Zeropoint::Vortex::Storage.initialize_for_user(user.id)
    end

    # Log vortex session initialization
    Rails.logger.info "Vortex session initialized for user #{user.id}"
  end

  # Update vortex session when user data changes
  def update_vortex_session(user)
    return unless Zeropoint.config.vortex.enabled

    # Regenerate vortex session ID if needed
    if session[:vortex_session_id]
      new_session_id = generate_vortex_session_id(user)
      session[:vortex_session_id] = new_session_id

      # Update vortex storage with new session ID
      if defined?(Zeropoint::Vortex::Storage)
        Zeropoint::Vortex::Storage.update_session(user.id, new_session_id)
      end
    end
  end

  # Clear vortex session for user
  def clear_vortex_session(user)
    return unless Zeropoint.config.vortex.enabled

    # Clear vortex storage for user
    if defined?(Zeropoint::Vortex::Storage)
      Zeropoint::Vortex::Storage.clear_for_user(user.id)
    end

    # Remove session ID
    session.delete(:vortex_session_id)
  end

  # Get vortex data for user profile
  def get_vortex_data_for_user(user)
    return {} unless Zeropoint.config.vortex.enabled

    if defined?(Zeropoint::Vortex::Storage)
      {
        session_id: vortex_session_id,
        storage_size: Zeropoint::Vortex::Storage.size_for_user(user.id),
        cache_hits: Zeropoint::Vortex::Cache.hits_for_user(user.id),
        cache_misses: Zeropoint::Vortex::Cache.misses_for_user(user.id),
      }
    else
      { session_id: vortex_session_id }
    end
  end

  # Get consciousness data for user profile
  def get_consciousness_data_for_user(user)
    return {} unless Zeropoint.config.consciousness.enabled

    {
      observer_id: user.id,
      session_context: consciousness_context,
      quantum_entanglement_count: get_quantum_entanglement_count(user),
      golden_ratio_events: get_golden_ratio_events(user),
    }
  end

  # Get quantum entanglement count for user
  def get_quantum_entanglement_count(user)
    return 0 unless defined?(Zeropoint::Consciousness::QuantumEntanglement)

    Zeropoint::Consciousness::QuantumEntanglement.count_for_user(user.id)
  end

  # Get golden ratio events for user
  def get_golden_ratio_events(user)
    return [] unless defined?(Zeropoint::Consciousness::GoldenRatio)

    Zeropoint::Consciousness::GoldenRatio.events_for_user(user.id)
  end
end
