CONFIG_FILE=/etc/kafka/kafka-config/config.properties

BOOTSTRAP_SERVER=localhost:8003

TOPIC_NAME=testtopic

REPLICATION_FACTOR=1

PARTITIONS=1

create-topic:
	docker exec -it kafka_1 kafka-topics --create \
		--bootstrap-server $(BOOTSTRAP_SERVER) \
		--replication-factor $(REPLICATION_FACTOR) \
		--partitions $(PARTITIONS) \
		--topic $(TOPIC_NAME) \
		--command-config $(CONFIG_FILE)

list-topics:
	docker exec -it kafka_1 kafka-topics --list \
		--bootstrap-server $(BOOTSTRAP_SERVER) \
		--command-config $(CONFIG_FILE)

delete-topic:
	docker exec -it kafka_1 kafka-topics --delete \
		--bootstrap-server $(BOOTSTRAP_SERVER) \
		--topic $(TOPIC_NAME) \
		--command-config $(CONFIG_FILE)

run-minio:
	docker compose -f minio.yml up -d

stop-minio:
	docker compose -f minio.yml stop

stop-kafka:
	docker compose -f kafka.yml stop
run-kafka:
	docker compose -f kafka.yml up -d

stop-otel:
	docker compose -f otel.yml stop
run-otel:
	docker compose -f otel.yml up -d

stop-rabbitmq:
	docker compose -f rabbitmq.yml stop
run-rabbitmq:
	docker compose -f rabbitmq.yml up -d

stop-redis:
	docker compose -f redis.yml stop
run-redis:
	docker compose -f redis.yml up -d

run: run-otel run-rabbitmq run-minio run-redis

stop: stop-kafka stop-otel stop-rabbitmq stop-minio stop-redis