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
    current_user = nil
    session["Jwt-Authorization"] = nil

    redirect_to root_path
  end

  private

  def login
    @login ||=
      HTTParty.post(
        "http://localhost:3000/api/v1/login",
        body: {
          user: {
            email: params[:session][:email],
            password: params[:session][:password]
          }
        }
      )
  end

  def access_token
    @access_token ||= login["data"]["token_info"]["access_token"]
  end

  def logout
      HTTParty.delete(
        "http://localhost:3000/api/v1/logout",
        headers: {
          "Jwt-Authorization": "Bearer " + session["Jwt-Authorization"]
        }
      )
  end
end
