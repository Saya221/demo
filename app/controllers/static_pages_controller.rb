# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def index
    if logged_in?
      @users_shared_urls = users_shared_urls
    else
      @shared_urls = shared_urls
    end
  end

  private

  def shared_urls
    HTTParty.get("http://localhost:3000/api/v1/shared_urls")
  end

  def users_shared_urls
    HTTParty.get("http://localhost:3000/api/v1/users/#{current_user.id}/shared_urls", headers: jwt_header)
  end
end
