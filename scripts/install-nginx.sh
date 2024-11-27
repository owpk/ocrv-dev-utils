#!/bin/bash

sudo dnf install nginx
sudo systemctl enable nginx
sudo bash -c 'echo "127.0.0.1 resource.local" >> /etc/hosts'

cd ../deploy/nginx

sudo mkdir /etc/nginx/certs
sudo cp irk-31435-119.crt /etc/nginx/certs
sudo cp irk-31435-119.key /etc/nginx/certs

sudo ln -s $(pwd)/conf/conf.d/czt.conf /etc/nginx/conf.d/
sudo ln -s $(pwd)/conf/conf.d/czt_ssl.conf /etc/nginx/conf.d/

sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
sudo ln -s $(pwd)/conf/nginx.conf /etc/nginx/

