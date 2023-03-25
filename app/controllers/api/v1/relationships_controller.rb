# frozen_string_literal: true

class Api::V1::RelationshipsController < Api::V1::BaseController
  def create
    current_user.relationships.create! followed_id: params[:followed_id]

    render_json data: {}, meta: {}
  end
end
