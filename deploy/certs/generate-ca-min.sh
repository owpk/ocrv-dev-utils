NAME=irk-31435-119

# Create a config file for the extensions
>$NAME.ext cat <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $NAME # Be sure to include the domain name here because Common Name is not so commonly honoured by itself
DNS.2 = irk.auth.$NAME # Optionally, add additional domains (I've added a subdomain here)
DNS.3 = irk.resource.$NAME 
DNS.4 = irk.bff.$NAME 
DNS.2 = irk.pn.$NAME 
DNS.2 = irk.fs.$NAME 
EOF

# Create the signed certificate
openssl req -x509 -days 3650 \
              -newkey rsa:4096a \
              -sha256 -nodes -keyout "$NAME.key" \
              -out "$NAME.crt" -subj "/CN=$NAME" 
              #-extfile $NAME.ext

