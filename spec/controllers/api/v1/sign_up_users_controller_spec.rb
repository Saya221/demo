# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::SignUpUsersController do
  describe "POST #create" do
    let(:params) do
      {
        user: {
          name: name,
          email: email,
          password: password
        }
      }
    end

    context "when create user successfully" do
      let(:name) { "test" }
      let(:email) { "test@gmail.com" }
      let(:password) { "password" }

      before { post :create, params: params }

      it { expect(response_data[:success]).to eq true }
    end

    context "when email invalid" do
      let(:name) { "test" }
      let(:email) { "test2@@gmail.com" }
      let(:password) { "password" }

      before { post :create, params: params }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:resource]).to eq "user"
        expect(response_data[:errors][0][:field]).to eq "email"
        expect(response_data[:errors][0][:code]).to eq 1009
      end
    end

    context "when email was taken" do
      let!(:user) { create :user, email: "test2@gmail.com" }

      let(:name) { "test" }
      let(:email) { "test2@gmail.com" }
      let(:password) { "password" }

      before { post :create, params: params }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:resource]).to eq "user"
        expect(response_data[:errors][0][:field]).to eq "email"
        expect(response_data[:errors][0][:code]).to eq 1008
      end
    end

    context "when email was nil" do
      let(:name) { "test" }
      let(:email) { "" }
      let(:password) { "password" }

      before { post :create, params: params }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:resource]).to eq "user"
        expect(response_data[:errors][0][:field]).to eq "email"
        expect(response_data[:errors][0][:code]).to eq 1009
      end
    end

    context "when password was nil" do
      let(:params) do
        {
          user: {
            name: "test",
            email: "email@gmail.com"
          }
        }
      end

      before { post :create, params: params }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:resource]).to eq "user"
        expect(response_data[:errors][0][:field]).to eq "password_encrypted"
        expect(response_data[:errors][0][:code]).to eq 1003
      end
    end

    context "when missing user param" do
      let(:params) do
        {
          name: "name",
          email: "email@gmail.com",
          password: "password"
        }
      end

      before { post :create, params: params }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1200
      end
    end
  end
end
