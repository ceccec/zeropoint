# frozen_string_literal: true

module CrudOperations
  extend ActiveSupport::Concern

  included do
    before_action :set_resource, only: %i[show edit update destroy]
  end

  def index
    @resources = resource_class.order(:created_at)
    respond_to_formats
  end

  def show
    respond_to_formats
  end

  def new
    @resource = resource_class.new
    respond_to_formats
  end

  def create
    @resource = build_resource
    if @resource.save
      handle_successful_create
    else
      handle_failed_create
    end
  end

  def edit
    respond_to_formats
  end

  def update
    if @resource.update(resource_params)
      handle_successful_update
    else
      handle_failed_update
    end
  end

  def destroy
    @resource.destroy
    handle_successful_destroy
  end

  private

  def set_resource
    @resource = resource_class.find(params[:id])
  end

  def build_resource
    if respond_to?(:current_user) && current_user
      resource_class.new(resource_params).tap { |r| r.user = current_user if r.respond_to?(:user=) }
    else
      resource_class.new(resource_params)
    end
  end

  def handle_successful_create
    respond_to do |format|
      format.html { redirect_to resource_path(@resource), notice: success_message(:created) }
      format.json { render json: @resource, status: :created }
    end
  end

  def handle_failed_create
    respond_to do |format|
      format.html { render :new }
      format.json { render json: { errors: @resource.errors.full_messages }, status: :unprocessable_entity }
    end
  end

  def handle_successful_update
    respond_to do |format|
      format.html { redirect_to resource_path(@resource), notice: success_message(:updated) }
      format.json { render json: @resource }
    end
  end

  def handle_failed_update
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: { errors: @resource.errors.full_messages }, status: :unprocessable_entity }
    end
  end

  def handle_successful_destroy
    respond_to do |format|
      format.html { redirect_to resources_path, notice: success_message(:deleted) }
      format.json { head :no_content }
    end
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
      { resources: @resources }
    when 'show'
      @resource
    when 'new'
      { resource: @resource }
    end
  end

  def success_message(action)
    resource_name = resource_class.model_name.human.downcase
    I18n.t("demo.#{resource_name}_#{action}")
  end

  def resource_path(resource)
    send("#{resource_class.model_name.singular_route_key}_path", resource)
  end

  def resources_path
    send("#{resource_class.model_name.route_key}_path")
  end

  # These methods should be implemented by the including class
  def resource_class
    raise NotImplementedError, "#{self.class} must implement #resource_class"
  end

  def resource_params
    raise NotImplementedError, "#{self.class} must implement #resource_params"
  end
end
