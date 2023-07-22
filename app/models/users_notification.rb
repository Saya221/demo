# frozen_string_literal: true

class UsersNotification < ApplicationRecord
  acts_as_paranoid

  # Concerns
  include Partition

  # Associations
  belongs_to :user
  belongs_to :notification

  # Validations
  validates_uniqueness_of :user_id, scope_to: :notification_id
end
