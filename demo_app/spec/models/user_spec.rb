# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without an email' do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it 'is invalid without a username' do
    expect(build(:user, username: nil)).not_to be_valid
  end

  it 'assigns default role after create' do
    user = create(:user)
    expect(user.has_role?(:user)).to be true
  end
end
