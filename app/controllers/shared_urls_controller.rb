# frozen_string_literal: true

class SharedUrlsController < ApplicationController
  before_action :logged_in_user, only: %i[new create]

  def new; end

  def create
    flash.now[:danger] = shared_urls["errors"][0]["message"] unless shared_urls["success"]
    redirect_to root_path
  end

  private

  def shared_urls
    @shared_urls ||=
      HTTParty.post(
        combined(api_v1_users_shared_urls_path),
        headers: jwt_header, body: { url: params[:url] }
      )
  end
end
