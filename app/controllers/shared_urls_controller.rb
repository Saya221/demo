

class SharedUrlsController < ApplicationController
  before_action :logged_in_user, only: %i[new create]

  def new; end

  def create
    if shared_urls["success"]
      redirect_to root_path
    else
      flash.now[:danger] = shared_urls["errors"][0]["message"]
      redirect_to root_path
    end
  end

  private

  def shared_urls
    @shared_urls ||=
      HTTParty.post(
        "http://localhost:3000/api/v1/users/#{current_user.id}/shared_urls",
        headers: jwt_header,
        body: { url: params[:url] }
      )
  end
end
