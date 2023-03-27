# frozen_string_literal: true

class SharedUrl < ApplicationRecord
  belongs_to :user

  validates :url, presence: true
end
