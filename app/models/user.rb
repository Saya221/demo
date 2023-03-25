# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  include BCrypt

  has_many :user_sessions, dependent: :destroy
  has_many :shared_urls, dependent: :destroy
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :relationships, source: :followed

  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_encrypted, presence: true

  def password
    @password ||= Password.new password_encrypted
  end

  def password=(new_password)
    @password = Password.create new_password
    self.password_encrypted = @password
  end
end
