KAFKA = Kafka.new ENV.fetch("KAFKA_BROKERS", "localhost:9092"),
                  client_id: ENV.fetch("KAFKA_CLIENT_ID", App::NAME),
                  resolve_seed_brokers: true

class KafkaTopics
  ASYNC_DATA = "async_data".freeze
end
