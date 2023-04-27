# frozen_string_literal: true

class Notification < ApplicationRecord
  acts_as_paranoid

  belongs_to :creator, foreign_key: :creator_id, class_name: User.name

  enum topic: %i[admin staff]
end
