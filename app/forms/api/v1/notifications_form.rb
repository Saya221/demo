# frozen_string_literal: true

class Api::V1::NotificationsForm
  def initialize(params, current_user)
    @params = params
    @topic = params[:topic]
    @content = params[:content].present? ? ERB::Util.h(params[:content]) : nil
    @current_user = current_user
  end

  def create!
    ActiveRecord::Base.transaction do
      @notification = Notification.create! topic: topic, content: content, creator: current_user
      User.send(topic).each { |user| user.users_notifications.create! notification: notification }
    end

    notification
  end

  private

  attr_reader :params, :content, :topic, :current_user, :notification
end
