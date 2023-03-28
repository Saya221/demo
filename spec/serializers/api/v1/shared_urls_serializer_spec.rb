# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::SharedUrlSerializer do
  let(:user) { create(:user, id: 1, name: "abc", email: "test@gmail.com") }
  let(:shared_url) do
    create :shared_url, id: 1, url: "test", description: "test",
                        thumbnail_url: "test", movie_title: "test",
                        user: user
  end

  describe "serialize type is root" do
    let(:response_data) { convert_serialize described_class.new(shared_url, type: :root) }
    let(:expected_data) do
      {
        id: 1,
        url: "test",
        description: "test",
        thumbnail_url: "test",
        movie_title: "test",
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
        url: "test",
        description: "test",
        thumbnail_url: "test",
        movie_title: "test"
      }
    end

    it { expect(response_data).to eq expected_data }
  end
end
