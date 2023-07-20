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
    describe ".latest" do
      let!(:shared_url1) { create :shared_url, id: "471a4b88-e327-4583-80c1-85cf438851fa" }
      let!(:shared_url2) { create :shared_url, id: "5e871d15-a3f8-44d2-a0be-60cca4932393" }

      it do
        expect(described_class.latest.ids).to eq %w[5e871d15-a3f8-44d2-a0be-60cca4932393
                                                    471a4b88-e327-4583-80c1-85cf438851fa]
      end
    end
  end
end
