# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::UserSerializer do
  let(:user) do
    create :user, id: "216ab9a7-8c9f-4b33-ad6f-b16ea0c211c6", name: "abc", email: "test@gmail.com"
  end

  describe "serialize type is root" do
    let(:response_data) { convert_serialize described_class.new(user) }
    let(:expected_data) do
      {
        id: "216ab9a7-8c9f-4b33-ad6f-b16ea0c211c6",
        name: "abc",
        email: "test@gmail.com"
      }
    end

    it { expect(response_data).to eq expected_data }
  end
end
