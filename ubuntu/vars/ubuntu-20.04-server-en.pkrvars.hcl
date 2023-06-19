# Packer definition: ubuntu.pkr.hcl
# Variables for a ubuntu server installation with english local and de keyboard
mirror           = "https://releases.ubuntu.com"
mirror_directory = "focal"
iso_name         = "ubuntu-20.04.6-live-server-amd64.iso"
iso_checksum     = "sha256:b8f31413336b9393ad5d8ef0282717b2ab19f007df2e9ed5196c13d8f9153c8b"

ubuntu_version = "20.04"
mode           = "server"
locale         = "en_US.UTF-8"
keymap         = "de"

vm_name      = "ubuntu-server"
box_basename = "ubuntu-server-20.04"

headless = false