######################
### Virtualization ###
######################

variable "cpus" {
  type    = string
  default = "2"
}

variable "memory" {
  type    = string
  default = "4096"
}

variable "disk_size" {
  type    = string
  default = "65536"
}

variable "guest_additions_url" {
  type    = string
  default = ""
}

variable "headless" {
  type    = bool
  default = true
}

#############
### Image ###
#############

variable "iso_checksum" {
  type = string
}

variable "iso_name" {
  type = string
}

variable "mirror" {
  type = string
}

variable "mirror_directory" {
  type = string
}

############################
### Packer Build Options ###
############################

variable "box_basename" {
  type = string
}

variable "build_directory" {
  type    = string
  default = "../builds"
}

variable "vm_name" {
  type = string
}

##################
### Networking ###
##################

variable "http_proxy" {
  type    = string
  default = "${env("http_proxy")}"
}

variable "https_proxy" {
  type    = string
  default = "${env("https_proxy")}"
}

variable "no_proxy" {
  type    = string
  default = "${env("no_proxy")}"
}

variable "net_domain" {
  type    = string
  default = "home.lab"
}

######################
### Ubuntu Options ###
######################

variable "ubuntu_version" {
  type        = string
  description = "The ubuntu version - e.g. 20.04. Options are: 20.04, 22.04."

  validation {
    condition     = contains(["20.04", "22.04"], var.ubuntu_version)
    error_message = "The version must be one of: 20.04, 22.04."
  }
}

variable "mode" {
  type        = string
  description = "The mode. Options are: server, xubuntu-desktop"

  validation {
    condition     = contains(["server", "xubuntu-desktop"], var.mode)
    error_message = "The version must be one of: server, xubuntu-desktop."
  }
}

variable "hostname" {
  type    = string
  default = "ubuntu"
}

variable "locale" {
  type = string
}

variable "keymap" {
  type = string
}

variable "partition_method" {
  type        = string
  default     = "lvm"
  description = "Options are: direct (use the usual partition types for your architecture), lvm (use LVM to partition the disk)"

  validation {
    condition     = contains(["direct", "lvm"], var.partition_method)
    error_message = "The partition_method must be one of regular, lvm or crypto."
  }
}
