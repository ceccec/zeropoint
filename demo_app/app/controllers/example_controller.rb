# frozen_string_literal: true

class ExampleController < ApplicationController
  include CrudAuthorization

  # Example 1: Public controller with optional authentication
  configure_crud_authorization(
    actions: %i[index show],
    public_actions: [ :index, :show ],
    authentication_strategy: :session,
  )

  # Example 2: User-only controller with role-based access
  configure_crud_authorization(
    actions: %i[create update],
    roles: {
      create: [ :user, :admin ],
      update: [ :user, :admin ]
    },
    owner_only_actions: [ :update ],
    ownership: :user_id,
  )

  # Example 3: Admin-only controller
  configure_crud_authorization(
    actions: %i[admin_only_action],
    admin_only_actions: [ :admin_only_action ],
  )

  # Example 4: Mixed access controller
  configure_crud_authorization(
    actions: %i[mixed_access_action],
    roles: {
      mixed_access_action: %i[user admin moderator]
    },
    policies: {
      mixed_access_action: lambda { |user, resource|
        user.confirmed? && (user.admin? || user.moderator? || resource.user_id == user.id)
      }
    },
  )

  def index
    # Public action - no authentication required
    @public_data = 'This is public data'
    render json: { data: @public_data, authenticated: user_signed_in?, user: current_user&.username }
  end

  def show
    # Public action with optional user context
    @item = Item.find(params[:id])
    render json: {
      item: @item,
      can_edit: can?(:update, @item),
      can_delete: can?(:delete, @item),
      user: current_user&.username
    }
  end

  def create
    # User-only action
    @item = current_user.items.build(item_params)
    if @item.save
      render_success(@item, status: :created)
    else
      render_validation_errors(@item)
    end
  end

  def update
    # Owner-only action
    @item = Item.find(params[:id])
    if @item.update(item_params)
      render_success(@item)
    else
      render_validation_errors(@item)
    end
  end

  def admin_only_action
    # Admin-only action
    @admin_data = 'This is admin-only data'
    render json: { data: @admin_data, user: current_user.username }
  end

  def mixed_access_action
    # Mixed access with custom policy
    @item = Item.find(params[:id])
    render json: {
      item: @item,
      access_level: determine_access_level,
      user: current_user.username
    }
  end

  def token_example
    # Example of token-based authentication
    configure_crud_authorization(
      authentication_strategy: :token,
      actions: [ :token_example ],
      roles: { token_example: [ :user, :admin ] },
    )

    render json: {
      message: 'Token authenticated successfully',
      user: current_user.username,
      token: request.headers['Authorization']
    }
  end

  def api_key_example
    # Example of API key authentication
    configure_crud_authorization(
      authentication_strategy: :api_key,
      actions: [ :api_key_example ],
      roles: { api_key_example: [ :user, :admin ] },
    )

    render json: {
      message: 'API key authenticated successfully',
      user: current_user.username,
      api_key: request.headers['X-API-Key']
    }
  end

  def context_authorization_example
    # Example of context-based authorization
    @item = Item.find(params[:id])

    context = {
      time_restricted: true,
      location_restricted: true,
      location: request.remote_ip,
      rate_limited: true
    }

    if authorization_service.can_with_context?(:update, @item, context)
      @item.update(item_params)
      render_success(@item)
    else
      render_error('Action not allowed in current context', :forbidden)
    end
  end

  def bulk_authorization_example
    # Example of bulk authorization
    @items = Item.where(id: params[:item_ids])

    if authorization_service.can_perform_bulk_action?(:update, @items)
      @items.update_all(updated_at: Time.current)
      render_success({ message: 'Bulk update successful', count: @items.count })
    else
      render_error('Not authorized for bulk update', :forbidden)
    end
  end

  def authorization_report_example
    # Example of authorization reporting
    report = authorization_service.authorization_report(Item, %i[create read update delete])
    render json: { authorization_report: report }
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :status)
  end

  def determine_access_level
    if current_user.admin?
      'admin'
    elsif current_user.moderator?
      'moderator'
    elsif owns?(@item)
      'owner'
    else
      'user'
    end
  end

  # Override authentication strategy for specific actions
  def find_current_user
    case action_name
    when 'token_example'
      authenticate_with_token!
    when 'api_key_example'
      authenticate_with_api_key!
    else
      super
    end
  end

  # Custom authorization policies
  def set_authorization_policies
    authorization_service.add_policies({
                                         [ :custom_action, Item ] => lambda { |user, resource|
                                           user.confirmed? && resource.published?
                                         }
                                       })
  end
end
