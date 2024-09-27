#!/bin/bash
docker stop glance
docker rm glance

docker run --name glance -d --restart always -p 8002:8080 \
  -v ./glance.yml:/app/glance.yml \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  -v ./assets:/app/assets \
  glanceapp/glance
