# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    topic { "staff" }
    content { Faker::Lorem.sentence }
    creator { create :user }
  end
end
