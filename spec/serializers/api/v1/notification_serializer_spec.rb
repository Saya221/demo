# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::NotificationSerializer do
  let(:creator) do
    create :user, name: "Notification Test", email: "test@gmail.com",
                  id: "f2cd0228-ff9e-4ca4-930c-e4f62d3e1aaf"
  end
  let(:notification) do
    create :notification, creator:, content: "content", topic: :staff,
                          id: "a9b0245f-998a-4c6b-b0ba-5bb8cb19be84",
                          created_at: current_time, updated_at: current_time
  end

  describe "serialize type is root" do
    let(:response_data) { convert_serialize described_class.new(notification) }
    let(:expected_data) do
      {
        id: "a9b0245f-998a-4c6b-b0ba-5bb8cb19be84",
        topic: "staff",
        content: "content",
        creator: {
          id: "f2cd0228-ff9e-4ca4-930c-e4f62d3e1aaf",
          name: "Notification Test",
          email: "test@gmail.com"
        },
        deleted_at: nil,
        created_at: current_time,
        updated_at: current_time
      }
    end

    it { expect(response_data).to eq expected_data }
  end
end
