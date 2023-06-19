# Packer Boxes

This repository contains Packer templates for building Vagrant boxes. Templates are available for the following
operating systems:

* Debian
* Ubuntu

Only the virtualbox-iso builder is supported.

## Usage

To build a box, you will need packer and virtualbox installed. Go into the directory of the box you want to build and
run:

```
$ # Ubuntu 20.04 Server example
$ packer build -var-file vars/ubuntu-20.04-server-en.pkrvars.hcl .
```
