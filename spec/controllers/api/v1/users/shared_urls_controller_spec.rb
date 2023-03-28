# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Users::SharedUrlsController do
  let(:user) { create :user }

  describe "GET #index" do
    let!(:shared_url1) { create :shared_url, user: user }
    let!(:shared_url2) { create :shared_url, user: user }

    context "when get list shared url successfully" do
      before do
        login user: user
        get :index
      end

      it do
        expect(response_data[:success]).to eq true
        expect(response_data[:data][:shared_urls].size).to eq 2
        expect(response_data[:data][:shared_urls][0].size).to eq 2
      end
    end

    context "when user not login" do
      before { get :index }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1201
      end
    end
  end

  describe "POST #create" do
    let(:params) { { url: url } }

    context "when user shared url successfully" do
      let(:url) { "https://www.youtube.com/watch?v=TB3EtQQHh60" }

      before do
        login
        post :create, params: params
      end

      it { expect(response_data[:success]).to eq true }
    end

    context "when url was nil" do
      let(:url) {}

      before do
        login
        post :create, params: params
      end

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1200
      end
    end

    context "when not found video_id" do
      let(:url) { "https://www.youtube.com/watch?v=TB3EtQ" }

      before do
        login
        post :create, params: params
      end

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1550
      end
    end

    context "when user not login" do
      let(:url) { "https://www.youtube.com/watch?v=TB3EtQQHh60" }

      before { post :create, params: params }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1201
      end
    end
  end
end
