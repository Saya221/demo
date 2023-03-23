# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecordNotFoundSerializer do
  let(:error) { ActiveRecord::RecordNotFound.new("error message", "Model", "key") }
  let(:response_data) { described_class.new(error).serialize }

  describe "#serialize" do
    it do
      expect(response_data[:success]).to eq false
      expect(response_data[:errors][0][:resource]).to eq "model"
      expect(response_data[:errors][0][:code]).to eq 1051
    end
  end
end
