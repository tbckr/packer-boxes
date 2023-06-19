# Build definition: debian.virtualbox-iso.debian
# Variables for a graphic debian xfce installation with de keyboard
mirror           = "http://cdimage.debian.org/cdimage/release"
mirror_directory = "11.5.0/amd64/iso-cd"
iso_name         = "debian-11.5.0-amd64-netinst.iso"
iso_checksum     = "e307d0e583b4a8f7e5b436f8413d4707dd4242b70aea61eb08591dc0378522f3"

locale = "en_US.UTF-8"
keymap = "de"
mode   = "desktop"

cpus   = "4"
memory = "4096"

partition_method = "lvm"
partition_recipe = "multi"
install_modes    = ["standard", "ssh-server", "xfce-desktop"]

vm_name      = "debian-xfce"
box_basename = "debian-xfce-11.5"

headless = false