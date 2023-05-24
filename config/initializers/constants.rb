class SidekiqQueue
  SEND_EMAILS = "send_emails".freeze
  PRODUCER = "producer".freeze
end

class Action
  UPDATE = :update!.freeze
  DESTROY = :destroy!.freeze
end

UNAUTHORIZED_ERRORS = %i[inactive_user].freeze
