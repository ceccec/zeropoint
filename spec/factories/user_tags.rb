# frozen_string_literal: true

FactoryBot.define do
  factory :user_tag do
    user
    tag
  end
end
