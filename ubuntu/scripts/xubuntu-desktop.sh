#!/bin/sh -eux
export DEBIAN_FRONTEND=noninteractive

echo "update the package list"
apt-get -y update

echo "install xubuntu-desktop"
apt-get -y install xubuntu-desktop

reboot