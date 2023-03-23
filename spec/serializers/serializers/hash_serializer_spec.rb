# frozen_string_literal: true

require "rails_helper"

RSpec.describe HashSerializer do
  let(:hash) { { a: 1, b: 2 } }

  describe "#to_hash" do
    context "root eq true" do
      let(:response_data) { described_class.new(hash, root: true).to_hash }

      it { expect(response_data).to eq({ data: hash }) }
    end

    context "root eq custom key" do
      let(:custom_sym) { described_class.new(hash, root: :custom).to_hash }
      let(:custom_int) { described_class.new(hash, root: 1).to_hash }
      let(:response_data) { { custom: hash } }

      it { expect(custom_sym).to eq response_data }
      it { expect(custom_int).to eq({ nil => hash }) }
    end

    context "dont have args root" do
      let(:response_data) { described_class.new(hash).to_hash }

      it { expect(response_data).to eq hash }
    end
  end
end
