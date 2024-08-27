#!/bin/bash

DOMAIN="irk-31435-119"

sudo openssl req -x509 \
   -nodes -days 365 -newkey rsa:2048 \
   -keyout $DOMAIN.key \
   -out $DOMAIN.crt \
   -config $DOMAIN.conf
