PROJ="pn"
PID="$(cat "$HOME/ocrv/run/$PROJ/$PROJ.pid" 2> /dev/null)"
kill $PID 2> /dev/null

ENV="$HOME/gh/ocrv/dev-utils/env/$PROJ.env"

export $(grep -v '^#' $ENV | xargs)

DB_NAME=$CZT_PN_DB_NAME
DB_PORT=$CZT_PN_DB_PORT
DB_USER=$CZT_PN_DB_USERNAME
DB_PASS=$CZT_PN_DB_PASS

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

./run.sh --spring-profile "dev" \
        --service-dir "$HOME/gh/ocrv/czt/pn-backend" \
        --env-file $ENV \
        --debug_port "5003" \
	--watch-log "$WATCH_LOG" \
        --build

