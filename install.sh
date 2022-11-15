#!/usr/bin/sh
echo "clearing previous cache.."
rm -rf docker/certbot/etc/*
rm -rf docker/certbot/var/*

# we can't install all the service at once because we need app running before installing the certificate (certbot)
echo "running nginx & app service.."
mv docker/nginx/configurations/default.conf.init docker/nginx/configurations/default.conf
docker-compose up -d
mv docker/nginx/configurations/default.conf docker/nginx/configurations/default.conf.init

# wait until the process done
echo "waiting for compose finished.."
sleep 30

# run certbot
echo "installing certbot SSL certificate.."
docker-compose -f certbot.docker-compose.yml up -d
sleep 5
echo "running certbot logs:"
docker logs certbot

echo "configuring config file.."
mv docker/nginx/configurations/default.conf.ssl docker/nginx/configurations/default.conf
echo "restarting nginx.."
docker-compose restart
mv docker/nginx/configurations/default.conf docker/nginx/configurations/default.conf.ssl
