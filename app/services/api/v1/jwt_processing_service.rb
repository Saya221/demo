# frozen_string_literal: true

class Api::V1::JwtProcessingService < Api::V1::BaseService
  def initialize(attributes = {})
    @current_user = attributes[:current_user]
    @current_session = attributes[:current_session]
    @current_time = attributes[:current_time]
  end

  def encode
    JWT.encode payload, ENV["SECRET_KEY_BASE"], Settings.jwt.algorithm
  end

  private

  attr_reader :current_user, :current_session, :current_time

  def payload
    {
      user_id: current_user.id,
      session_token: current_session.session_token,
      iat: current_time,
      exp: current_time + Settings.jwt.expiration_time
    }
  end
end
