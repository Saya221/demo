# frozen_string_literal: true

class SetCurrentTenant
  def initialize(app)
    @app = app
  end

  def call(env)
    @host = env["HTTP_HOST"].split(":").first&.gsub(".", "_")
    schema_name = host_to_schema
    env["schema_name"] = schema_name
    app.call(env)
  end

  private

  attr_reader :app, :host

  def host_to_schema
    return Apartment::Tenant.switch!(host) if Tenant.exists?(host: host)

    ActiveRecord::Base.transaction do
      Apartment::Tenant.create(host)
      Tenant.create! host: host
    end
  end
end
