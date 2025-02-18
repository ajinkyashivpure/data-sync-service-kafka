echo "Waiting for Kafka Connect to be ready..."
while ! curl -s -H "Accept:application/json" localhost:8083/ > /dev/null; do
    sleep 1
done

echo "Deploying PostgreSQL source connector..."
curl -X POST \
  -H "Content-Type: application/json" \
  --data @config/postgresql-source.json \
  http://localhost:8083/connectors

echo "Deploying MongoDB sink connector..."
curl -X POST \
  -H "Content-Type: application/json" \
  --data @config/mongodb-sink.json \
  http://localhost:8083/connectors