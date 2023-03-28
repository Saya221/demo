# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::YoutubeUrlProcessingService do
  let(:response_data) { described_class.new(video_id).perform }

  describe "#perform" do


    context "when get video info successfully" do
      let(:video_id) { "k6QFeBN7lV4" }
      let(:expected_data) do
        {
          movie_title: "DARK SOULS III, Soul of cinder (No HUD)",
          thumbnail_url: "https://i.ytimg.com/vi/k6QFeBN7lV4/default.jpg",
          description: ""
        }
      end

      it { expect(expected_data).to eq response_data }
    end

    context "when not found video" do
      let(:video_id) { "k6QFeB" }

      it { expect { response_data }.to raise_error Api::Error::ServiceExecuteFailed }
    end

  end
end
