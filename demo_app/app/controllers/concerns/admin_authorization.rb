# frozen_string_literal: true

module AdminAuthorization
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :require_admin
  end

  private

  def require_admin
    redirect_to root_path, alert: t('demo.messages.not_authorized') unless current_user&.admin?
  end

  def admin_only
    return if current_user&.admin?

    respond_to do |format|
      format.html { redirect_to root_path, alert: t('demo.messages.not_authorized') }
      format.json { render json: { error: t('demo.messages.not_authorized') }, status: :unauthorized }
    end
  end
end
