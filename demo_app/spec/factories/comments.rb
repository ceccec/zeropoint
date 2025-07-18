# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :user
    association :post
    content { 'This is a comment.' }
  end
end
