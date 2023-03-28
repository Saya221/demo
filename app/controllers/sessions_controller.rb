# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    if login["success"]
      session["Jwt-Authorization"] = access_token
      redirect_to root_path
    else
      flash.now[:danger] = login["errors"][0]["message"]
      render :new
    end
  end

  def destroy
    logout
    session["Jwt-Authorization"] = nil

    redirect_to root_path
  end

  private

  def login
    @login ||= HTTParty.post combined(api_v1_login_path), body: login_request_body
  end

  def login_request_body
    {
      user: {
        email: params[:session][:email],
        password: params[:session][:password]
      }
    }
  end

  def access_token
    @access_token ||= login["data"]["token_info"]["access_token"]
  end

  def logout
    HTTParty.delete combined(api_v1_logout_path), headers: jwt_header
  end
end
