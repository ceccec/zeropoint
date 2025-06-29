# frozen_string_literal: true

# ApplicationController can be included as a module for configuration in other contexts (e.g., engines, API-only, or external mounting)
module ApplicationControllerConfigurable
  extend ActiveSupport::Concern

  included do
    # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
    allow_browser versions: :modern
    # Add any other shared configuration or before_actions here
  end

  # Add shared helper methods here if needed
end

class ApplicationController < ActionController::Base
  include ApplicationControllerConfigurable
end
