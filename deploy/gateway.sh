PROJ="bff"

ENV="$(pwd)/env/gateway.env"

export $(grep -rhv '^#' $ENV | xargs)

if [[ -z "$1" ]]; then
  WATCH_LOG="Y"
else
  WATCH_LOG=$1
fi

DB_NAME=$CZT_GW_DB_NAME
DB_PORT=$CZT_GW_DB_PORT
DB_USER=$CZT_GW_DB_USERNAME
DB_PASS=$CZT_GW_DB_PASS

. ./deploy-db.sh

. ./run.sh --spring-profile "dev,metrics,mock-sap" \
        --service-dir "$HOME/ocrv/czt/gateway" \
        --env-file $ENV \
        --debug_port "5005" \
        --watch-log "n" \
        --detach "n" \
        --build "y"
