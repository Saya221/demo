# frozen_string_literal: true

class Api::V1::HealthChecksController < Api::V1::BaseController
  def ping
    render json: "pong", status: :ok
  end
end
