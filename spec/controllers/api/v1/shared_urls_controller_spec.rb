# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::SharedUrlsController do
  describe "GET #index" do
    let!(:shared_url1) { create :shared_url }
    let!(:shared_url2) { create :shared_url }

    before { get :index }

    it "when get list shared_urls successfully" do
      expect(response_data[:success]).to eq true
      expect(response_data[:data][:shared_urls].size).to eq 2
      expect(response_data[:data][:shared_urls][0].size).to eq 3
    end
  end
end
