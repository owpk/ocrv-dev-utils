#!/bin/bash
HOST="$1"
USER="$2"
DB="$3"

docker pull lesovsky/pgcenter:latest
docker run -v ./:/pgcenter -it --rm lesovsky/pgcenter:latest pgcenter record -f /pgcenter/stat.tar -h "$HOST" -p 5455 -U "$USER" -d "$DB"
