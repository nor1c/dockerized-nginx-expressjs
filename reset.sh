#!/usr/bin/sh
docker-compose down
docker rmi dockerized-nginx-expressjs-api

exec docker-compose up -d