# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    association :user
    sequence(:title) { |n| "Sample Post #{n}" }
    content { 'This is a sample post content.' }
    status { 'published' }
    views { rand(0..100) }
  end
end
