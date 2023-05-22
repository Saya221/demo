KAFKA = Kafka.new ENV["KAFKA_BROKERS"], client_id: ENV["KAFKA_CLIENT_ID"], resolve_seed_brokers: true

class KafkaTopics
  ASYNC_DATA = "async_data".freeze
end
