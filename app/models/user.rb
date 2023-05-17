# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  include BCrypt
  include UserConcern

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
