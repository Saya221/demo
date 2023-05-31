# README

- Description

  - An example API app
  - Ruby version 3.2.2
  - Rails 7

- Starting rails app

  - bundle install
  - rails s

- Code rules
  Running before push:
  - brakeman (for normal injections)
  - rubocop -A (for coding style)
  - rspec (check file coverage at least > 80%)
