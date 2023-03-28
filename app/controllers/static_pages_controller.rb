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
    HTTParty.get combined(api_v1_shared_urls_path)
  end

  def users_shared_urls
    HTTParty.get combined(api_v1_users_shared_urls_path), headers: jwt_header
  end
end
