# frozen_string_literal: true

class Notification < ApplicationRecord
  acts_as_paranoid

  enum topic: %i[admin staff]

  belongs_to :creator, foreign_key: :creator_id, class_name: User.name

  validates :content, presence: true
end
