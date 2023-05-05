# frozen_string_literal: true

class UsersNotification < ApplicationRecord
  include PartitionHelpers

  acts_as_paranoid

  belongs_to :user
  belongs_to :notification

  validates_uniqueness_of :user_id, scope_to: :notification_id
end
