# frozen_string_literal: true

class UsersNotification < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :notification

  validates_uniqueness_of :user_id, scope_to: :notification_id

  class << self
    def set_table_name(timestamp = nil)
      self.table_name =
        if timestamp.present?
          get_table_name(timestamp)
        else
          get_table_name(Time.current)
        end
    end

    def get_table_name(timestamp)
      "#{name.pluralize.underscore}_" + timestamp.strftime(Settings.format.datetime.year_month).to_s
    end
  end
end
