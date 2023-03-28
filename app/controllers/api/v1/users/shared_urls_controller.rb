# frozen_string_literal: true

class Api::V1::Users::SharedUrlsController < Api::V1::BaseController
  def index
    render_json current_user.shared_urls, serializer: Api::V1::SharedUrlSerializer, type: :list_user_shared_urls
  end

  def create
    current_user.shared_urls.create! url: params[:url]

    render_json data: {}, meta: {}
  end
end
