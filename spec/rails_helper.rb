# frozen_string_literal: true

require "methods_helper"
require "spec_helper"
require "shoulda/matchers"
require "simplecov"
SimpleCov.start do
  enable_coverage :branch

  skip_files = %w[application_controller.rb sessions_controller.rb shared_urls_controller.rb
                  static_pages_controller.rb users_controller.rb].freeze
  add_filter do |src_file|
    File.basename(src_file.filename).in? skip_files
  end

  add_filter %r{^/config/}
  add_filter %r{^/db/}
  add_filter %r{^/spec/}

  add_group "Controllers", "app/controllers"
  add_group "Forms", "app/forms"
  add_group "Helpers", "app/helpers"
  add_group "Jobs", %w[app/jobs app/workers]
  add_group "Models", "app/models"
  add_group "Serializers", "app/serializers"
  add_group "Services", "app/services"
  add_group "Libraries", "lib/"

  track_files "{app,lib}/**/*.rb"
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include Shoulda::Matchers::ActiveModel, type: :model
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include MethodsHelper
end
