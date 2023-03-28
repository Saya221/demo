# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if sign_up_user["success"]
      login
      session["Jwt-Authorization"] = access_token
      redirect_to root_path
    else
      flash.now[:danger] = sign_up_user["errors"][0]["message"]
      render :new
    end
  end

  private

  def sign_up_user
    @sign_up_user ||= HTTParty.post combined(api_v1_sign_up_users_path), body: request_body
  end

  def request_body
    {
      user: {
        name: params[:user][:name],
        email: params[:user][:email],
        password: params[:user][:password]
      }
    }
  end

  def login
    @login ||= HTTParty.post combined(api_v1_login_path), body: login_request_body
  end

  def login_request_body
    {
      user: {
        email: params[:user][:email],
        password: params[:user][:password]
      }
    }
  end

  def access_token
    @access_token ||= login["data"]["token_info"]["access_token"]
  end
end
