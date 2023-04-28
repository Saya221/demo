# frozen_string_literal: true

class Api::V1::NotificationsController < Api::V1::BaseController
  before_action :check_topic_params, only: %i[create]

  def create
    notification = Api::V1::NotificationsForm.new(params, current_user).create!

    render_json notification
  end

  private

  def check_topic_params
    return if Notification.topics.keys.include?(params[:topic])

    raise Api::Error::ControllerRuntimeError, :invalid_topic
  end
end
