# frozen_string_literal: true

FactoryBot.define do
  factory :user_session do
    user
    login_ip { Faker::Number.decimal }
    browser { Faker::Device.platform }
  end
end
