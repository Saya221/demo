# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
  end

  def render404
    render file: Rails.public_path.join("errors/404.html"), status: :not_found
  end

  def render500
    render file: Rails.public_path.join("errors/500.html"), status: :internal_server_error
  end
end
