# frozen_string_literal: true

module Users
  module Associations
    extend ActiveSupport::Concern

    included do
      has_many :user_sessions, dependent: :destroy
      has_many :shared_urls, dependent: :destroy
      has_many :users_notifications, dependent: :destroy
      has_many :notifications, through: :users_notifications
    end
  end
end
