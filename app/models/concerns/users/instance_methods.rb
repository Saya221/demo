# frozen_string_literal: true

module Users
  module InstanceMethods
    extend ActiveSupport::Concern

    included do
      after_commit :async_data

      def password
        return unless password_encrypted

        @password ||= BCrypt::Password.new password_encrypted
      end

      def password=(new_password)
        @password = new_password
        self.password_encrypted = BCrypt::Password.create @password
      end

      private

      def async_data
        args = { action: set_action, attributes: attributes }.as_json
        AsyncDataJob.perform_async(args)
      end

      def set_action
        if deleted_at
          :destroy!
        elsif new_record?
          :create!
        else
          :update!
        end
      end
    end
  end
end
