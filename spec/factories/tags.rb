# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "tag_#{n}" }
    description { Faker::Lorem.sentence }
    color { Faker::Color.hex_color }

    trait :admin do
      name { 'admin' }
      color { '#ff0000' }
    end

    trait :moderator do
      name { 'moderator' }
      color { '#00ff00' }
    end

    trait :vip do
      name { 'vip' }
    end
  end
end
