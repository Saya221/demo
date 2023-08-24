# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "active_model_serializers"
gem "bcrypt"
gem "bootsnap", require: false
gem "bootstrap-sass"
gem "caxlsx", "~> 3.4", ">= 3.4.1"
gem "config"
gem "fcm", "~> 1.0", ">= 1.0.8"
gem "figaro"
gem "google-api-client"
gem "googleauth"
gem "httparty", ">= 0.21.0"
gem "jwt"
gem "pagy"
gem "paranoia"
gem "pg", "~> 1.5", ">= 1.5.2"
gem "puma"
gem "rack-cors"
gem "rails", "~> 7.0.5.1"
gem "redis", "~> 5.0", ">= 5.0.6"
gem "ruby-kafka", "~> 1.5"
gem "sass-rails"
gem "sendgrid-ruby", "~> 6.6", ">= 6.6.2"
gem "sentry-rails", "~> 5.9"
gem "sentry-ruby", "~> 5.9"
gem "sentry-sidekiq", "~> 5.9"
gem "sidekiq", "~> 7.0", ">= 7.0.9"
gem "sidekiq-scheduler", "~> 5.0", ">= 5.0.3"

group :development, :test do
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-rails"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "simplecov"
end

group :development do
  gem "brakeman", require: false
  gem "listen"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rspec", require: false
  gem "spring"
  gem "spring-watcher-listen"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
