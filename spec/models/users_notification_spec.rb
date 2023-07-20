# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersNotification, type: :model do
  before { described_class.reset_table_name } # TODO: Reseach ActiveRecord's cache

  describe "relationships" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:notification) }
  end

  describe "validations" do
    context "with user_id" do
      describe ".uniqueness" do
        let!(:users_notification) { create(:users_notification) }
        let(:invalid) do
          build :users_notification, user: users_notification.user,
                                     notification: users_notification.notification
        end

        it { expect(invalid).not_to be_valid }
      end
    end
  end

  describe "class methods" do
    it_behaves_like "partition"
  end
end
