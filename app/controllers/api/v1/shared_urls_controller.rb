# frozen_string_literal: true

class Api::V1::SharedUrlsController < Api::V1::BaseController
  skip_before_action :authenticate_request, only: %i[index]

  def index
    render_json SharedUrl.latest.all.includes(:user)
  end
end
