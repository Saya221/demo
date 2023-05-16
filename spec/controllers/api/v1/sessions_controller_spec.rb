# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::SessionsController do
  let!(:user) { create :user, password: "Aa@123456", email: "test@gmail.com" }

  describe "POST #login" do
    let(:params) { { user: { email: email, password: password } } }

    before { post :login, params: params }

    context "when login successfully" do
      let(:email) { "test@gmail.com" }
      let(:password) { "Aa@123456" }

      it do
        expect(response_data[:success]).to eq true
        expect(response_data[:data][:token_info]).to have_key :access_token
        expect(response_data).to have_key :meta
      end
    end

    context "when user params missing" do
      let(:params) { {} }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1200
      end
    end

    context "when email not found" do
      let(:email) { "tes@gmail.com" }
      let(:password) { "Aa@123456" }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1201
      end
    end

    context "when password not correct" do
      let(:email) { "test@gmail.com" }
      let(:password) { "this is not password" }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1201
      end
    end
  end

  describe "DELETE #logout" do
    context "when logout successfully" do
      before do
        login
        delete :logout
      end

      it do
        expect(response_data[:success]).to eq true
        expect(user.user_sessions.size).to eq 0
      end
    end

    context "when user not login" do
      before { delete :logout }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1201
      end
    end

    context "when missing Jwt-Authorization type" do
      before do
        request.headers.merge! "Jwt-Authorization": "asdklj.asjdlkasd.ajsdlk"
        delete :logout
      end

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1201
      end
    end

    context "when missing Jwt-Authorization token" do
      before do
        request.headers.merge! "Jwt-Authorization": "Bearer"
        delete :logout
      end

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1201
      end
    end

    context "when invalid segment headers" do
      before do
        request.headers.merge! "Jwt-Authorization": "Bearer qwoue.qwe"
        delete :logout
      end

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1201
      end
    end

    context "when invalid signature" do
      before do
        request.headers.merge! "Jwt-Authorization": "Bearer qwoue.qwe.qoweuo"
        delete :logout
      end

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1201
      end
    end

    context "when Jwt-Authorization expired" do
      let(:token) do
        JWT.encode payload, ENV["SECRET_KEY_BASE"], Settings.jwt.algorithm
      end
      let(:payload) do
        {
          user_id: user.id,
          session_token: user_session.session_token,
          iat: current_time,
          exp: current_time
        }
      end
      let(:user_session) { create :user_session, user: user }

      before do
        request.headers.merge! "Jwt-Authorization": "Bearer #{token}"
        delete :logout
      end

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1201
      end
    end

    context "when user not found" do
      let(:token) do
        JWT.encode payload, ENV["SECRET_KEY_BASE"], Settings.jwt.algorithm
      end
      let(:payload) do
        {
          user_id: 0,
          session_token: user_session.session_token,
          iat: current_time,
          exp: current_time + Settings.jwt.expiration_time
        }
      end
      let(:user_session) { create :user_session, user: user }

      before do
        request.headers.merge! "Jwt-Authorization": "Bearer #{token}"
        delete :logout
      end

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1500
      end
    end

    context "when session not found" do
      let(:token) do
        JWT.encode payload, ENV["SECRET_KEY_BASE"], Settings.jwt.algorithm
      end
      let(:payload) do
        {
          user_id: user.id,
          session_token: 0,
          iat: current_time,
          exp: current_time + Settings.jwt.expiration_time
        }
      end
      let(:user_session) { create :user_session, user: user }

      before do
        request.headers.merge! "Jwt-Authorization": "Bearer #{token}"
        delete :logout
      end

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1500
      end
    end

    context "when user inactive" do
      before do
        user.inactive!
        login(user: user)
        delete :logout
      end

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1250
      end
    end
  end
end
