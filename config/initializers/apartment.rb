# frozen_string_literal: true

require "#{Rails.application.config.root}/app/modules/set_current_tenant"

Apartment.configure do |config|
  config.excluded_models = %w{ Tenant }
  config.tenant_names = -> { Tenant.pluck :host }
end

Rails.application.config.middleware.use SetCurrentTenant
