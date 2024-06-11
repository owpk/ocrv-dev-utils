#!/bin/bash

DB_NAME=$1
DB_PASS=$2
DB_USER=$3
DB_PORT=$4
DUMP="$5"

echo "connection info:"
echo "DB_NAME:      $DB_NAME"
echo "DB_PASS:      $DB_PASS" 
echo "DB_USER:      $DB_USER" 
echo "DB_PORT:      $DB_PORT" 
echo "DUMP_FILE:    $DUMP"

CONTAINER_NAME=$DB_NAME
IMAGE=postgres:14

docker container rm -f $CONTAINER_NAME

docker run --name $CONTAINER_NAME -p $DB_PORT:5432 -d \
    -e POSTGRES_PASSWORD=$DB_PASS \
    -e POSTGRES_USER=$DB_USER \
    -e POSTGRES_DB=$DB_NAME \
    $IMAGE

sleep 5

./restore_db.sh $DUMP $CONTAINER_NAME $DB_USER $DB_NAME
