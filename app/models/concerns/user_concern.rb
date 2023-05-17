# frozen_string_literal: true

module UserConcern
  extend ActiveSupport::Concern

  included do
    enum role: %i[admin staff]
    enum status: %i[inactive active]

    has_many :user_sessions, dependent: :destroy
    has_many :shared_urls, dependent: :destroy
    has_many :users_notifications, dependent: :destroy
    has_many :notifications, through: :users_notifications

    validates :email, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

    validate :password_format
  end
end
