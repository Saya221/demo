# frozen_string_literal: true

module APP
  NAME = Rails.application.class.module_parent_name.downcase.freeze
end

module SIDEKIQ_QUEUES
  SEND_EMAILS = "send_emails"
  PRODUCER = "producer"
end

module ACTION
  UPDATE = :update!
  DESTROY = :destroy!
end

module TELEGRAM
  class CODE
    SUCCESS = [200, 201, 202]
  end

  class END_POINTS
    SEND_MESSAGE = "https://api.telegram.org/bot#{ENV.fetch('BOT_TOKEN', nil)}/sendMessage"
    SEND_POLL = "https://api.telegram.org/bot#{ENV.fetch('BOT_TOKEN', nil)}/sendPoll"
    GET_UPDATES = "https://api.telegram.org/bot#{ENV.fetch('BOT_TOKEN', nil)}/getUpdates"
  end
end

UNAUTHORIZED_ERRORS = %i[inactive_user]
SORT_DIRECTIONS = %i[asc ASC desc DESC]
