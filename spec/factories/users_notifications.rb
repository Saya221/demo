# frozen_string_literal: true

FactoryBot.define do
  factory :users_notification do
    user
    notification
  end
end
