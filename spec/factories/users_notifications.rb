# frozen_string_literal: true

FactoryBot.define do
  factory :users_notification do
    id { SecureRandom.uuid }
    user
    association :notification, factory: :notification, strategy: :create
  end
end
