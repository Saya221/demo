# frozen_string_literal: true

class UsersNotification < ApplicationRecord
  include Partition

  acts_as_paranoid

  belongs_to :user
  belongs_to :notification

  validates_uniqueness_of :user_id, scope_to: :notification_id
end
