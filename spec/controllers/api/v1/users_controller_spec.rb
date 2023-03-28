# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::UsersController do
  describe "GET #show" do
    let(:user) { create :user, id: 1, email: "test@gmail.com", name: "test" }

    context "when get user information successfully" do
      before do
        login user: user
        get :show
      end

      let(:expected_data) do
        {
          id: 1,
          name: "test",
          email: "test@gmail.com"
        }
      end

      it do
        expect(response_data[:success]).to eq true
        expect(response_data[:data][:user]).to eq expected_data
      end
    end

    context "when user not login" do
      before { get :show }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1201
      end
    end

  end
end
