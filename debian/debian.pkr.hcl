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

  post-processor "vagrant" {
    vagrantfile_template = "${path.root}/vagrantfile-debian.template"
    output               = "${var.build_directory}/${var.box_basename}-${var.keymap}.{{ .Provider }}.box"
  }
}
