# frozen_string_literal: true

# require "clockwork"
# require "./config/clock"

namespace :remove do
  desc "Job auto clean attachments unuse"
  task unused_attachments: :environment do
    # Create cronjob log folder
    cronjob_log_path = "#{Rails.root}/log/cronjob/remove_unused_attachments"
    FileUtils.mkdir_p(cronjob_log_path) unless Dir.exist?(cronjob_log_path)

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

# namespace :clockwork do
#   desc "Start the Clockwork scheduler"
#   task :start do
#     Clockwork::run
#   end

#   desc "Stop the Clockwork scheduler"
#   task :stop do
#     pid = File.read("tmp/clockwork.pid").to_i
#     Process.kill("TERM", pid)
#   end

#   desc "Restart the Clockwork scheduler"
#   task :restart => [:stop, :start]
# end
