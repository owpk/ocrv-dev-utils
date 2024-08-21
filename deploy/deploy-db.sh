#!/bin/sh

CONTAINER="$DB_NAME"

#if [ -z $(docker ps -q -f name="$CONTAINER") ]; then
#    docker run --name $DB_NAME \
#        -p $DB_PORT:5432 \
#        -e POSTGRES_PASSWORD=$DB_PASS \
#        -e POSTGRES_USER=$DB_USER \
#        -e POSTGRES_DB=$DB_NAME \
#        -d --rm postgres:14
#fi


docker stop $DB_NAME 2> /dev/null

docker run --name $DB_NAME \
    -p $DB_PORT:5432 \
    -e POSTGRES_PASSWORD=$DB_PASS \
    -e POSTGRES_USER=$DB_USER \
    -e POSTGRES_DB=$DB_NAME \
    -d --rm postgres:14

    

