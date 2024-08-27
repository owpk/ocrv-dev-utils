NAME=irk-31435-119

mkdir ca_out
cd ca_out

# Create the signed certificate
openssl req -x509 -days 3650 \
              -newkey rsa:4096 \
              -sha256 -nodes -keyout "$NAME.key" \
              -out "$NAME.crt" -subj "/CN=$NAME" 
              #-config $NAME.ext

