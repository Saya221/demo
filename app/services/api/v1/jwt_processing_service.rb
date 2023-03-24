# frozen_string_literal: true

class Api::V1::JwtProcessingService < Api::V1::BaseService
  def initialize(attributes = {})
    @current_user = attributes[:current_user]
    @current_session = attributes[:current_session]
    @current_time = attributes[:current_time]
    @access_token = attributes[:access_token]
  end

  def encode
    JWT.encode payload, ENV["SECRET_KEY_BASE"], Settings.jwt.algorithm
  end

  def decode
    load_request_info

    {
      current_session: current_session,
      current_user: current_user
    }
  end

  private

  attr_reader :current_user, :current_session, :current_time, :access_token

  def payload
    {
      user_id: current_user.id,
      session_token: current_session.session_token,
      iat: current_time,
      exp: current_time + Settings.jwt.expiration_time
    }
  end

  def load_request_info
    @current_user = User.find_by id: decoded_token[0]["user_id"]
    @current_session = current_user&.user_sessions&.find_by session_token: decoded_token[0]["session_token"]

    raise Api::Error::ServiceExecuteFailed, :invalid_token unless current_user && current_session
  end

  def decoded_token
    @decoded_token ||=
      JWT.decode access_token, ENV["SECRET_KEY_BASE"], true, { algorithm: Settings.jwt.algorithm }
  end
end
