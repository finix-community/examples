# `nixos-install` Instructions

## It's basically NixOS

Follow the instructions found
[here](https://nixos.wiki/wiki/NixOS_Installation_Guide) up until the "Install
NixOS" section.

## But not quite

After you've partitioned your drives, mounted them, and generated a basic
configuration for NixOS, go into `/mnt/etc` (or really anywhere on the mounted
drive) and clone this repository with

```bash
git clone -b graphical https://codeberg.org/vitrial/finix-config <path>
```

where `<path>` is your desired file directory name, can leave blank for the
default repo name. This will get the config that includes `labwc` and `greetd`.

Enter the directory you just cloned, and make the following edits to files
inside of it:

### `flake.nix`

- Line 21:
  `nixosConfigurations.finixos -> nixosConfigurations.<desired profile name>`

### `finix/configuration.nix`

- Line 78:
  `networking.hostName = "finixos" -> networking.hostName = "<desired host name>"`
- Line 84: `users.users.vitrial = { -> users.users.<desired username> = {`
- Line 87:
  `password = "<hash of 'vitrial'>" -> password = "<hash of desired password>"`
  - `<hash of desired password>` can be generated with the command
    `mkpasswd -m sha-512 '<desired password>'`
  - NOTE: This is not really recommended for long term use but lets just get
    into the system first

NOTE: This config includes vim as the only editor. If you want nano, replace
`vim` with `nano` in the system packages at this time.

### `finix/hardware-configuration.nix`

This is probably the most annoying one. Copy over your
`hardware-configuration.nix` found in `/mnt/etc/nixos/` and strip it down to
only include the options in the version of the file from this repo.

Additionally, you likely need to add
`hardware.firmware = [ pkgs.linux-firmware ]` or something similar to get
wireless connections functioning. I suggest checking your wireless card model
and seeing if there are specific drivers for it at this step.

Lastly, if using `mdevd`, replace each `/dev/disk/by-uuid` with the
corresponding `/dev/sdX#`.

NOTE: Hopefully this `mdevd` issue will be resolved soon. If it has been and
this isn't updated... oops, last step is unneeded.

NOTE 2: Check the [readme](../README.md)

## Actually installing

Now that everything has been configured for your use case, run the following
command, replacing things as needed:

```bash
sudo nixos-install --root /mnt --flake /path/to/flake/directory#<desired profile name>
```

For example, my command is typically

```bash
sudo nixos-install --root /mnt --flake /mnt/etc/finix-config#finixos
```

After rebooting, you should be met with limine with a single entry, booting that
entry will give you a tty with a login screen where you give your username and
the password you hashed earlier

Welcome to finix!

## Post Installation Notes

### You didn't change anything I told you to...

Everything should work mostly as expected. If the `hardware-configuration.nix`
file in this repo worked for you: that's a coincidence, I promise. PLEASE make
your own for future configuration.

The default username and password are both `vitrial`, but that's public
knowledge so I'd definitely change that at some point if I were you.

### "My WiFi card isn't showing up!"

Try what I mentioned above about adding
`hardware.firmware = [ pkgs.linux-firmware ]` to `hardware-configuration.nix`.
This fixes it for me, if it doesn't for you then look into what packages might
have your drivers and add them.

### Password management

Although storing the hash this way is mostly safe, the recommended method for
password management is with `sops`. Checkout
[aanderse's config](https://github.com/aanderse/finix-config) for how he does
it.

### Networking setup

#### WiFi

Follow [these instructions](https://wiki.archlinux.org/title/Iwd#Usage) for
`iwd`.

#### Ethernet

If you're using ethernet or some other non-wireless setup, it should just work,
and you can even remove the `iwd` module and service if you really crave
minimalism.

### Managing your config

I suggest copying wherever you cloned the repo to somewhere like
`~/.config/finixos` so you can edit it as a user without needing `sudo`. You can
rebuild from within that directory with

```bash
nixos-rebuild boot --sudo --flake .#finixos
```

If your host name is the same as your profile name, you don't even need the
`#finixos`.

Also, not mandatory, but back up your config with git in some way!
Reproducibility is king with Nix, and if you lose the folder for your config
then you can't reproduce it anymore. Plus sharing your config is always fun.
