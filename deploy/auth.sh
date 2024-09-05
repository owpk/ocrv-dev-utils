PROJ="auth"

ENV="$(pwd)/env/$PROJ.env"
echo $ENV

export $(grep -v '^#' $ENV | xargs)

DB_NAME=$CZT_AUTH_DB_NAME
DB_PORT=$CZT_AUTH_DB_PORT
DB_USER=$CZT_AUTH_DB_USERNAME
DB_PASS=$CZT_AUTH_DB_PASS

. $(pwd)/deploy-db.sh

. $(pwd)/run.sh --spring-profile "dev,mock-users,metrics" \
        --service-dir "$HOME/ocrv/czt/auth" \
        --env-file $ENV \
        --debug_port "5000" \
	     --watch-log "n" \
        --detach "n" \
        --build "y"

