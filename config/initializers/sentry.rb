Sentry.init do |config|
  config.dsn = ENV["SENTRY_DSN"]
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  config.enabled_environments = ENV.fetch("SENTRY_ENABLED_ENVIRONMENTS", "development").split(",")
  config.environment = Rails.env

  config.send_default_pii = true
  config.traces_sampler = lambda do |context|
    ENV["SENTRY_TRACES_SAMPLER_RATE"].to_i
  end

  config.sidekiq.report_after_job_retries = true
end
