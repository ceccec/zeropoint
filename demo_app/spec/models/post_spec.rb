# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:post)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:post, title: nil)).not_to be_valid
  end

  it 'is invalid without content' do
    expect(build(:post, content: nil)).not_to be_valid
  end

  it 'belongs to a user' do
    post = build(:post)
    expect(post.user).to be_present
  end
end
