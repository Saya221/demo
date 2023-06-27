class SidekiqQueue
  SEND_EMAILS = "send_emails".freeze
  PRODUCER = "producer".freeze
end

class Action
  UPDATE = :update!
  DESTROY = :destroy!
end

UNAUTHORIZED_ERRORS = %i[inactive_user].freeze
SORT_DIRECTIONS = %i[asc ASC desc DESC].freeze
