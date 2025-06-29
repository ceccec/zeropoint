# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:user_params) { { email: 'test@example.com', password: 'password', password_confirmation: 'password' } }

    it 'creates a new user and redirects' do
      expect {
        post :create, params: { user: user_params }
      }.to change(User, :count).by(1)
      expect(response).to redirect_to(assigns(:user))
    end
  end

  describe 'GET #show' do
    let(:user) { User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password') }

    before { session[:user_id] = user.id }

    it 'shows the user profile' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
end
