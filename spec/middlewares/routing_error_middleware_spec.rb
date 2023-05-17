# frozen_string_literal: true

require "rack/test"
require "rails_helper"

RSpec.describe RoutingErrorMiddleware do
  include Rack::Test::Methods

  subject(:middleware) { described_class.new(app) }

  describe "#call" do
    let(:call) { middleware.call({}) }
    let(:response_data) { JSON.parse(*call[2]).deep_symbolize_keys! }

    context "with routing error" do
      let(:app) { ->(_env) { [404, { "X-Cascade" => "pass" }, ["Not Found"]] } }

      it do
        expect(call[0]).to eq 404
        expect(response_data[:success]).to eq false
        expect(response_data[:errors][0][:code]).to eq 1299
      end
    end

    context "with the others" do
      let(:app) { ->(_env) { [200, {}, ["Success"]] } }

      it do
        expect(call[0]).to eq 200
        expect(call[2]).to eq ["Success"]
      end
    end
  end
end
