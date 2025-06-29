# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:username) { |n| "user#{n}" }
    password { 'password' }
    password_confirmation { 'password' }
    email_confirmed_at { Time.current }
    first_name { 'Test' }
    last_name { 'User' }
    bio { 'Test user bio.' }
  end
end
