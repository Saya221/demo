class APP
  NAME = Rails.application.class.module_parent_name.downcase.freeze
end

class SIDEKIQ_QUEUES
  SEND_EMAILS = "send_emails".freeze
  PRODUCER = "producer".freeze
end

class ACTION
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

UNAUTHORIZED_ERRORS = %i[inactive_user].freeze
SORT_DIRECTIONS = %i[asc ASC desc DESC].freeze
