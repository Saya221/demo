KAFKA = Kafka.new ENV["KAFKA_BROKERS"], client_id: ENV["KAFKA_CLIENT_ID"], resolve_seed_brokers: true
K_PRODUCER = KAFKA.producer
K_CONSUMER = KAFKA.consumer group_id: "multi_tenants"
