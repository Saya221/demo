# frozen_string_literal: true

class Api::V1::UsersRelationshipsController < Api::V1::BaseController
  def index
    render_json user.following, serializer: Api::V1::UserSerializer
  end

  private

  def user
    @user ||= User.find_by! id: params[:user_id]
  end
end
