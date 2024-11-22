#!/bin/sh

CONTAINER="$DB_NAME"

echo "Deploying database:"
echo "Db name: $DB_NAME"
echo "Db port: $DB_PORT"
echo "Db pass: $DB_PASS"
echo "Db user: $DB_USER"

docker stop $CONTAINER 2> /dev/null
docker container rm $CONTAINER

docker run --name $DB_NAME \
    -p $DB_PORT:5432 \
    -e POSTGRES_PASSWORD=$DB_PASS \
    -e POSTGRES_USER=$DB_USER \
    -e POSTGRES_DB=$DB_NAME \
    -d --rm postgres:14

    

