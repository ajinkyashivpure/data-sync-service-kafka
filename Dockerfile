FROM quay.io/debezium/connect:2.5

USER root

# Install necessary tools
RUN microdnf install -y curl unzip

# Download and install MongoDB Kafka Connector
RUN curl -O https://repo1.maven.org/maven2/org/mongodb/kafka/mongo-kafka-connect/1.8.0/mongo-kafka-connect-1.8.0-all.jar && \
    mkdir -p /kafka/connect/mongodb-connector && \
    mv mongo-kafka-connect-1.8.0-all.jar /kafka/connect/mongodb-connector/

USER kafka

ENV CONNECT_PLUGIN_PATH="/kafka/connect"