# frozen_string_literal: true

module Zeropoint
  class HealthController < Zeropoint::BaseController
    def index
      render json: { status: 'healthy', timestamp: Time.now.utc.iso8601 }
    end
  end
end
