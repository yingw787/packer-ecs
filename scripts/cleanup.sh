#!/usr/bin/env bash

echo "### Performing final clean-up tasks ###"
sudo stop ecs
sudo docker system prune -f -a
sudo service docker stop
sudo systemctl docker stop
sudo rm -rf /var/log/docker /var/log/ecs/*
