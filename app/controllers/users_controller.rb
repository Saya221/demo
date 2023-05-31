# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    load_params

    if sign_up_user["success"]
      session["Jwt-Authorization"] = access_token
      redirect_to root_path
    else
      flash.now[:danger] = sign_up_user["errors"][0]["message"]
      render :new
    end
  end

  private

  attr_reader :name, :email, :password

  def load_params
    @name = params[:user][:name]
    @email = params[:user][:email]
    @password = params[:user][:password]
  end

  def sign_up_user
    @sign_up_user ||= HTTParty.post combined(api_v1_sign_up_users_path), body: request_body
  end

  def request_body
    {
      user: { name:, email:, password: }
    }
  end

  def access_token
    body = { user: { email:, password: } }
    access_token = HTTParty.post(combined(api_v1_login_path), body:)
    access_token["data"]["token_info"]["access_token"]
  end
end
