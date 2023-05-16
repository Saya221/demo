# frozen_string_literal: true

class UnauthorizedRequestSerializer
  def initialize(error)
    @error = error
  end

  def serialize
    {
      success: false,
      errors: [response]
    }
  end

  private

  attr_reader :error

  def response
    if error.in? UNAUTHORIZED_ERRORS
      I18n.t(error, scope: %i[errors action unauthorized])
    else
      I18n.t(:unauthorized, scope: %i[errors action]).except(*UNAUTHORIZED_ERRORS)
    end
  end
end
