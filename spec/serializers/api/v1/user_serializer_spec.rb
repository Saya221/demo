# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::UserSerializer do
  let(:user) { create(:user, id: 1, name: "abc", email: "test@gmail.com") }

  describe "serialize type is root" do
    let(:response_data) { convert_serialize described_class.new(user, type: :root) }
    let(:expected_data) do
      {
        id: 1,
        name: "abc",
        email: "test@gmail.com"
      }
    end

    it { expect(response_data).to eq expected_data }
  end
end
