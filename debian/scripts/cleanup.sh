#!/bin/sh -eux
# Copyright (c) 2023 Tim <tbckr>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# SPDX-License-Identifier: MIT


echo "remove linux-headers"
dpkg --list |
  awk '{ print $2 }' |
  grep 'linux-headers' |
  xargs apt-get -y purge

echo "remove specific Linux kernels, such as linux-image-4.9.0-13-amd64 but keeps the current kernel and does not touch the virtual packages"
dpkg --list |
  awk '{ print $2 }' |
  grep 'linux-image-[234].*' |
  grep -v $(uname -r) |
  xargs apt-get -y purge

echo "remove linux-source package"
dpkg --list |
  awk '{ print $2 }' |
  grep linux-source |
  xargs apt-get -y purge

echo "remove all development packages"
dpkg --list |
  awk '{ print $2 }' |
  grep -- '-dev\(:[a-z0-9]\+\)\?$' |
  xargs apt-get -y purge

echo "remove obsolete networking packages"
apt-get -y purge ppp pppconfig pppoeconf

echo "remove popularity-contest package"
apt-get -y purge popularity-contest

echo "remove installation-report package"
apt-get -y purge installation-report

echo "autoremoving packages and cleaning apt data"
apt-get -y autoremove
apt-get -y clean

echo "remove /var/cache"
find /var/cache -type f -exec rm -rf {} \;

echo "truncate any logs that have built up during the install"
find /var/log -type f -exec truncate --size=0 {} \;

echo "blank netplan machine-id (DUID) so machines get unique ID generated on boot"
truncate -s 0 /etc/machine-id

echo "remove the contents of /tmp and /var/tmp"
rm -rf /tmp/* /var/tmp/*

echo "force a new random seed to be generated"
rm -f /var/lib/systemd/random-seed

echo "clear the history so our install isn't there"
rm -f /root/.wget-hsts
export HISTSIZE=0
