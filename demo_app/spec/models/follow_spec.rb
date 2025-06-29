# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:follow)).to be_valid
  end

  it 'is invalid with duplicate follower and followed' do
    follow = create(:follow)
    expect(build(:follow, follower: follow.follower, followed: follow.followed)).not_to be_valid
  end
end
