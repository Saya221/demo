# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find params[:id]

    render_json user
  end
end
