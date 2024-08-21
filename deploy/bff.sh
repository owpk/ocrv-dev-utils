PROJ="bff"

PID="$(cat $HOME/ocrv/run/"$RROJ"/"$PROJ".pid 2> /dev/null)"
kill $PID 2> /dev/null

# !! auth env is correct since bff connects to auth db 
ENV="$HOME/gh/ocrv/dev-utils/env/auth.env"

export $(grep -v '^#' $ENV | xargs)

./run.sh --spring-profile "dev" \
        --service-dir "$HOME/gh/ocrv/czt/bff" \
        --env-file $ENV \
        --debug_port "5001" \
        --build