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
    # WARN: Either import this or import and enable ly's module, if you don't
    # you will be left with an unbootable generation.
    getty
    bash
    dhcpcd
    iwd
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  finit.runlevel = 3;

  services.nix-daemon = {
    enable = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;

  programs = {
    limine = {
      enable = true;
      settings.editor_enabled = true; # NOTE: Disable on systems that need security.
    };

    sudo.enable = true;

    bash.enable = true;
  };

  services = {
    polkit.enable = true;

    # NOTE: If you enabled ly then also enable this, syslogd being ready is one
    # of its service conditions.
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
    packages = with pkgs; [ ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
