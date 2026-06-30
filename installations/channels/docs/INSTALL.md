# Installation Instructions

## First steps

Boot into a NixOS live USB and follow the instructions [here](https://nixos.wiki/wiki/NixOS_Installation_Guide) up until (and not including) the "Create NixOS config" step.

I suggest using the GUI version over minimal because there are various long strings of text you might have to type/copy-paste, including a `sha-512` hash.

## Finix Specific Steps

### Config file setup

To begin this section, most commands will require root access, so run `sudo -i` now.

Once all your drives have been created and mounted, run the command `mkdir -p /mnt/etc/nixos` to create the directory we will work in and then run `cd /mnt/etc/nixos` to enter it.

Next, run `nixos-generate-config --root /mnt --show-hardware-configuration > ./hardware-configuration.nix`

Then open this file in your preferred editor, delete the `imports = [ ... ];` section at the beginning, keeping all of the `boot` options for kernel modules, and removing every option below the `fileSystems` and `swapDevices` options. Lastly, change each `device = "/dev/disk/by-uuid/..."` option to the corresponding `device = "/dev/sdXy"` option.

While you're in `hardware-configuration.nix`, I wouldn't hestitate to add the line
```nix
hardware.firmware = [ pkgs.linux-firmware ];
```
to make sure you have the firmware you need.

You can look at an example of what this file *might* look like [here](https://codeberg.org/vitrial/finix-config/src/branch/main/finix/hardware-configuration.nix).
Do *NOT* copy this file directly, it might work but I can make no guarantees as to long term system stability.

After saving your file, we will clone this repository onto the system and into the directory `/mnt/etc/finix` with the following command:
```bash
git clone https://codeberg.org/vitrial/finix-channel-install ../finix
```

After cloning, run the command
```bash
cp -r /mnt/etc/finix/* ./
```
to copy this repo into the nixos directory. You can also delete the `/mnt/etc/finix` directory now if you wish.

Now, you can edit `configuration.nix` to your liking. There are a few options for network setup, preferred editors, sudo/doas, as well as anything else you want to add. I suggest changing anything past the ones I specified after installation.

Lastly for configuration, customize the `user.user.vitrial` entry to match your preferences. `vitrial` should be changed to your username, `password` is a `sha-512` hash of your password. This can be generated via
```bash
mkpasswd -m sha-512 '<password>'
```
where `<password>` is your desired password. Copying and pasting this hash is the main reason I suggest the GUI NixOS installer. However, I do suggest doing your password imperatively and not storing the hash in the nix store so you can just leave the hash here for the first boot, then change it according to the [post-installation notes](#Post-installation-notes)

### Setting up channels

Run these three commands:
```bash
nix-channel --add https://channels.nixos.org/nixos-unstable nixos
nix-channel --add https://github.com/finix-community/finix/archive/refs/heads/main.tar.gz finix
nix-channel --update
```

This will setup the installer to pull from the correct places when it runs.

### Finally installing

Now, run the following command:

```bash
nixos-install --root /mnt --file /mnt/etc/nixos/system.nix --channel /nix/var/nix/profiles/per-user/root/channels
```

### Post-installation instructions

If you get an error involving `efibootmgr` at the end, specifically error code `8`, then you can likely ignore it. Some motherboards add boot entries that aren't real and this causes a "Failed successfully" kind of return for `nixos-install`.

Redo the above steps about [setting up channels](#Setting-up-channels) after rebooting to ensure they are set correctly on your machine.

### Post-installation notes

Default username and password if you didn't change anything are both `vitrial`.

It is suggested that you remove the password field from the configuration file, rebuild, and run `sudo passwd <username>` to set your password so it isn't hashed in plaintext in the nix store.

Make sure you know how to setup your network if you are using WiFi, check the Arch Wiki for whichever program you chose.
