# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserSession, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to(:user) }
  end

  describe "methods" do
    context "#gen_uniq_session_token" do
      # TODO: Find the way to test regression methods
    end
  end
end
