# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::SharedUrlSerializer do
  let(:user) do
    create :user, id: "c30e02b8-a836-4990-b222-acdb3f7cb6b9", name: "abc", email: "test@gmail.com"
  end
  let(:shared_url) do
    create :shared_url, id: "940c7259-0b38-45c0-96d2-56f3513868de", url: "test", description: "test",
                        thumbnail_url: "test", movie_title: "test", user: user
  end

  describe "serialize type is root" do
    let(:response_data) { convert_serialize described_class.new(shared_url, type: :root) }
    let(:expected_data) do
      {
        id: "940c7259-0b38-45c0-96d2-56f3513868de",
        url: "test",
        description: "test",
        thumbnail_url: "test",
        movie_title: "test",
        user: {
          id: "c30e02b8-a836-4990-b222-acdb3f7cb6b9",
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
        id: "940c7259-0b38-45c0-96d2-56f3513868de",
        url: "test",
        description: "test",
        thumbnail_url: "test",
        movie_title: "test"
      }
    end

    it { expect(response_data).to eq expected_data }
  end
end
