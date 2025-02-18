echo "Checking connector status..."
curl -s -H "Accept:application/json" localhost:8083/connectors | jq '.'
echo "\nChecking PostgreSQL source connector status..."
curl -s -H "Accept:application/json" localhost:8083/connectors/postgres-source/status | jq '.'
echo "\nChecking MongoDB sink connector status..."
curl -s -H "Accept:application/json" localhost:8083/connectors/mongodb-sink/status | jq '.'