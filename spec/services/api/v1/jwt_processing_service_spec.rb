# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::JwtProcessingService do
  let(:current_session) { create :user_session }
  let(:current_time) { Time.current.to_i }
  let(:access_token) do
    described_class.new(current_user: current_session.user,
                        current_session: current_session,
                        current_time: current_time).encode
  end

  describe "#encode" do
    let(:decode_access_token) do
      JWT.decode access_token, ENV["SECRET_KEY_BASE"], true, { algorithm: Settings.jwt.algorithm }
    end
    let(:expected_data) do
      {
        user_id: current_session.user.id,
        session_token: current_session.session_token,
        iat: current_time,
        exp: current_time + Settings.jwt.expiration_time
      }
    end

    it { expect(expected_data).to eq decode_access_token[0].deep_symbolize_keys! }
  end

  describe "#decode" do
    let(:response_data) { described_class.new(access_token: access_token).decode }
    let(:expected_data) do
      {
        current_session: current_session,
        current_user: current_session.user
      }
    end

    it { expect(expected_data).to eq response_data }
  end
end
