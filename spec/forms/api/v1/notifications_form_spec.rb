# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::NotificationsForm do
  let(:current_user) { create :user, role: :staff }

  describe "#create!" do
    let(:params) { { topic: topic, content: content } }
    let(:form) { described_class.new(params, current_user) }

    context "when created notifications successfully" do
      let(:content) { "<script> </script>" }
      let(:topic) { :staff }

      before { UsersNotification.reset_table_name }

      it do
        expect { form.create! }.to change(Notification, :count).by(1)
                               .and change(UsersNotification, :count).by(1)
      end
    end

    context "when missing content" do
      let(:content) { nil }
      let(:topic) { :staff }

      it { expect { form.create! }.to raise_error ActiveRecord::RecordInvalid }
    end
  end
end
