#!/bin/bash

sudo dnf install nginx

cd ../deploy/nginx/conf
ln -s $(pwd)/conf.d/czt.conf /etc/nginx/conf.d/
ln -s $(pwd)/conf.d/czt_ssl.conf /etc/nginx/conf.d/
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
ln -s $(pwd)/nginx.conf /etc/nginx/
