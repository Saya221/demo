# frozen_string_literal: true

class Api::V1::SharedUrlsController < Api::V1::BaseController
  def create
    current_user.shared_urls.create! url: params[:url]

    render_json data: {}, meta: {}
  end
end
