# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "active_model_serializers"
gem "bcrypt"
gem "bootsnap", require: false
gem "bootstrap-sass"
gem "config"
gem "figaro"
gem "google-api-client"
gem "googleauth"
gem "httparty", "~> 0.18.1"
gem "jwt"
gem "pagy"
gem "paranoia"
gem "pg", "~> 1.5", ">= 1.5.2"
gem "puma"
gem "rack-cors"
gem "rails", "~> 7.0.4"
gem "sass-rails"

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
