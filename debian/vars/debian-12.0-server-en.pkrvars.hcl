# Build definition: debian.virtualbox-iso.debian
# Variables for a debian server installation with us keyboard
mirror           = "http://cdimage.debian.org/cdimage/release"
mirror_directory = "12.0.0/amd64/iso-cd"
iso_name         = "debian-12.0.0-amd64-netinst.iso"
iso_checksum     = "3b0e9718e3653435f20d8c2124de6d363a51a1fd7f911b9ca0c6db6b3d30d53e"

locale = "en_US.UTF-8"
keymap = "de"
mode   = "server"

vm_name      = "debian-server"
box_basename = "debian-server-12.0"

headless = false