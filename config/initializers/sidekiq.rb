Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379") }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379") }
  config.on(:startup) do
    Sidekiq.schedule =
      YAML.load_file(File.expand_path(ENV.fetch("SCHEDULE_FILE_PATH", "../sidekiq_scheduler.yml"), __FILE__))
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end

Sidekiq.logger.level = Logger::WARN
