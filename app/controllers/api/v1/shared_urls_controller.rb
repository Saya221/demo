# frozen_string_literal: true

class Api::V1::SharedUrlsController < Api::V1::BaseController
  skip_before_action :authenticate_request, only: %i[index]

  def index
    shared_urls = SharedUrl.lastest.all.includes(:user)
    pagy_info, shared_urls = paginate shared_urls

    render_json shared_urls, meta: pagy_info
  end
end
