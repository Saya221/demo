# frozen_string_literal: true

class Api::V1::SessionsController < Api::V1::BaseController
  def login
    raise ActionController::ParameterMissing, nil unless params[:user]

    processing_request
    @current_time = Time.current.to_i
    @access_token =
      Api::V1::JwtProcessingService.new(current_user: current_user,
                                        current_session: current_session,
                                        current_time: current_time).encode

    render_json token_info: token_info
  end

  private

  attr_reader :current_user, :current_session, :current_time, :access_token

  def processing_request
    @current_user = User.find_by email: params[:user][:email]
    raise Api::Error::UnauthorizedRequest, nil unless current_user && correct_password?

    @current_session = current_user.user_sessions.create! login_ip: request.ip,
                                                          browser: request.headers["User-Agent"]
  end

  def correct_password?
    current_user.password.is_password? params[:user][:password]
  end

  def token_info
    {
      access_token: access_token,
      token_type: Settings.jwt.token_type,
      expires_in: Settings.jwt.expiration_time,
      created_at: current_time,
      expires_on: current_time + Settings.jwt.expiration_time
    }
  end
end
