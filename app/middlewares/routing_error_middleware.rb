# frozen_string_literal: true

require "json"

class RoutingErrorMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    @response = app.call(env)

    if routing_error?
      status = 404
      headers = { "Content-Type" => "application/json" }
      [status, headers, [routing_error_response.to_json]]
    else
      response
    end
  end

  private

  attr_reader :app, :response

  def routing_error?
    response == [404, { "X-Cascade" => "pass" }, ["Not Found"]]
  end

  def routing_error_response
    {
      success: false,
      errors: [I18n.t("errors.route.not_found")]
    }
  end
end
