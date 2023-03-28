# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::HealthChecksController do
  describe "GET #ping" do
    before { get :ping }

    it "when get server status successfully" do
      expect(response.body).to eq "pong"
    end
  end
end
