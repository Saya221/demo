# frozen_string_literal: true

RSpec.describe Job, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:creator).class_name(User.name) }
    it { is_expected.to belong_to(:last_updater).class_name(User.name) }
    it { is_expected.to have_many(:clients_jobs).dependent(:destroy) }
    it { is_expected.to have_many(:clients).through(:clients_jobs) }
  end

  describe "validations" do
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:salary) }

    it do
      expect(described_class.new).to validate_numericality_of(:working_hours).is_greater_than(0)
                                                                             .is_less_than(10)
                                                                             .only_integer
    end
  end

  describe "enumerations" do
    it { expect(described_class.salary_currencies).to include("USD", "EUR", "JPY") }
  end
end
