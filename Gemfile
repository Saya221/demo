# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "active_model_serializers"
gem "bcrypt"
gem "bootsnap", require: false
gem "config"
gem "figaro"
gem "jwt"
gem "pagy"
gem "paranoia"
gem "pg", "~> 1.5", ">= 1.5.2"
gem "puma"
gem "rack-cors"
gem "rails", "~> 7.0.4"

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
  gem "spring"
  gem "spring-watcher-listen"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
