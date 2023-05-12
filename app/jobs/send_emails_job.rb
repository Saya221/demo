# frozen_string_literal: true

class SendEmailsJob < ApplicationJob
  sidekiq_options queue: SidekiqQueue::SEND_EMAILS, retry: Settings.sidekiq.mailers.retry

  def perform(args = {})
    @args = args.deep_symbolize_keys!
    @email_type = args[:email_type]
    send_emails
  end

  private

  attr_reader :args, :email_type, :jobs_log_path, :logger, :response

  def send_emails
    create_jobs_log

    File.open("#{jobs_log_path}/#{Time.current.to_i / Settings.epoch_time.day_in_secs}.log", "a") do |file|
      @logger = Logger.new(file)
      processing
    end
  end

  def create_jobs_log
    @jobs_log_path = "#{Rails.root}/log/jobs/send_emails"
    FileUtils.mkdir_p(jobs_log_path) unless Dir.exist?(jobs_log_path)
  end

  def processing
    logger.info "--Start send #{email_type}--"
    @response = Api::V1::SendEmailsService.new(args.except(:email_type)).perform
    response_logger_messages
    logger.info "--Finish--"
  rescue => e
    logger.info "Service errors: #{e.message}"
  end

  def response_logger_messages
    if response[:status_code]&.in?(Settings.sendgrid.success_code)
      logger.info "--Send email(s) successfully"
    else
      message = "--SendGrid API headers-- \n#{response[:headers]}\n" \
                "--SendGrid API status_code-- \n#{response[:status_code]}\n" \
                "--SendGrid API errors-- \n#{response[:body]}"
      logger.info(message)
    end
  end
end
