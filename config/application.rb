require_relative "boot"
require_relative "../app/middlewares/routing_error_middleware"

require "rails/all"

Bundler.require(*Rails.groups)

module Demo
  class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq
    config.eager_load_paths += %W( #{config.root}/lib #{config.root}/config/routes )
    config.load_defaults 7.0
    config.middleware.use RoutingErrorMiddleware
    config.time_zone = "Hanoi"
  end
end
