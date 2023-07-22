# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notification, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:creator).class_name(User.name) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:content) }
  end

  describe "enumerations" do
    it { expect(described_class.topics).to include("admin", "staff") }
  end
end
