# frozen_string_literal: true

FactoryBot.define do
  factory :shared_url do
    user
    url { Faker::Internet.url }
  end
end
