# frozen_string_literal: true

class Api::V1::SendEmailsService < Api::V1::BaseService
  include SendGrid

  # args = {
  #   sender: { email: "renkyrou1708@gmail.com" },
  #   reply_to: { email: "renkyrou@gmail.com" },
  #   template_id: ENV["DEFAULT_TEMPLATE_ID"],
  #   dynamic_template_data: {
  #     name: "NGUYEN LE"
  #   },
  #   to: [ "le.hoang.nguyen.bedev@gmail.com", "nguyenlh.deploy.aws@gmail.com" ]
  # }

  def initialize(args = {})
    @args = args
    @from = args[:sender][:email] || ENV["DEFAULT_EMAIL_FROM"]
    @reply_to = args[:reply_to][:email] || ENV["DEFAULT_REPLY_TO"]
    @template_id = args[:template_id] || ENV["DEFAULT_TEMPLATE_ID"]
  end

  def perform
    response = SG.client.mail._("send").post(request_body: mail_attributes.to_json)
    return default_response unless response

    {
      headers: response.headers,
      status_code: response.status_code,
      body: response.body
    }
  end

  private

  attr_reader :args, :from, :reply_to, :template_id

  def mail_attributes
    {
      from: { email: from },
      reply_to: { email: reply_to },
      template_id: template_id,
      personalizations: [personalizations]
    }
  end

  def personalizations
    {
      to: array_to_hash(args[:to]),
      dynamic_template_data: args[:dynamic_template_data]
    }
  end

  def array_to_hash(emails)
    emails.map { |email| { email: email } }
  end

  def default_response
    {
      headers: nil,
      status_code: nil,
      body: nil
    }
  end
end
