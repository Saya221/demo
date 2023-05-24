# frozen_string_literal: true

module Users
  module InstanceMethods
    extend ActiveSupport::Concern

    included do
      def password
        return unless password_encrypted

        @password ||= BCrypt::Password.new password_encrypted
      end

      def password=(new_password)
        @password = new_password
        self.password_encrypted = BCrypt::Password.create @password
      end
    end
  end
end
