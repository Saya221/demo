# frozen_string_literal: true

module Users
  module InstanceMethods
    extend ActiveSupport::Concern

    included do
      def password
        return if @password.nil? && password_encrypted.nil?

        @password ||= BCrypt::Password.new password_encrypted
      end

      attr_writer :password
    end
  end
end
