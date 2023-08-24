# frozen_string_literal: true

class SendEmailsJob < ApplicationJob
  sidekiq_options queue: SIDEKIQ_QUEUES::SEND_EMAILS, retry: Settings.sidekiq.mailers.retry

  def perform(args = {})
    super
    @email_type = args[:email_type]
    @to = args[:to]
    execute
  end

  private

  attr_reader :args, :email_type, :to

  def processing
    logger.info "--Start send #{email_type}--"
    send_emails_by_batch
    logger.info "--Finish--"
  rescue StandardError => e
    logger.info "Service errors: #{e.message}"
  end

  def send_emails_by_batch
    to.each_slice(Settings.sendgrid.batch_size) do |emails|
      response_logger_messages(
        Api::V1::SendEmailsService.new(args.except(:email_type).merge!(to: emails)).perform,
        emails
      )
    end
  end

  def response_logger_messages(response, emails)
    if response[:status_code]&.in?(Settings.sendgrid.success_code)
      logger.info "--Send email(s) #{emails} successfully"
    else
      message = "--SendGrid API headers-- \n#{response[:headers]}\n" \
                "--SendGrid API status_code-- \n#{response[:status_code]}\n" \
                "--SendGrid API errors-- \n#{response[:body]}"
      logger.info(message)
    end
  end
end
