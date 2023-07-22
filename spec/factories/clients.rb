# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    address { Faker::Address.street_name }
    description { Faker::Lorem.sentence }
    name { Faker::Company.name }
    phone_number { Faker::Company.duns_number }
    creator { create :user }
    last_updater { create :user }
  end
end
