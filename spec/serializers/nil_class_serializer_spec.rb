# frozen_string_literal: true

require "rails_helper"

RSpec.describe NilClassSerializer do
  describe "#to_hash" do
    let(:response_data) { described_class.new(nil).to_hash }

    it { expect(response_data).to eq I18n.t(:message, scope: :nil_class) }
  end
end
