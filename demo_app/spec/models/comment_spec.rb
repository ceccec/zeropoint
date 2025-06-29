# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:comment)).to be_valid
  end

  it 'is invalid without content' do
    expect(build(:comment, content: nil)).not_to be_valid
  end

  it 'belongs to a user and post' do
    comment = build(:comment)
    expect(comment.user).to be_present
    expect(comment.post).to be_present
  end
end
