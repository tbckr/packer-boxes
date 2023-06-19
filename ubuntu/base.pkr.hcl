locals {
  boot_command = {
    "20.04" = [
      " <wait>",
      " <wait>",
      " <wait>",
      " <wait>",
      " <wait>",
      "<esc><wait>",
      "<f6><wait>",
      "<esc><wait>",
      "<bs><bs><bs><bs><wait>",
      " autoinstall<wait5>",
      " ds=nocloud-net<wait5>",
      ";s=http://<wait5>{{ .HTTPIP }}<wait5>:{{ .HTTPPort }}/<wait5>",
      " ---<wait5>",
      "<enter><wait5>"
    ]
    "22.04" = [
      " <wait>",
      " <wait>",
      " <wait>",
      " <wait>",
      " <wait>",
      "c",
      "<wait>",
      "set gfxpayload=keep",
      "<enter><wait>",
      "linux /casper/vmlinuz quiet<wait>",
      " autoinstall<wait>",
      " ds=nocloud-net<wait>",
      "\\;s=http://<wait>",
      "{{ .HTTPIP }}<wait>",
      ":{{ .HTTPPort }}/<wait>",
      " ---",
      "<enter><wait>",
      "initrd /casper/initrd<wait>",
      "<enter><wait>",
      "boot<enter><wait>"
    ]
  }
  autoinstall_params = {
    locale           = var.locale
    keymap           = var.keymap
    partition_method = var.partition_method
    hostname         = var.hostname
  }
}

source "virtualbox-iso" "ubuntu" {
  http_content = {
    "/meta-data" = templatefile("${path.root}/http/meta-data", local.autoinstall_params)
    "/user-data" = templatefile("${path.root}/http/user-data", local.autoinstall_params)
  }
  boot_command            = local.boot_command[var.ubuntu_version]
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
  guest_os_type           = "Ubuntu_64"
  headless                = var.headless
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"

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
