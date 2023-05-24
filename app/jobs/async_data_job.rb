# frozen_string_literal: true

class AsyncDataJob < ApplicationJob
  sidekiq_options queue: SidekiqQueue::CONSUMER, retry: Settings.sidekiq.consumer.retry

  # {
  #   "id": "8aa86141-deda-4cb8-855d-5ebb6b73562d",
  #   "action": "update!",
  #   "attributes": {
  #     "name":"1_19"
  #   }
  # }

  def perform(args = {})
    super
    @id = args[:id]
    @action = args[:action].to_sym
    @attributes = args[:attributes]
    execute
  end

  private

  attr_reader :id, :action, :attributes

  def processing
    logger.info "--Start execute #{action} on user id #{id}--"
    convert_nil_type
    current_user.with_lock { async_data }
    logger.info "--Finish--"
  rescue StandardError => e
    logger.info "Errors: #{e.message}"
  end

  def convert_nil_type
    attributes&.transform_values! { |value| value == "nil" ? nil : value }
  end

  def current_user
    @current_user ||= User.find_or_initialize_by id: id
  end

  def async_data
    action == Action::UPDATE ? current_user.update!(attributes) : current_user.destroy!
  end
end
