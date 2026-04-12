---
title: VMCTL
section: 1
header: User Commands
date: March 2026
author: Mark Pitman <mark.pitman@gmail.com>
---

# NAME

vmctl - interactive quickemu wrapper for starting and managing local virtual machines

# SYNOPSIS

**vmctl** [`-h`] [`--clear-cache`] [`--clear-iso-cache`]

# DESCRIPTION

**vmctl** is a `gum`-based interactive wrapper around **quickemu** and
**quickget**.

It scans `~/quickemu` for `*.conf` files and presents interactive menus for VM
selection and lifecycle operations. It can also drive **quickget** to create a
new VM configuration from the upstream OS catalog.

When a VM is created, **vmctl** caches the downloaded installer ISO under the
user cache directory and replaces the VM-local copy with a symlink when
possible. Recreating the same OS, release, and edition reuses the cached ISO
and cached template config instead of downloading the installer again.

Features include:

- creating new VMs from the quickget catalog
- reusing cached installer ISOs for repeated VM creation
- starting and stopping VMs
- opening SPICE connections to running VMs
- listing, creating, applying, and deleting snapshots
- displaying VM configuration and disk information
- resizing stopped VM disk images

# OPTIONS

`-h`, `--help`

: Show usage help and exit.

`--clear-cache`

: Remove the cached quickget OS list stored under the user cache directory.

`--clear-iso-cache`

: Remove cached installer ISOs and cached template configs stored under the user cache directory.

# DEPENDENCIES

**vmctl** requires:

- `gum`
- `quickemu`
- `quickget`
- `qemu-img`

The SPICE connect action also requires either:

- `spicy` from `spice-client-gtk`, or
- `remote-viewer` from `virt-viewer`

# FILES

`~/quickemu`

: Default directory scanned for VM configuration files.

`$XDG_CACHE_HOME/vmctl/quickget-list.csv`

: Cached copy of the quickget catalog when `XDG_CACHE_HOME` is set.

`~/.cache/vmctl/quickget-list.csv`

: Cached copy of the quickget catalog when `XDG_CACHE_HOME` is not set.

`$XDG_CACHE_HOME/vmctl/isos/`

: Cached installer ISOs and template configs for quickget-created VMs when `XDG_CACHE_HOME` is set.

`~/.cache/vmctl/isos/`

: Cached installer ISOs and template configs for quickget-created VMs when `XDG_CACHE_HOME` is not set.

# EXAMPLES

```bash
vmctl
vmctl --clear-cache
vmctl --clear-iso-cache
vmctl -h
```

# NOTES

Snapshot apply and delete operations should be performed only while the VM is
stopped.

Disk resize changes the virtual disk image size. The guest OS may still require
partition and filesystem expansion after the VM is booted.

# SEE ALSO

**quickemu**(1), **quickget**(1), **qemu-img**(1)