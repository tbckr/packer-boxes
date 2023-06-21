# Packer Boxes

This repository contains Packer templates for building Vagrant boxes. These templates allow you to create virtual
machine images that can be used with Vagrant for local development and testing. Currently, the templates support the
following operating systems:

* Debian
* Ubuntu

Each operating system has its own folder within the repository. You can navigate to the respective folder to find the
specific configuration for that OS. The configuration details for each OS can be customized using variables files. These
variables files allow you to specify the specific Debian version and whether a window manager like XFCE should be
installed, among other configuration options.

Please note that only the `virtualbox-iso` builder is supported in this repository.

To build a Vagrant box, make sure you have Packer and VirtualBox installed on your system. Then, navigate to the
directory of the specific box you want to build and execute the following command:

```
$ # Example: Building Ubuntu 20.04 Server box
$ packer build -var-file vars/ubuntu-20.04-server-en.pkrvars.hcl .
```

This command will initiate the Packer build process using the specified template and variables file. Packer will start
by downloading the necessary ISO file, create a new virtual machine, install the operating system, and provision it
according to the defined configuration. The resulting Vagrant box will be outputted in the current directory.

For each box, there may be specific variables files available in the `vars` directory. These files contain configurable
settings that can be used to customize the build process. Make sure to specify the appropriate variables file using the
`-var-file` option when running the `packer build` command.

After building the Vagrant box, you can add it to your local Vagrant environment using the `vagrant box add` command.
Once added, you can use the box as a base for creating and provisioning Vagrant virtual machines for your development or
testing needs.

Happy building and vagrant-ing!
