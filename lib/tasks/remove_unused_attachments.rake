require "fileutils"
require "logger"
require "rake"

namespace :remove_unused_attachments do
  desc "Job auto clean attachments unuse"
  task remove: :environment do

    # Create cronjob log folder
    cronjob_log_path = "#{Rails.root}/log/cronjob"
    FileUtils.mkdir_p(cronjob_log_path) unless Dir.exists?(cronjob_log_path)

    # Init today logfile
    today = Time.current.to_i / Settings.epoch_time.day_in_secs
    File.open("#{cronjob_log_path}/#{today}.log", "a") do |file|
      logger = Logger.new(file)
      logger.info "--Start task--"
      begin
        ActiveRecord::Base.transaction do
        end
        logger.info "--Finish task--"
      rescue StandardError => e
        logger.info "Database transaction failed: #{e.message}"
      end
    end
  end
end
