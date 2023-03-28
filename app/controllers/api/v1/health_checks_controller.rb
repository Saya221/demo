# frozen_string_literal: true

class Api::V1::HealthChecksController < Api::V1::BaseController
  skip_before_action :authenticate_request

  def ping
    render json: "pong", status: :ok
  end
end
