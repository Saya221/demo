# frozen_string_literal: true

# frozen_literal_string: true

require "rails_helper"

RSpec.describe Client, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:creator).class_name(User.name) }
    it { is_expected.to belong_to(:last_updater).class_name(User.name) }
    it { is_expected.to have_many(:clients_jobs).dependent(:destroy) }
    it { is_expected.to have_many(:jobs).through(:clients_jobs) }
  end

  describe "validations" do
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
  end
end
