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
### Debian Options ###
######################

variable "mode" {
  type        = string
  description = "Options are: server, desktop"

  validation {
    condition     = contains(["server", "desktop"], var.mode)
    error_message = "The mode must be one of: server, desktop."
  }
}

variable "locale" {
  type = string
}

variable "keymap" {
  type = string
}

variable "timezone" {
  type    = string
  default = "UTC"
}

variable "partition_method" {
  type        = string
  default     = "lvm"
  description = "Options are: regular (use the usual partition types for your architecture), lvm (use LVM to partition the disk), crypto (use LVM within an encrypted partition)"

  validation {
    condition     = contains(["regular", "lvm", "crypto"], var.partition_method)
    error_message = "The partition_method must be one of regular, lvm or crypto."
  }
}

variable "partition_recipe" {
  type        = string
  default     = "atomic"
  description = "Options are: atomic (all files in one partition), home (separate /home partition), multi (separate /home, /var, and /tmp partitions)"

  validation {
    condition     = contains(["atomic", "home", "multi"], var.partition_recipe)
    error_message = "The partition_recipe must be one of atomic, home or multi."
  }
}

variable "install_modes" {
  type    = list(string)
  default = ["standard", "ssh-server"]
}
