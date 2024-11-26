#!/bin/bash

sudo dnf install nginx
sudo systemctl enable nginx
sudo bash -c 'echo "127.0.0.1 resource.local" >> /etc/hosts'

cd ../deploy/nginx/conf
sudo ln -s $(pwd)/conf.d/czt.conf /etc/nginx/conf.d/
sudo ln -s $(pwd)/conf.d/czt_ssl.conf /etc/nginx/conf.d/

sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
sudo ln -s $(pwd)/nginx.conf /etc/nginx/

