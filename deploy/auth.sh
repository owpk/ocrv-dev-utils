PROJ="auth"

ENV=("$(pwd)/env/auth.env" "$(pwd)/env/hosts.env" "$(pwd)/env/integration.env" "$(pwd)/env/oauth2.env")
ENV="${ENV[@]}"

export $(grep -rhv '^#' $ENV | xargs)

DB_NAME=$CZT_AUTH_DB_NAME
DB_PORT=$CZT_AUTH_DB_PORT
DB_USER=$CZT_AUTH_DB_USERNAME
DB_PASS=$CZT_AUTH_DB_PASS

. $(pwd)/deploy-db.sh

JVM_OPTS_ADD="-Dnative.lib.filename=libsapjco3 -Dsap.jcolib.target.path=lib -Denv.classifier=linuxx86_64 -Denv.type=so"

. $(pwd)/run.sh --spring-profile "dev,mock-users,metrics" \
        --service-dir "$HOME/ocrv/czt/auth" \
        --env-file "$ENV" \
        --debug_port "5000" \
	     --watch-log "n" \
        --detach "n" \
        --build "y"

#. $(pwd)/run.sh --spring-profile "dev,mock-users,metrics" \
#        --target-jar "/opt/czt/auth-0.0.1-SNAPSHOT.jar" \
#        --env-file "$ENV" \
#        --debug_port "5000" \
#	     --watch-log "n" \
#        --detach "n" 
