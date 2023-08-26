require_relative "boot"
require_relative "../app/middlewares/routing_error_middleware"

require "rails"
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
require "action_text/engine"
# require "action_view/railtie"
# require "action_cable/engine"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Demo
  class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq
    config.eager_load_paths += %W[#{config.root}/lib #{config.root}/config/routes]
    config.load_defaults 7.0
    config.middleware.use RoutingErrorMiddleware
    config.time_zone = "Hanoi"
  end
end
