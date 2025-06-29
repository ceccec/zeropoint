# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!, except: [ :index, :show ]
      before_action :set_user, only: [ :show ]

      def index
        users = Zeropoint.pagination_service.paginate(User.active, params[:page] || 1, 10)
        render json: users
      end

      def show
        render json: @user
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
