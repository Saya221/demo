# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::SharedUrlSerializer do
  let(:user) { create(:user, id: 1, name: "abc", email: "test@gmail.com") }
  let(:shared_url) { create(:shared_url, id: 1, url: "https://youtube.com/watch?v=QWeuaFhJ", user: user) }

  describe "serialize type is root" do
    let(:response_data) { convert_serialize described_class.new(shared_url, type: :root) }
    let(:expected_data) do
      {
        id: 1,
        url: "https://youtube.com/watch?v=QWeuaFhJ",
        user: {
          id: 1,
          name: "abc",
          email: "test@gmail.com"
        }
      }
    end

    it do
      expect(response_data).to eq expected_data
    end
  end

  describe "serialize type is list_user_shared_urls" do
    let(:response_data) { convert_serialize described_class.new(shared_url, type: :list_user_shared_urls) }
    let(:expected_data) do
      {
        id: 1,
        url: "https://youtube.com/watch?v=QWeuaFhJ"
      }
    end

    it { expect(response_data).to eq expected_data }
  end
end
