class SidekiqQueue
  SEND_EMAILS = "send_emails".freeze
  CONSUMER = "consumer".freeze
end

class Action
  UPDATE = :update!.freeze
end

UNAUTHORIZED_ERRORS = %i[inactive_user].freeze
