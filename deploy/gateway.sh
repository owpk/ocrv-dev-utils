PROJ="bff"

LOCAL=$(./switchrun.sh)

ENV=("$(pwd)/env/gateway.env" "$(pwd)/env/sap_integration.env" "$(pwd)/env/hosts.env" "$(pwd)/env/oauth2.env")
ENV="${ENV[@]}"

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

JVM_OPTS_ADD="-Dnative.lib.filename=libsapjco3 -Dsap.jcolib.target.path=lib -Denv.classifier=linuxx86_64 -Denv.type=so"


function defaultCi() {
   echo "Running from ci/cd"
   . ./run.sh --spring-profile "dev,metrics,mock-sap" \
           --target-jar "/opt/czt/gateway-0.0.1-SNAPSHOT.jar" \
           --env-file "$ENV" \
           --debug_port "5010" \
           --watch-log "n" \
           --detach "n"
}

function localJar() {
   echo "Running local jar"
  . ./run.sh --spring-profile "dev,metrics" \
          --service-dir "$HOME/ocrv/czt/gateway" \
          --env-file "$ENV" \
          --debug_port "5010" \
          --watch-log "n" \
          --detach "n" \
          --build "y"
}

if [ "$LOCAL" == "1" ]; then
   localJar
else 
   defaultCi
fi
