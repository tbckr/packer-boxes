#!/bin/bash -eux
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


pubkey_url="https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub"
mkdir -p $HOME_DIR/.ssh
if command -v wget >/dev/null 2>&1; then
  wget --no-check-certificate "$pubkey_url" -O $HOME_DIR/.ssh/authorized_keys
elif command -v curl >/dev/null 2>&1; then
  curl --insecure --location "$pubkey_url" >$HOME_DIR/.ssh/authorized_keys
else
  echo "Cannot download vagrant public key"
  exit 1
fi
chown -R vagrant $HOME_DIR/.ssh
chmod -R go-rwsx $HOME_DIR/.ssh
