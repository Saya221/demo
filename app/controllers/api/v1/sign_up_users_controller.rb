# frozen_string_literal: true

class Api::V1::SignUpUsersController < Api::V1::BaseController
  skip_before_action :authenticate_request, only: %i[create]

  def create
    user = User.create! user_params

    render_json user
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password
  end
end
