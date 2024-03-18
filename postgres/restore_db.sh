#!/bin/bash

DUMP="$1"
CONTAINER_NAME=$2
DB_USER=$3

echo "Dump file: $DUMP"
cat $DUMP | docker exec -i $CONTAINER_NAME psql -U $DB_USER -d $CONTAINER_NAME
