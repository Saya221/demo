# frozen_string_literal: true

module SessionsHelper
  include HTTParty

  def logged_in?
    session["Jwt-Authorization"].present?
  end

  def current_user
    @current_user ||= User.find_by! id: user_id
  end

  def combined(url)
    "#{ENV['SERVER_HOST']}/#{url}"
  end

  private

  def user_id
    response = HTTParty.get combined(api_v1_users_path), headers: jwt_header

    if response["success"]
      response["data"]["user"]["id"]
    else
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def jwt_header
    {
      "Jwt-Authorization": "Bearer #{session['Jwt-Authorization']}"
    }
  end

  def store_location
    # session[:forwarding_url] = request.original_url if request.get?
  end
end
