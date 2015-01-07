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

Currently no Linux template contains any provisioning (see https://github.com/xenserver/packer-templates/issues/2). In the future we should look into installing Tools in a provision script -- Packer already attaches the Tools ISO to the VM, so it's just a case of loop-mounting and installing.

What works:
- `centos-6.6-amd64.json`
- `fedora-20-amd64.json`
- `freebsd-10.1-amd64.json`
- `ubuntu-12.04-amd64.json`
- `ubuntu-14.10-amd64.json`
- `windows_7.json`

What doesn't:
- `debian-7.7-amd64.json` (ssh daemon not started on boot?)

What hasn't been tested:
- `windows_2008_r2_core.json`

## Caveats

Currently in order to use the Windows template, you must edit `scripts/windows/http-get.ps1` manually in order to specify the address of the machine that Packer is running on. This is unfortunately to work around not being able to install Tools early\* to get the VM's IP address -- so we need to "ping" Packer so that it is aware of this.

\* This is because the Tools drivers currently causes a BSOD when it sees a floppy drive. Packer needs to remove the floppy before it can install tools, but it needs to shut down the VM before it can remove the floppy. In order to shutdown, it must know when the installation is complete, and this is detected when SSH becomes available. To connect to SSH, we need the VM's IP address.
