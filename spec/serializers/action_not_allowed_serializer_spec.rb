# frozen_string_literal: true

require "rails_helper"

RSpec.describe ActionNotAllowedSerializer do
  let(:error) { ActionController::MethodNotAllowed.new }
  let(:response_data) { described_class.new(error).serialize }

  describe "#serialize" do
    it do
      expect(response_data[:success]).to eq false
      expect(response_data[:errors][0][:code]).to eq 1202
    end
  end
end
