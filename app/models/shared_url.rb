# frozen_string_literal: true

class SharedUrl < ApplicationRecord
  belongs_to :user

  validates :url, presence: true

  scope :lastest, -> { order updated_at: :desc }
end
