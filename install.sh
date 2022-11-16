#!/usr/bin/sh
echo "clearing previous cache.."
rm -rf docker/certbot/*
docker-compose down
docker rmi dockerized-nginx-expressjs-api
docker container rm dz_certbot

# we can't install all the service at once because we need app running before installing the certificate (certbot)
echo "running nginx & app service.."
docker-compose up -d

# wait until the process done
echo "waiting for compose finished.."
sleep 30

# run certbot
echo "installing certbot SSL certificate.."
docker-compose -f certbot.docker-compose.yml up -d
sleep 20
echo "certbot logs:"
docker logs dz_certbot

echo "configuring config file.."
mv docker/nginx/nginx.conf docker/nginx/nginx.init.conf
mv docker/nginx/nginx.ssl.conf docker/nginx/nginx.conf
echo "restarting nginx.."
docker-compose restart
mv docker/nginx/nginx.conf docker/nginx/nginx.ssl.conf
mv docker/nginx/nginx.init.conf docker/nginx/nginx.conf

echo "nginx conf:"
docker exec -it dz_nginx cat /etc/nginx/nginx.conf