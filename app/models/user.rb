# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  has_many :user_sessions, dependent: :destroy

  enum role: %i[admin staff]
  enum status: %i[inactive active]

  validates :email, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  validate :password_format, if: :password_changed?

  def password
    return unless password_encrypted

    @password ||= BCrypt::Password.new password_encrypted
  end

  def password=(new_password)
    @password = new_password
    self.password_encrypted = BCrypt::Password.create @password
  end

  private

  def password_format
    return true if @password&.match?(Settings.user.password.regexp)

    errors.add(:password, :wrong_format, at_least: Settings.user.password.at_least)
  end

  def password_changed?
    new_record? || password_encrypted_changed?
  end
end
