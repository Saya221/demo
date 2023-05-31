# frozen_string_literal: true

class Api::V1::NotificationsForm
  def initialize(params, current_user)
    @topic = params[:topic]
    @content = params[:content].present? ? ERB::Util.h(params[:content]) : nil
    @current_user = current_user
  end

  def create!
    ActiveRecord::Base.transaction do
      @notification = Notification.create! topic:, content:, creator: current_user
      User.send(topic).each { |user| user.users_notifications.create! notification: }
    end

    notification
  end

  private

  attr_reader :content, :topic, :current_user, :notification
end
