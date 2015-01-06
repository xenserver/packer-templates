packer-templates
================

A collection of Packer templates for building guest VMs using the [packer-builder-xenserver](https://github.com/rdobson/packer-builder-xenserver) plugin.

These are based on [opscode/bento](https://github.com/opscode/bento) and [joefitzgerald/packer-windows](https://github.com/joefitzgerald/packer-windows).

To use these configs, run something along the lines of:
```shell
# NOTES:
# 1. if Windows, see caveat below,
# 2. if host is a XenRT devbox, avoid firewalls by using port 80 and running as root; otherwise the sudo is unnecessary (just use HTTP_PORT >= 8000)
# 3. ensure that the version of XenServer trunk is recent enough to contain the floppy/ISO-upload patches

sudo HOST=<host> USERNAME=<username> PASSWORD=<password> HTTP_PORT=80 packer build freebsd-10.1-amd64.json
```

## Caveats

Currently in order to use the Windows template, you must edit `scripts/windows/http-get.ps1` manually in order to specify the address of the machine that Packer is running on. This is unfortunately to work around not being able to install Tools early\* to get the VM's IP address -- so we need to "ping" Packer so that it is aware of this.

\* This is because the Tools drivers currently causes a BSOD when it sees a floppy drive. Packer needs to remove the floppy before it can install tools, but it needs to shut down the VM before it can remove the floppy. In order to shutdown, it must know when the installation is complete, and this is detected when SSH becomes available. To connect to SSH, we need the VM's IP address.
