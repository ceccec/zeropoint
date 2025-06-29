# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  def new; end

  def edit
    @user = find_user_by_token
    validate_token_expiration
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      send_password_reset(user)
    else
      handle_email_not_found
    end
  end

  def update
    @user = find_user_by_token
    if valid_token?
      update_user_password
    else
      handle_invalid_token
    end
  end

  private

  def find_user_by_token
    User.find_by(password_reset_token: params[:token])
  end

  def validate_token_expiration
    return if @user && @user.password_reset_sent_at > 1.hour.ago

    redirect_to new_password_reset_path, alert: t('demo.invalid_or_expired_token')
  end

  def send_password_reset(user)
    user.update(password_reset_token: SecureRandom.hex(32), password_reset_sent_at: Time.current)
    user.send_password_reset_email
    redirect_to login_path, notice: t('demo.password_reset_sent')
  end

  def handle_email_not_found
    flash.now[:alert] = t('demo.email_not_found')
    render :new, status: :unprocessable_entity
  end

  def valid_token?
    @user && @user.password_reset_sent_at > 1.hour.ago
  end

  def update_user_password
    if @user.update(password_params)
      clear_reset_token
      redirect_to login_path, notice: t('demo.password_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def clear_reset_token
    @user.update(password_reset_token: nil, password_reset_sent_at: nil)
  end

  def handle_invalid_token
    redirect_to new_password_reset_path, alert: t('demo.invalid_or_expired_token')
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
