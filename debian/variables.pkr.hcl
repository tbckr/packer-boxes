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

#############################
### Vagrant Cloud Options ###
#############################

variable "vagrant_cloud_token" {
  type      = string
  default   = "${env("VAGRANT_CLOUD_TOKEN")}"
  sensitive = true
}

variable "vagrant_cloud_version" {
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
