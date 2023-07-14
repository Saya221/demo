# frozen_string_literal: true

class NilClassSerializer
  def initialize(_object, options = {}); end

  def to_hash
    I18n.t :message, scope: :nil_class
  end
end
