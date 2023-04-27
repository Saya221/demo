# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notification, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to(:creator) }
  end
end
