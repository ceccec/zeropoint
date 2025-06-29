# frozen_string_literal: true

module Configurable
  extend ActiveSupport::Concern

  included do
    before_action :set_configuration
  end

  private

  def set_configuration
    @demo_config = Zeropoint.configuration
    @theme = Zeropoint.theme
    @app_config = Zeropoint.config
  end

  def zeropoint_config
    @demo_config
  end

  def zeropoint_theme
    @theme
  end

  def zeropoint_app_config
    @app_config
  end
end
