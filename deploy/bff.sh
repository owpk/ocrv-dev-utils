PROJ="bff"

# !! auth env is correct since bff connects to auth db 
ENV=("./env/auth.env" "./env/bff.env")

export $(grep -rhv '^#' $ENV | xargs)

if [[ -z "$1" ]]; then
  WATCH_LOG="Y"
else
  WATCH_LOG=$1
fi

. ./run.sh --spring-profile "dev" \
        --service-dir "$HOME/ocrv/czt/bff" \
        --env-file $ENV \
        --debug_port "5001" \
        --watch-log "$WATCH_LOG" \
        --build
