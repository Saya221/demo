# frozen_string_literal: true

class Api::V1::SharedUrlSerializer < Api::V1::BaseSerializer
  attributes %i[id url description thumbnail_url movie_title user]

  def attributes *attrs
    super.slice(*fields_custom[:shared_urls])
  end

  def user
    return unless fields_custom[:shared_urls].include?(:user)

    Api::V1::UserSerializer.new object.user
  end

  ROOT = {
    shared_urls: %i[id url description thumbnail_url movie_title user]
  }.freeze

  LIST_USER_SHARED_URLS = {
    shared_urls: %i[id url description thumbnail_url movie_title]
  }.freeze
end
