# frozen_string_literal: true

class Notification < ApplicationRecord
  acts_as_paranoid

  # Associations
  belongs_to :creator, class_name: User.name

  # Validations
  validates :content, presence: true

  # Enumerations
  enum topic: %i[admin staff]
end
