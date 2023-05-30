# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { is_expected.to have_many(:user_sessions).dependent(:destroy) }
    it { is_expected.to have_many(:shared_urls).dependent(:destroy) }
    it { is_expected.to have_many(:users_notifications).dependent(:destroy) }
    it { is_expected.to have_many(:notifications).through(:users_notifications) }
  end

  describe "validations" do
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

    context "password" do
      context ".password_format" do
        allow_password = ["Aa@123456"].freeze
        disallow_password = [
          nil,
          "",
          "123468",
          "Aa@12",
          "aaa@aaa",
          "aaqjwe"
        ].freeze

        let(:valid) { build(:user, password: allow_password.sample) }
        let(:invalid) { build(:user, password: disallow_password.sample) }

        it do
          expect(valid).to be_valid
          expect(invalid).not_to be_valid
        end
      end
    end
  end

  describe "methods" do
    let(:user) { create(:user, password: "Aa@123456") }

    context "#password" do
      it { expect(BCrypt::Password.new(user.password_encrypted).is_password?("Aa@123456")).to eq true }
    end

    context "#password=" do
      before { user.update! password: "Aa@12345678" }

      it { expect(BCrypt::Password.new(user.password_encrypted).is_password?("Aa@12345678")).to eq true }
    end
  end

  describe "class methods" do
    it_behaves_like :filter_and_sort
  end
end
