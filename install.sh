#!/usr/bin/sh
echo "clearing previous cache.."
rm -rf docker/certbot/etc/*
rm -rf docker/certbot/var/*
docker-compose down
docker rmi dockerized-nginx-expressjs-api
docker container rm dz_certbot

# we can't install all the service at once because we need app running before installing the certificate (certbot)
echo "running nginx & app service.."
docker-compose up -d

# # wait until the process done
# echo "waiting for compose finished.."
# sleep 30

# # run certbot
# echo "installing certbot SSL certificate.."
# docker-compose -f certbot.docker-compose.yml up -d
# sleep 30
# echo "certbot logs:"
# docker logs dz_certbot

# echo "configuring config file.."
# mv docker/nginx/configurations/default.conf docker/nginx/configurations/default.init.conf
# mv docker/nginx/configurations/default.ssl.conf docker/nginx/configurations/default.conf
# echo "restarting nginx.."
# docker-compose restart
# mv docker/nginx/configurations/default.conf docker/nginx/configurations/default.ssl.conf
# mv docker/nginx/configurations/default.init.conf docker/nginx/configurations/default.conf