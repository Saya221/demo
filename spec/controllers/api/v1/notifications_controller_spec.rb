# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::NotificationsController do
  let(:current_user) { create :user, role: :staff }

  describe "POST #create" do
    let(:params) do
      {
        topic: topic,
        content: content
      }
    end

    context "when created notifications successfully" do
      let(:topic) { :staff }
      let(:content) { "content" }

      before do
        login user: current_user
        post :create, params: params
      end

      it do
        expect(response_data[:success]).to eq true
        expect(response_data[:data][:notification].keys.size).to eq 7
        expect(response_data[:data][:notification][:creator].keys.size).to eq 3
        expect(response_data).to have_key :meta
      end
    end

    context "when missing content" do
      let(:content) { nil }
      let(:topic) { :staff }

      before do
        login user: current_user
        post :create, params: params
      end

      it_behaves_like :blank, Notification.name.underscore, "content"
    end

    context "when invalid topic" do
      let(:content) { "content" }
      let(:topic) { :staffs }

      before do
        login user: current_user
        post :create, params: params
      end

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1700
      end
    end

    context "when user not login" do
      it_behaves_like :unauthorized, before { post :create }
    end
  end
end
