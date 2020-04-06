#!/usr/bin/env bash
set -e

# Configure host to use timezone
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html
echo "### Setting timezone to $TIMEZONE ###"
sudo tee /etc/sysconfig/clock << EOF > /dev/null
ZONE="$TIMEZONE"
UTC=true
EOF

sudo ln -sf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime

# Use AWS NTP Sync service
echo "server 169.254.169.123 prefer iburst" | sudo tee -a /etc/ntp.conf

# Enable NTP
sudo yum install -y ntp
sudo systemctl ntpd start
