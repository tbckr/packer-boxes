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

build {
  name = "debian"

  sources = ["source.virtualbox-iso.debian"]

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/vagrant",
      "http_proxy=${var.http_proxy}",
      "https_proxy=${var.https_proxy}",
      "no_proxy=${var.no_proxy}"
    ]
    execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    scripts           = concat(
      [
        "${path.root}/scripts/update.sh",
        "${path.root}/../_common/sshd.sh",
        "${path.root}/scripts/networking.sh",
        "${path.root}/scripts/sudoers.sh",
        "${path.root}/../_common/vagrant.sh",
        "${path.root}/scripts/systemd.sh",
        "${path.root}/../_common/virtualbox.sh",
        "${path.root}/scripts/cleanup.sh",
      ],
      var.mode == "desktop" ? [] : [
        "${path.root}/../_common/rm-x11.sh",
      ],
      [
        "${path.root}/../_common/minimize.sh"
      ]
    )
  }

  post-processors {

    post-processor "vagrant" {
      vagrantfile_template = "${path.root}/vagrantfile-debian.template"
      output               = "${var.build_directory}/${var.box_basename}-${var.keymap}.{{ .Provider }}.box"
    }

    post-processor "vagrant-cloud" {
      access_token = "${var.vagrant_cloud_token}"
      box_tag      = "tbckr/debian-12-server-en"
      version      = "${var.vagrant_cloud_version}"
    }
  }
}
