PROJ="fs"

ENV=(
   "$(pwd)/env/fs.env"
   "$(pwd)/env/pn.env"
   "$(pwd)/env/auth.env"
   "$(pwd)/env/hosts.env" 
   "$(pwd)/env/oauth2.env"
)

ENV="${ENV[@]}"

export $(grep -rhv '^#' $ENV | xargs)

DB_NAME=$CZT_FS_DB_NAME
DB_PORT=$CZT_FS_DB_PORT
DB_USER=$CZT_FS_DB_USERNAME
DB_PASS=$CZT_FS_DB_PASS

. $(pwd)/deploy-db.sh

#. $(pwd)/run.sh --spring-profile "dev,metrics" \
#        --service-dir "$HOME/ocrv/czt/fs-backend" \
#        --env-file "$ENV" \
#        --debug_port "5004" \
#	     --watch-log "n" \
#        --detach "n" \
#        --build "y"

. $(pwd)/run.sh --spring-profile "dev,metrics" \
        --target-jar "/opt/czt/fs-backend-0.0.2-SNAPSHOT.jar" \
        --env-file "$ENV" \
        --debug_port "5004" \
	     --watch-log "n" \
        --detach "n" 
