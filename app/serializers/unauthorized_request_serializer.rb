# frozen_string_literal: true

class UnauthorizedRequestSerializer
  def initialize(error)
    @error = error
  end

  def serialize
    {
      success: false,
      errors: [I18n.t(:unauthorized, scope: %i[errors action])]
    }
  end

  private

  attr_reader :error
end
