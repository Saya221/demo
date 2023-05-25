# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::UsersController do
  describe "GET #show" do
    let(:user) do
      create :user, id: "216ab9a7-8c9f-4b33-ad6f-b16ea0c211c6", email: "test@gmail.com", name: "test"
    end

    context "when get user information successfully" do
      before do
        login user: user
        get :show
      end

      let(:expected_data) do
        {
          id: "216ab9a7-8c9f-4b33-ad6f-b16ea0c211c6",
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
      it_behaves_like :unauthorized, before { get :show }
    end
  end
end
