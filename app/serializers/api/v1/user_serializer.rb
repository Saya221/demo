# frozen_string_literal: true

class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes %i[id name email role status]

  def attributes *attrs
    super.slice(*fields_custom[:users])
  end

  ROOT = {
    users: %i[id name email]
  }.freeze

  ALGOLIA = {
    users: %i[id name email role status]
  }
end
