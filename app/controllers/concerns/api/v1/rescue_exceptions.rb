# frozen_string_literal: true

module Api
  module V1
    module RescueExceptions
      extend ActiveSupport::Concern

      included do
        rescue_from ActionController::ParameterMissing do |_error|
          render_invalid_params_response
        end
        rescue_from(
          ActiveRecord::RecordInvalid,
          ActiveRecord::RecordNotDestroyed,
          with: :render_unprocessable_entity_response
        )
        rescue_from ActiveRecord::RecordNotUnique, with: :render_existing_resource_response
        rescue_from ActiveRecord::RecordNotFound, with: :render_resource_not_found_response
        rescue_from(
          Api::Error::ControllerRuntimeError,
          Api::Error::FormExecuteFailed,
          Api::Error::ServiceExecuteFailed,
          with: :render_execute_failed_response
        )
        rescue_from Api::Error::ActionNotAllowed, with: :render_action_not_allowed_response
        rescue_from(
          Api::Error::UnauthorizedRequest,
          JWT::DecodeError,
          with: :render_unauthorized_request_response
        )

        protected

        def render_invalid_params_response(status: :bad_request)
          error = Api::BaseError.new I18n.t(:invalid, scope: %i[errors params])
          render json: error.to_hash, status:
        end

        def render_unprocessable_entity_response(exception, status: :bad_request)
          render json: ActiveRecordValidation::Error.new(exception.record).to_hash, status:
        end

        def render_existing_resource_response(_exception, status: :bad_request)
          error = Api::BaseError.new I18n.t(:not_unique, scope: %i[errors active_record])
          render json: error.to_hash, status:
        end

        def render_execute_failed_response(exception, status: :bad_request)
          render json: exception.to_hash, status:
        end

        def render_resource_not_found_response(exception, status: :not_found)
          render json: Api::Error::RecordNotFound.new(exception).to_hash, status:
        end

        def render_action_not_allowed_response(exception, status: :forbidden)
          render json: Api::Error::ActionNotAllowed.new(exception).to_hash, status:
        end

        def render_unauthorized_request_response(exception, status: :unauthorized)
          exception = exception.try(:error) || exception
          render json: Api::Error::UnauthorizedRequest.new(exception).to_hash, status:
        end
      end
    end
  end
end
