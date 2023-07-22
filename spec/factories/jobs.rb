# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    description { Faker::Lorem.sentence }
    name { Faker::Job.position }
    salary { rand(1000..2000) }
    working_hours { rand(2..9) }
    creator { create :user }
    last_updater { create :user }
  end
end
