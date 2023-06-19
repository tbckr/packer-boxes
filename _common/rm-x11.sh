#!/bin/sh -eux

echo "remove X11 libraries"
apt-get -y purge libx11-data xauth libxmuu1 libxcb1 libx11-6 libxext6
