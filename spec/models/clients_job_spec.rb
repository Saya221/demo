# frozen_string_literal: true

RSpec.describe ClientsJob, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to belong_to(:job) }
  end

  describe "validations" do
    it { is_expected.to validate_uniqueness_of(:job_id).scoped_to(:client_id).case_insensitive }
  end
end
