// Copyright (c) 2023 Tim <tbckr>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// SPDX-License-Identifier: MIT

# Build definition: debian.virtualbox-iso.debian
# Variables for a debian server installation with us keyboard
mirror           = "http://cdimage.debian.org/cdimage/release"
mirror_directory = "11.5.0/amd64/iso-cd"
iso_name         = "debian-11.5.0-amd64-netinst.iso"
iso_checksum     = "e307d0e583b4a8f7e5b436f8413d4707dd4242b70aea61eb08591dc0378522f3"

locale = "en_US.UTF-8"
keymap = "de"
mode   = "server"

vm_name      = "debian-server"
box_basename = "debian-server-11.5"

headless = false