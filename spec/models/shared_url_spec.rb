# frozen_string_literal: true

require "rails_helper"

RSpec.describe SharedUrl, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:url) }
  end

  describe "scopes" do
    context ".lastest" do
      let!(:shared_url1) { create :shared_url, id: 1 }
      let!(:shared_url2) { create :shared_url, id: 2 }

      it { expect(SharedUrl.lastest.ids).to eq [2, 1] }
    end
  end
end
