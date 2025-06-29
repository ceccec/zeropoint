# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:like)).to be_valid
  end

  it 'is invalid with duplicate user and post' do
    like = create(:like)
    expect(build(:like, user: like.user, post: like.post)).not_to be_valid
  end
end
