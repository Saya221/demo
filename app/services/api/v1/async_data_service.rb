# frozen_string_literal: true

class Api::V1::AsyncDataService < Api::V1::BaseService
  def perform
    consumer = KAFKA.consumer(group_id: ENV.fetch("KAFKA_GROUP_ID", "consumer"))
    consumer.subscribe(KafkaTopics::ASYNC_DATA)

    trap("TERM") { consumer.stop }

    consumer.each_message do |message|
      AsyncDataJob.perform_async(JSON.parse(message.value))
    end
  end
end
