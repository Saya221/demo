# frozen_string_literal: true

class ApplicationJob
  def perform(args = {})
    @args = args.deep_symbolize_keys!
    @args = args
  end

  protected

  attr_reader :args, :jobs_log_path, :logger

  def create_jobs_log
    @jobs_log_path = "#{Rails.root}/log/jobs/#{self.class.name.underscore.slice(0..-5)}"
    FileUtils.mkdir_p(jobs_log_path) unless Dir.exist?(jobs_log_path)
  end

  def execute
    create_jobs_log

    File.open("#{jobs_log_path}/#{Time.current.to_i / Settings.epoch_time.day_in_secs}.log", "a") do |file|
      @logger = Logger.new(file)
      processing
    end
  end
end
