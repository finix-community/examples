{
  config,
  modules,
  pkgs,
  ...
}:
{
  imports = with modules; [
    # WARN: Check out the comments in this file too.
    ./hardware-configuration.nix

    nix-daemon
    openssh
    sysklogd
    limine
    sudo
    polkit
    # WARN: Either import and enable this or any login manager, if you don't you
    # will be left with an unbootable generation.
    getty
    bash
    dhcpcd
    iwd
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  finit.runlevel = 3;

  boot.loader.efi.canTouchEfiVariables = true;

  programs = {
    limine = {
      enable = true;
      settings.editor_enabled = true; # NOTE: Disable on systems that need security.
    };

    sudo.enable = true;

    bash.enable = true;
  };

  security.pam.environment = {
    NIX_PATH.default = "/root/.nix-defexpr/channels:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels";
  };

  services = {
    nix-daemon = {
      enable = true;
      settings = {
        trusted-users = [
          "root"
          "@wheel"
        ];
      };
    };

    sysklogd.enable = true;

    dbus.enable = true;

    mdevd.enable = true;

    # WARN: Are you sure you don't want to enable this? You'll have to configure
    # stuff like DNS manually to be able to access the internet.
    dhcpcd.enable = true;
    iwd.enable = true;
  };

  # TODO: Define hostname.
  networking.hostName = "<HOSTNAME>";

  # TODO: Set timezone.
  time.timeZone = "<TIMEZONE>";

  # TODO: Define your user. Create a password with:
  # $ mkpasswd --method=yescrypt
  users.users."<USERNAME>" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    # WARN: Don't forget to set a hashed password here or you'll face the consequences
    # of your actions.
    password = "<HASHED_PASSWORD>";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    iputils
    iproute2
    # NOTE: You can get rid of this if you use nh but be aware you need either of
    # them to rebuild your system...
    nixos-rebuild-ng
  ];
}
