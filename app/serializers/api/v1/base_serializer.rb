# frozen_string_literal: true

class Api::V1::BaseSerializer < BaseSerializer
  def initialize(object, option = {})
    @fields_custom = self.class.const_get option[:type].present? ? option[:type].upcase : :ROOT
    super
  end

  private

  attr_reader :fields_custom
end
