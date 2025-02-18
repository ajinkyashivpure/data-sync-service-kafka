Steps to implement this project :
---> run the docker containers :

        docker compose build --no-cache
        docker compose up -d

--->now , we deploy the connectors:

either run the scripts or use the curl commands :

*for curl commands , you have two approaches :

1. referencing through the config files :
    Deploy PostgreSQL source connector
   curl -X POST http://localhost:8083/connectors \
   -H "Content-Type: application/json" \
   -d @config/postgresql-source.json

     Deploy MongoDB sink connector
    curl -X POST http://localhost:8083/connectors \
    -H "Content-Type: application/json" \
    -d @config/mongodb-sink.json

2. put json content in curl command itself :
    for postgres :
curl -X POST http://localhost:8083/connectors \
   -H "Content-Type: application/json" \
   -d '{
   "name": "postgres-source",
   "config": {
   "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
   "tasks.max": "1",
   "database.hostname": "postgres",
   "database.port": "5432",
   "database.user": "postgres",
   "database.password": "postgres",
   "database.dbname": "sourcedb",
   "database.server.name": "postgres-server",
   "database.server.wal_level": "logical",
   "table.include.list": "public.users",
   "plugin.name": "pgoutput",
   "topic.prefix": "postgres-server",
   "tombstones.on.delete": "true",
   "transforms": "unwrap",
   "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
   "transforms.unwrap.drop.tombstones": "true"
   }
   }'

    for mongodb :
   curl -X POST http://localhost:8083/connectors \
   -H "Content-Type: application/json" \
   -d '{
   "name": "mongodb-sink",
   "config": {
   "connector.class": "com.mongodb.kafka.connect.MongoSinkConnector",
   "tasks.max": "1",
   "topics": "postgres-server.public.users",
   "connection.uri": "mongodb://root:example@mongodb:27017",
   "database": "targetdb",
   "collection": "users",
   "key.converter": "org.apache.kafka.connect.json.JsonConverter",
   "value.converter": "org.apache.kafka.connect.json.JsonConverter",
   "key.converter.schemas.enable": "true",
   "value.converter.schemas.enable": "true",
   "transforms": "unwrap",
   "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
   "transforms.unwrap.drop.tombstones": "true",
   "delete.on.null.values": "true"
   }
   }'

check the status of connectors : 

curl -s localhost:8083/connectors | jq


---> Now , we run the postgres and mongo db cli:
    first , run the source db postgres:
        docker exec -it <container_id or name> psql -U postgres -d sourcedb
    then , the sink db:
        docker exec -it <container_id or name> mongosh -u root -p example