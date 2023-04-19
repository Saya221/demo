require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module MultiTenants
  class Application < Rails::Application
    config.eager_load_paths += %W( #{config.root}/lib )
    config.hosts.push("lvh.me","xip.io")
    config.load_defaults 7.0
    config.time_zone = "Hanoi"
  end
end
