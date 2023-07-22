# frozen_string_literal: true

class SharedUrl < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :url, presence: true

  # Scopes
  scope :latest, -> { order updated_at: :desc }
end
