# frozen_string_literal: true

require "rails_helper"

RSpec.describe UnauthorizedRequestSerializer do
  let(:response_data) { described_class.new(nil).serialize }

  describe "#serialize" do
    it do
      expect(response_data[:success]).to eq false
      expect(response_data[:errors][0][:code]).to eq 1201
    end
  end
end
