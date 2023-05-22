# frozen_string_literal: true

class AsyncDataJob < ApplicationJob
  sidekiq_options queue: SidekiqQueue::ASYNC_DATA, retry: Settings.sidekiq.async_data.retry

  def perform(args = {})
    super
    @action = args[:action]
    @attributes = args[:attributes]
    execute
  end

  private

  attr_reader :action, :attributes

  def processing
    logger.info "--Start execute #{action} on user #{attributes[:id]}--"
    public_messages
    logger.info "--Finish--"
  rescue StandardError => e
    logger.info "Errors: #{e.message}"
  end

  def public_messages
    producer = KAFKA.async_producer
    producer.produce(JSON.dump(args), topic: KafkaTopics::ASYNC_DATA)
    producer.deliver_messages
  end
end
