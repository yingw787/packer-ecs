#!/usr/bin/env bash
set -e

# Configure ECS Agent
echo "ECS_CLUSTER=${ECS_CLUSTER}" > /etc/ecs/ecs.config

# Set HTTP Proxy URL if provided
if [ -n $PROXY_URL ]
then
    echo export HTTPS_PROXY=$PROXY_URL >> /etc/sysconfig/docker
    echo HTTPS_PROXY=$PROXY_URL >> /etc/ecs/ecs.config
    # 169.254.169.254: special local address to communicate with EC2 metadata
    # service to obtain instance metadata
    #
    # 169.254.170.2: special local address to obtain ECS task credentials
    echo NO_PROXY=169.254.169.254,169.254.170.2,/var/run/docker.sock >> /etc/ecs/ecs.config
    echo HTTP_PROXY=$PROXY_URL >> /etc/awslogs/proxy.conf
    echo HTTPS_PROXY=$PROXY_URL >> /etc/awslogs/proxy.conf
    echo NO_PROXY=169.254.169.254 >> /etc/awslogs/proxy.conf
fi
