# Installation Instructions

This directory contains instructions for installing Finix. Finix currently uses
the standard NixOS installation environment and installation tools.

Check for comments annotated with `WARN`, `TODO`, `NOTE`.

## Options

`finix` can be installed and configured using both channels and flakes. Their install
processes can be found below. 

- [flakes](./flakes/)
- [channels](./channels)

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
