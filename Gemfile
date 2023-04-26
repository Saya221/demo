# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "active_model_serializers"
gem "bcrypt"
gem "bootsnap", require: false
gem "bootstrap-sass"
gem "config"
# gem "clockwork"
gem "figaro"
gem "google-api-client"
gem "googleauth"
gem "httparty", "~> 0.18.1"
gem "jwt"
gem "mysql2"
gem "pagy"
gem "paranoia"
gem "puma"
gem "rack-cors"
gem "rails", "~> 7.0.4"
gem "redis", "~> 5.0", ">= 5.0.6"
gem "ros-apartment", require: "apartment"
gem "ruby-kafka", "~> 1.5"
gem "sass-rails"
gem "sendgrid-ruby", "~> 6.6", ">= 6.6.2"
gem "sidekiq", "~> 7.0", ">= 7.0.9"
gem "sidekiq-scheduler", "~> 5.0", ">= 5.0.2"
# gem "whenever", "~> 1.0", require: false

group :development, :test do
  gem "brakeman", require: false
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop", require: false
  gem "shoulda-matchers"
  gem "simplecov"
end

group :development do
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
