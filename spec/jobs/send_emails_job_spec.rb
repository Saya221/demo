# frozen_string_literal: true

require "rails_helper"

RSpec.describe SendEmailsJob, type: :job do
  describe "#perform" do
    let(:args) do
      {
        dynamic_template_data: {
          name: "NGUYEN LE"
        },
        to: ["le.hoang.nguyen.bedev@gmail.com"],
        email_type: :welcome
      }.as_json
    end

    it do
      expect { described_class.perform_async(args) }
        .to change { Sidekiq::Queues[SIDEKIQ_QUEUES::SEND_EMAILS].size }.by 1
    end
  end
end
