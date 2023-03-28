# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { is_expected.to have_many(:user_sessions) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:password_encrypted) }

    context "email" do
      context ".uniqueness" do
        let!(:user) { create(:user, email: "uniqueness@email.com") }
        let(:invalid1) { build(:user, email: "uniqueness@email.com") }
        let(:invalid2) { build(:user, email: "UniquEneSs@email.com") }

        it do
          expect(invalid1).not_to be_valid
          expect(invalid2).not_to be_valid
        end
      end

      context ".format" do
        allow_email = ["allow@gmail.com"].freeze
        disallow_email = ["disallow@@gmail.com"].freeze

        let(:valid) { build(:user, email: allow_email.sample) }
        let(:invalid) { build(:user, email: disallow_email.sample) }

        it do
          expect(valid).to be_valid
          expect(invalid).not_to be_valid
        end
      end
    end
  end

  describe "methods" do
    let(:user) { create(:user, password: "this is password") }

    context "#password" do
      it { expect(user.password).to eq "this is password" }
    end

    context "#password=" do
      before { user.password = "password was changed" }

      it { expect(user.password).to eq "password was changed" }
    end
  end
end
