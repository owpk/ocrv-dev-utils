PROJ="pn"

ENV="$(pwd)/env/$PROJ.env"

export $(grep -v '^#' $ENV | xargs)

DB_NAME=$CZT_PN_DB_NAME
DB_PORT=$CZT_PN_DB_PORT
DB_USER=$CZT_PN_DB_USERNAME
DB_PASS=$CZT_PN_DB_PASS

. $(pwd)/deploy-db.sh

. $(pwd)/run.sh --spring-profile "dev,metrics" \
        --service-dir "$HOME/ocrv/czt/pn-backend" \
        --env-file $ENV \
        --debug_port "5003" \
	     --watch-log "n" \
        --detach "n" \
        --build "y"

