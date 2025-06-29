# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def new
    redirect_to root_path if current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.send_confirmation_email
      redirect_to login_path, notice: t('demo.account_created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirm_email
    user = User.find_by(email_confirmation_token: params[:token])

    if user
      user.confirm_email!
      redirect_to login_path, notice: t('demo.email_confirmed')
    else
      redirect_to root_path, alert: t('demo.invalid_confirmation_token')
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :first_name, :last_name, :bio)
  end
end
