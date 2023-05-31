# frozen_string_literal: true

module Users
  module InstanceMethods
    extend ActiveSupport::Concern

    NOT_ASYNC_ATTRS = %w[password_encrypted created_at updated_at].freeze

    included do
      after_validation :async_attrs
      after_commit :async_job

      def password
        return unless password_encrypted

        @password ||= BCrypt::Password.new password_encrypted
      end

      def password=(new_password)
        @password = new_password
        self.password_encrypted = BCrypt::Password.create @password
      end

      private

      def async_job
        @action ||= Action::DESTROY
        AsyncDataJob.perform_async({ id:, action: @action, attributes: @async_attrs }.as_json)
      end

      def async_attrs
        @action = Action::UPDATE
        attrs = changed - NOT_ASYNC_ATTRS
        attrs = slice(attrs).transform_values { |value| value.nil? ? "nil" : value }
        @async_attrs = password_changed? ? attrs.merge(password:) : attrs
      end
    end
  end
end
