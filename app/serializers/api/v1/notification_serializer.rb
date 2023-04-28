# frozen_string_literal: true

class Api::V1::NotificationSerializer < Api::V1::BaseSerializer
  attributes %i[id topic content creator created_at updated_at]

  def attributes *attrs
    super.slice(*fields_custom[:notifications])
  end

  def creator
    return unless fields_custom[:notifications].include?(:creator)

    Api::V1::UserSerializer.new object.creator
  end

  ROOT = {
    notifications: %i[id topic content creator created_at updated_at]
  }.freeze
end
