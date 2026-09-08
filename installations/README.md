# Installation Instructions

This directory contains instructions for installing Finix. Finix currently uses
the standard NixOS installation environment and installation tools.

Check for comments annotated with `WARN`, `TODO`, `NOTE`.

## Installation

### 1. Boot a NixOS ISO

Boot into a NixOS ISO. Any NixOS ISO will work, although there is little reason
to use the graphical ISO unless you want a graphical environment while installing.

A Finix installation ISO does not exist yet, so a NixOS ISO is required for now.

### 2. Partition and mount your disk

Partition your disk and mount the filesystems under `/mnt`, following the standard NixOS installation procedure.

See the [NixOS installation manual](https://nixos.org/manual/nixos/stable/#sec-installation) for details.

### 3. Choose a Finix configuration

Clone this repository or initialize one of the templates provided here.

You can modify the template to suit your needs.

### 4. Generate the hardware configuration

Run the standard NixOS hardware configuration generator as root:

```sh
nixos-generate-config --root /mnt
```

This generates the hardware-specific configuration under `/mnt/etc/nixos/`

Review the generated configuration and modify it according to the comments in the
Finix examples.

### 5. Install the Finix configuration

Copy or adapt the selected Finix template into your system configuration and make
sure it includes the generated `hardware-configuration.nix`.

At this point, your configuration under `/mnt/etc/nixos/` should contain the Finix
system configuration together with the hardware configuration generated in the previous step.

Make any other configuration changes you need before proceeding with the installation.

### 6. Install the system

Finally, run the standard NixOS installer as root:

```sh
nixos-install
```

After installation, reboot into the newly installed system.

## Options

### Flakes

- [minimal](./flakes/minimal): the minimal flake contains everything needed to
  boot into a working TTY environment with a network so you can expand the
  configuration as you wish.

- [graphical](./flakes/graphical): basically identical to the `minimal`
  instructions but you get a graphical environment as well, specifically `labwc`
  as a compositor and `foot` as a terminal.

### Channels

- [channels](./channels): equivalent to the `minimal` flake install except it
  uses nix channels instead of flakes.

## General Notes

- While most people should be fine with these installation instructions, you may
  still have to hunt down drivers for network/audio. I suggest checking what
  devices you have and looking for their drivers _before_ running the
  installation step so you don't have to boot back into the live environment.

- Make sure that the NixOS installation boots using UEFI, legacy booting was
  causing issues with `limine` not being detected. If you have a fix please let
  me know.

- I try not to inject any opinions into this configuration. The only choice I
  have made is between `mdevd` and `udev`. I chose `mdevd` simply because that
  is what the other members of the finix community suggested and use.

- Some users get errors from `efibootmgr` after running `nixos-install`. If the
  error code is 8, this can be ignored. It's caused by non-existant boot options
  trying to be added by `efibootmgr`, it fails to add them and returns an error,
  but existing boot entries are added without issue.

- If there are any other problems please either open an issue here or join the
  [discord](https://discord.gg/KKgGN48UtV) and reach out there. Me or others are
  typically available to help.

# Helpful links

[Finix Discord](https://discord.gg/nVe5Zkaypg)

[Finix](https://github.com/finix-community/finix)

[Finix Options Wiki](https://finix-community.github.io/finix/options.html)

[aanderse's Config](https://github.com/aanderse/finix-config)

[Finit](https://github.com/finit-project/finit)
