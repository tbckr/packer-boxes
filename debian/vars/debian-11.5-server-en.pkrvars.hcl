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