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
    HTTParty.get(
      "http://localhost:3000/api/v1/users",
      headers: {
        "Jwt-Authorization": "Bearer " + session["Jwt-Authorization"]
      }
    )["data"]["user"]["id"]
  end
end
