# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersNotification, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:notification) }
  end

  describe "validations" do
    context "user_id" do
      context ".uniqueness" do
        let!(:users_notification) { create(:users_notification) }
        let(:invalid) do
          build :users_notification, user: users_notification.user,
                                     notification: users_notification.notification
        end

        it { expect(invalid).not_to be_valid }
      end
    end
  end
end
