# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { "user#{Time.current.to_i}#{Faker::Number.hexadecimal}@gmail.com" }
    password { "Aa@123456" }
    role { User.roles.keys.sample }
    status { User.statuses[:active] }
  end
end
