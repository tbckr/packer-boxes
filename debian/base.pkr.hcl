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
