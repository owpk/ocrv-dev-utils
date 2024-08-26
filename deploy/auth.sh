PROJ="auth"

ENV="$HOME/ocrv/dev-utils/env/$PROJ.env"

export $(grep -v '^#' $ENV | xargs)

DB_NAME=$CZT_AUTH_DB_NAME
DB_PORT=$CZT_AUTH_DB_PORT
DB_USER=$CZT_AUTH_DB_USERNAME
DB_PASS=$CZT_AUTH_DB_PASS

echo $DB_NAME
echo $DB_PORT
echo $DB_PASS
echo $DB_USER

. ./deploy-db.sh

if [[ -z "$1" ]]; then
  WATCH_LOG="Y"
else
  WATCH_LOG=$1
fi

. ./run.sh --spring-profile "dev" \
        --service-dir "$HOME/ocrv/ext/auth" \
        --env-file $ENV \
        --debug_port "5000" \
	    --watch-log "$WATCH_LOG" \
        --build

