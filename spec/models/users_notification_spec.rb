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

  describe "class methods" do
    # TODO: dry up with shared_examples_for

    before { create_partition_tables(described_class, %i[uuid577 uuid10]) }

    let(:new_tables) do
      [
        "#{described_class.name.pluralize.underscore}_" + (Zlib.crc32(MethodsHelper::UUID577) % 1000).to_s,
        "#{described_class.name.pluralize.underscore}_" + (Zlib.crc32(MethodsHelper::UUID10) % 1000).to_s
      ]
    end

    context "#set_table_name" do
      it { expect(new_tables[0]).to eq described_class.set_table_name(MethodsHelper::UUID577) }
      it { expect(new_tables[0]).to eq described_class.set_table_name }
    end

    context "#get_first_partition_table" do
      context "with create_init_tables" do
        it { expect(new_tables[0]).to eq described_class.get_first_partition_table }
      end

      context "without create_init_tables" do
        # TODO: built-in func destroy all partition tables
      end
    end

    context "#union_all_partition_tables" do
      let(:user1) { create(:user, id: MethodsHelper::UUID577) }
      let(:user2) { create(:user, id: MethodsHelper::UUID10) }
      let(:users_notification1) { build(:users_notification, user: user1) }
      let(:users_notification2) { build(:users_notification, user: user2) }

      before do
        [users_notification1, users_notification2].each_with_index do |users_notification, index|
          described_class.table_name = new_tables[index]
          users_notification.save
        end
      end

      it { expect(described_class.union_all_partition_tables.size).to eq 2 }
    end
  end
end
