# frozen_string_literal: true

class Api::V1::Users::SharedUrlsController < Api::V1::BaseController
  def index
    render_json current_user.shared_urls, serializer: Api::V1::SharedUrlSerializer, type: :list_user_shared_urls
  end

  def create
    current_user.shared_urls.create! youtube_url_processing.merge!(url: params[:url])

    render_json data: {}, meta: {}
  end

  private

  def youtube_url_processing
    raise ActionController::ParameterMissing, nil unless params[:url].present?

    Api::V1::YoutubeUrlProcessingService.new(params[:url].split("v=").last).perform
  end
end
