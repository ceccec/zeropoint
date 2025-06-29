# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "role_#{n}" }
    description { Faker::Lorem.sentence }
    permissions { [] }

    trait :admin do
      name { 'admin' }
      permissions { %w[read write delete admin] }
    end

    trait :user do
      name { 'user' }
      permissions { %w[read write] }
    end

    trait :moderator do
      name { 'moderator' }
    end
  end
end
