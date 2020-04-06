#!/usr/bin/env bash

echo "### Performing final clean-up tasks ###"
sudo stop ecs
sudo docker system prune -f -a
sudo service docker stop
sudo systemctl stop docker
sudo rm -rf /var/log/docker /var/log/ecs/*
