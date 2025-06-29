# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    status { %w[draft published archived].sample }
    published_at { status == 'published' ? Time.current : nil }
    user

    trait :published do
      status { 'published' }
      published_at { Time.current }
    end

    trait :draft do
      status { 'draft' }
      published_at { nil }
    end
  end
end
