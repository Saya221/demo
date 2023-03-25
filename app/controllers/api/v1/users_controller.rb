# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::BaseController
  def index
    render_json User.all
  end
end
