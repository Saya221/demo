# frozen_string_literal: true

module Users
  module Validations
    extend ActiveSupport::Concern

    included do
      validates :email, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

      validate :password_format

      private

      def password_format
        return assign_password_encrypted if @password&.match?(Settings.user.password.regexp)

        errors.add(:password, :wrong_format, minimum: Settings.user.password.minimum)
      end

      def assign_password_encrypted
        self.password_encrypted = BCrypt::Password.create(@password)
      end
    end
  end
end
