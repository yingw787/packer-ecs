#!/usr/bin/env bash
#
# Set error flag on for all Packer shell scripts, so script exits if any command
# fails within the script.
set -e

echo "### Configuring Docker Volume Storage ###"
sudo mkdir -p /data
sudo mkfs.ext4 -L docker /dev/xvdcy
echo -e "LABEL=docker\t/data\t\text4\tdefaults,noatime\t0\t0" | sudo tee -a /etc/fstab
sudo mount -a
