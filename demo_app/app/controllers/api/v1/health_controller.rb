# frozen_string_literal: true

module Api
  module V1
    class HealthController < ApplicationController
      def check
        render json: Zeropoint.health_check
      end
    end
  end
end
