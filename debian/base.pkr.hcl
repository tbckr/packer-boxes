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

locals {
  # Packer specific stuff
  preseed_path = "preseed.cfg"
  boot_command = [
    "<esc><wait>install ",
    "<wait>preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${local.preseed_path} ",
    "<wait>debian-installer=${var.locale} ",
    "<wait>auto ",
    "<wait>locale=${var.locale} ",
    "<wait>kbd-chooser/method=${var.keymap} ",
    "<wait>keyboard-configuration/xkb-keymap=${var.keymap} ",
    "<wait>netcfg/get_hostname={{ .Name }} ",
    "<wait>netcfg/get_domain=${var.net_domain} ",
    "<wait>fb=false ",
    "<wait>debconf/frontend=noninteractive ",
    "<wait>console-setup/ask_detect=false ",
    "<wait>console-keymaps-at/keymap=${var.keymap} ",
    "<wait>grub-installer/bootdev=default ",
    "<wait><enter>",
    "<wait>"
  ]
}

source "virtualbox-iso" "debian" {
  http_content = {
    "/${local.preseed_path}" = templatefile("${path.root}/http/${local.preseed_path}", {
      keymap           = var.keymap
      timezone         = var.timezone
      partition_method = var.partition_method
      partition_recipe = var.partition_recipe
      install_modes    = var.install_modes
    })
  }
  boot_command            = local.boot_command
  boot_wait               = "5s"
  cpus                    = var.cpus
  disk_size               = var.disk_size
  memory                  = var.memory
  hard_drive_interface    = "sata"
  iso_url                 = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  iso_checksum            = var.iso_checksum
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_additions_url     = var.guest_additions_url
  virtualbox_version_file = ".vbox_version"
  guest_os_type           = "Debian_64"
  headless                = var.headless
  shutdown_command        = "echo 'vagrant' | sudo -S /sbin/shutdown -hP now"

  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--vram", "16"],
    ["modifyvm", "{{.Name}}", "--graphicscontroller", "vmsvga"],
    ["modifyvm", "{{.Name}}", "--vrde", "off"],
    ["setextradata", "{{.Name}}", "GUI/SuppressMessages", "all"],
  ]

  ssh_username = "vagrant"
  ssh_password = "vagrant"
  ssh_port     = 22
  ssh_timeout  = "10000s"

  vm_name          = var.vm_name
  output_directory = "${var.build_directory}/packer-${var.vm_name}-${var.keymap}-virtualbox"
}
