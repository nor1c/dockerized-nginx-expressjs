#!/usr/bin/sh
echo "clearing previous cache.."
rm -rf docker/certbot/*
docker-compose down
docker rmi dockerized-nginx-expressjs-api
docker container rm dz_certbot
docker network create dz-network

docker-compose up -d

sleep 5

echo "docker-compose ps:"
docker-compose ps

echo "docker logs dz_certbot:"
docker logs dz_certbot

echo "docker exec dz_nginx ls -la /etc/letsencrypt/live:"
docker exec dz_nginx ls -la /etc/letsencrypt/live

echo "docker-compose up --force-recreate --no-deps dz_certbot:"
docker-compose up --force-recreate --no-deps dz_certbot

docker-compose stop dz_nginx
sudo openssl dhparam -out docker/nginx/html/dhparam/dhparam-2048.pem 2048

mv docker/nginx/nginx.conf docker/nginx/nginx.conf.init
mv docker/nginx/nginx.conf.ssl docker/nginx/nginx.conf

docker-compose up -d --force-recreate --no-deps dz_nginx
docker-compose ps

mv docker/nginx/nginx.conf docker/nginx/nginx.conf.ssl
mv docker/nginx/nginx.conf.init docker/nginx/nginx.conf