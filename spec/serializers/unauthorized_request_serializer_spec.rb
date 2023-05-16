# frozen_string_literal: true

require "rails_helper"

RSpec.describe UnauthorizedRequestSerializer do
  let(:response_data) { described_class.new(type).serialize }

  describe "#serialize" do
    context "without type" do
      let(:type) { nil }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1201
      end
    end

    context "with type inactive_user" do
      let(:type) { :inactive_user }

      it do
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1250
      end
    end
  end
end
