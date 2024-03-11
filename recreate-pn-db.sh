#!/bin/bash

DB_NAME=pndb
DB_PASS="pn-secret"
DB_USER="pn_service"

DUMP="$1"
echo "Dump file: $DUMP"

CONTAINER_NAME=$DB_NAME
IMAGE=postgres:14

docker container rm -f $CONTAINER_NAME

docker run --name $CONTAINER_NAME -p 5432:5432 -d \
    -e POSTGRES_PASSWORD=$DB_PASS \
    -e POSTGRES_USER=$DB_USER \
    -e POSTGRES_DB=$DB_NAME \
    $IMAGE

sleep 5

./restore_db.sh $DUMP $CONTAINER_NAME $DB_USER $DB_NAME
