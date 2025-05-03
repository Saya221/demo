# frozen_string_literal: true

class Role < ApplicationRecord
  acts_as_paranoid

  # Associations
  belongs_to :creator, class_name: User.name
  belongs_to :last_updater, class_name: User.name

  # Validations
  validates :name, presence: true
end
