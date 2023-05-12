# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  include BCrypt

  enum role: %i[admin staff]
  enum status: %i[inactive active]

  has_many :user_sessions, dependent: :destroy
  has_many :shared_urls, dependent: :destroy
  has_many :users_notifications, dependent: :destroy
  has_many :notifications, through: :users_notifications

  validates :email, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  validate :password_format

  def password
    return if @password.nil? && password_encrypted.nil?

    @password ||= Password.new password_encrypted
  end

  attr_writer :password

  private

  def password_format
    return assign_password_encrypted if @password&.match?(Settings.user.password.regexp)

    errors.add(:password, :wrong_format, minimum: Settings.user.password.minimum)
  end

  def assign_password_encrypted
    self.password_encrypted = Password.create(@password)
  end
end
