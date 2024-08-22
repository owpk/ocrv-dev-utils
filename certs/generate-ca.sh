######################
# Become a Certificate Authority
######################

# Generate private key
openssl genrsa -des3 -out myCA.key 2048

# Generate root certificate
openssl req -x509 -new -nodes -key myCA.key -sha256 -days 825 -out myCA.pem

######################
# Create CA-signed certs
######################
NAME=irk-31435-124
IP=172.22.202.137

# Generate a private key
openssl genrsa -out $NAME.key 2048

# Create a certificate-signing request
openssl req -new -key $NAME.key -out $NAME.csr

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
IP.1 = $IP # Optionally, add an IP address (if the connection which you have planned requires it)
EOF

# Create the signed certificate
openssl x509 -req -in $NAME.csr -CA myCA.pem -CAkey myCA.key -CAcreateserial \
    -out $NAME.crt -days 825 -sha256 -extfile $NAME.ext
