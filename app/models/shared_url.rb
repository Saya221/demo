# frozen_string_literal: true

class SharedUrl < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  validates :url, presence: true
end
