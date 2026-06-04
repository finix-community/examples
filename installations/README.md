# Installation Instructions

This directory contains instructions for how to install `finix` in various ways.
Overviews are given here but please read specifics in each directories readme.

## Options

### Flakes

- [minimal](https://github.com/xZecora/finix-minimal): the minimal flake
  contains everything needed to boot into a working TTY environment with a
  network so you can expand the configuration as you wish.
- [graphical](https://github.com/xZecora/finix-graphical): basically identical
  to the `minimal` instructions but you get a graphical environment as well,
  specifically `labwc` as a compositor and `foot` as a terminal.

### Channels

- [channels](https://github.com/xZecora/finix-channels): equivalent to the
  `minimal` flake install except it uses nix channels instead of flakes for
  version control.

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

- Because of issues with `mdevd`, drives must be identified by their ID, eg
  `/dev/sda1`. This causes multi-drive systems to be basically unusable. If you
  want to try this out, just replace `programs.mdevd.enable` with
  `programs.udev.enable` and add the `udev` module.

  - Update on `mdevd`: [@deathbymanatee](https://github.com/deathbymanatee)
    found a mostly working workaround
    [here](https://github.com/finix-community/finix/issues/67) for the `mdevd`
    drive mounting issue. It's not perfect but it does fix the issue while we
    wait on a better fix.

- Some users get errors from `efibootmgr` after running `nixos-install`. If the
  error code is 8, this can be ignored. It's caused by non-existant boot options
  trying to be added by `efibootmgr`, it fails to add them and returns an error,
  but existing boot entries are added without issue.

- If there are any other problems please either open an issue here or join the
  [discord](https://discord.gg/KKgGN48UtV) and reach out there. Me or others are
  typically available to help.

# Helpful links

[Finix Discord](https://discord.gg/KKgGN48UtV)

[Finix](https://github.com/finix-community/finix)

[Finix Options Wiki](https://finix-community.github.io/finix/options.html)

[aanderse Config](https://github.com/aanderse/finix-config)

[Finit](https://github.com/finit-project/finit)
