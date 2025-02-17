#!/bin/sh

PROJ="bi"

LOCAL=$(./switchrun.sh $@)
echo "LOCAL var: $LOCAL"

ENV=(
   "$(pwd)/env/bi.env"
   "$(pwd)/env/kafka.env"
   "$(pwd)/env/hosts.env"
   "$(pwd)/env/oauth2.env"
)

ENV="${ENV[@]}"

export $(grep -rhv '^#' $ENV | xargs)

DB_NAME=$CZT_BI_DB_NAME
DB_PORT=$CZT_BI_DB_PORT
DB_USER=$CZT_BI_DB_USERNAME
DB_PASS=$CZT_BI_DB_PASS

. $(pwd)/deploy-db.sh

function localJar() {
   echo "Running local jar"
   . $(pwd)/run.sh --spring-profile "dev" \
           --service-dir "$HOME/ocrv/czt/bi" \
           --env-file "$ENV" \
           --debug_port "5100" \
   	     --watch-log "${WATCH_LOG:-n}" \
           --detach "${DETACH-n}" \
           --build "${BUILD-y}"
}

function defaultCi() {
   echo "Running from ci/cd"
   . $(pwd)/run.sh --spring-profile "dev" \
           --target-jar "/opt/czt/bi-0.0.1-SNAPSHOT.jar" \
           --env-file "$ENV" \
           --debug_port "5100" \
   	     --watch-log "n" \
           --detach "y" 
}

if [ "$LOCAL" == "1" ]; then
   localJar
else 
   defaultCi
fi
