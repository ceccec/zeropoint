# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to root_path if current_user
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: t('demo.sign_in')
    else
      flash.now[:alert] = t('demo.invalid_email_or_password')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('demo.sign_out')
  end
end
