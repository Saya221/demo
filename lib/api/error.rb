# frozen_string_literal: true

module Api
  class BaseError < StandardError
    attr_reader :code, :message

    def initialize(error = {})
      @code = error[:code]
      @message = error[:message]
    end

    def serialize
      [{ code: @code, message: @message }]
    end

    def to_hash
      {
        success: false,
        errors: serialize
      }
    end
  end

  class ExecuteFailed < BaseError
    attr_reader :type, :file_path, :i18n_scope

    def initialize(type, error_detail)
      @type = type
      @file_path = caller(0, 3).last.match(file_path_regex)[0]
      @i18n_scope = get_i18n_scope
      error = I18n.t error_detail, scope: i18n_scope
      @code = error[:code]
      @message = error[:message]
    end

    private

    def get_i18n_scope
      file_path.split(%r{/})[3..].map { |e| e.gsub file_suffix, "" }
    end

    def file_path_regex
      {
        controller: %r{/app/(controllers)/.*.rb},
        form: %r{/app/(forms)/.*.rb},
        service: %r{/app/(services)/.*.rb}
      }[type]
    end

    def file_suffix
      {
        controller: /_controller.rb/,
        form: /_form.rb/,
        service: /_service.rb/
      }[type]
    end
  end

  module Error
    # TODO: define custom error class (extends the BaseError) here.
    class ServiceExecuteFailed < ExecuteFailed
      def initialize(error_detail)
        super :service, error_detail
      end
    end

    class FormExecuteFailed < ExecuteFailed
      def initialize(error_detail)
        super :form, error_detail
      end
    end

    class ControllerRuntimeError < ExecuteFailed
      def initialize(error_detail)
        super :controller, error_detail
      end
    end

    class RecordNotFound < BaseError
      attr_reader :error

      def initialize(error)
        @error = error
      end

      def to_hash
        RecordNotFoundSerializer.new(error).serialize
      end
    end

    class ActionNotAllowed < BaseError
      attr_reader :error

      def initialize(error)
        @error = error
      end

      def to_hash
        ActionNotAllowedSerializer.new(error).serialize
      end
    end

    class UnauthorizedRequest < BaseError
      attr_reader :error

      def initialize(error)
        @error = error
      end

      def to_hash
        UnauthorizedRequestSerializer.new(error).serialize
      end
    end
  end
end
