# frozen_string_literal: true

module Users
  module Validations
    extend ActiveSupport::Concern

    included do
      validates :email, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

      validate :password_format, if: :password_changed?

      private

      def password_format
        return true if @password&.match?(Settings.user.password.regexp)

        errors.add(:password, :wrong_format, minimum: Settings.user.password.minimum)
      end

      def password_changed?
        new_record? || password_encrypted_changed?
      end
    end
  end
end
