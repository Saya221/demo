# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if sign_up_user["success"]
      redirect_to root_path
    else
      flash.now[:danger] = sign_up_user["errors"][0]["message"]
      render :new
    end
  end

  private

  def sign_up_user
    @sign_up_user ||=
      HTTParty.post(
        "http://localhost:3000/api/v1/sign_up_users",
        body: {
          user: {
            name: params[:user][:name],
            email: params[:user][:email],
            password: params[:user][:password]
          }
        }
      )
  end
end
