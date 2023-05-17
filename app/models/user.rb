# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  include Users::Associations
  include Users::InstanceMethods
  include Users::Validations
  include Users::Scopes

  enum role: %i[admin staff]
  enum status: %i[inactive active]
end
