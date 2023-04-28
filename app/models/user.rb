# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  include BCrypt

  enum role: %i[admin staff]

  has_many :user_sessions, dependent: :destroy
  has_many :shared_urls, dependent: :destroy
  has_many :users_notifications, dependent: :destroy
  has_many :notifications, through: :users_notifications

  validates :email, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_encrypted, presence: true

  def password
    @password ||= Password.new password_encrypted
  end

  def password=(new_password)
    @password = Password.create new_password
    self.password_encrypted = @password
  end
end
