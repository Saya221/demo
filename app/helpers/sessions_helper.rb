# frozen_string_literal: true

module SessionsHelper
  include HTTParty

  def logged_in?
    session["Jwt-Authorization"].present?
  end

  def current_user
    @current_user ||= User.find_by! id: user_id
  end

  private

  def user_id
    response = HTTParty.get api_v1_users_path, headers: jwt_header

    response["data"]["user"]["id"] if response["success"]
  end

  def jwt_header
    {
      "Jwt-Authorization": "Bearer #{session['Jwt-Authorization']}"
    }
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
