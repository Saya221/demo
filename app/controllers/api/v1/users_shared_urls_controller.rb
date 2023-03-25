# frozen_string_literal: true

class Api::V1::UsersSharedUrlsController < Api::V1::BaseController
  def index
    render_json user.shared_urls, serializer: Api::V1::SharedUrlSerializer
  end

  private

  def user
    @user ||= User.find_by! id: params[:user_id]
  end
end
