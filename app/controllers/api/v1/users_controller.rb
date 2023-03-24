# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::BaseController
  def show
    render_json current_user
  end
end
