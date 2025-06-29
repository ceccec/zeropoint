# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    include CrudOperations
    include CrudAuthorization

    # Configure CRUD authorization for admin users
    configure_crud_authorization(
      actions: %i[index show new create edit update destroy],
      roles: {
        index: [ :admin ],
        show: [ :admin ],
        new: [ :admin ],
        create: [ :admin ],
        edit: [ :admin ],
        update: [ :admin ],
        destroy: [ :admin ]
      },
      admin_only_actions: %i[index show new create edit update destroy],
      ownership: :id,
    )

    # Admin-only actions - no public access
    require_authentication :index, :show, :new, :create, :edit, :update, :destroy

    # Override authorization for admin-specific needs
    def action_authorized?
      return true if current_user&.admin?

      super
    end

    def index
      @resources = User.includes(:roles, :posts).order(:created_at)
      respond_to_formats
    end

    def show; end

    def edit; end

    def update
      if @resource.update(resource_params)
        redirect_to admin_user_path(@resource), notice: success_message(:updated)
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: t('demo.user_deleted')
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def require_admin
      redirect_to root_path, alert: t('demo.messages.not_authorized') unless current_user&.admin?
    end

    def resource_class
      User
    end

    def resource_params
      params.require(:user).permit(:email, :username, :first_name, :last_name, :bio, :avatar, role_ids: [])
    end
  end
end
