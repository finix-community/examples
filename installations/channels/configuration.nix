{ config, pkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.pkgs = import <nixpkgs> { };

  boot.loader.efi.canTouchEfiVariables = true;

  services.nix-daemon.enable = true;

  programs.limine = {
    enable = true;
    settings.editor_enabled = true;
  };

  programs.sudo.enable = true;
  # programs.doas.enable = true;

  programs.bash.enable = true;

  security.pam.environment = {
    NIX_PATH.default = "/root/.nix-defexpr/channels:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels";
  };

  services.dbus.enable = true;

  # Network options
  services.iwd.enable = true; # cli network manager
  # services.networkmanager.enable = true; # requires udev instead of mdev
  # services.dhcpcd.enable = true; #best for ethernet

  services.sysklogd.enable = true;

  services.mdevd.enable = true;

  time.timeZone = "America/New_York";

  networking.hostName = "finix";

  users.users.vitrial = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "$6$caDmJ4T2oF09Nrf6$XsQ9KDtgduEul9gzFmLjSZ.aypOKiQWuCicZIGcxPdpVNkGmF1AzNFCyR1u4yeEyZ9ryR8tgx8/u9mTyoGI1v/";
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    # nano
    # micro
    # emacs
    nixos-rebuild-ng
    iputils
    iproute2
  ];
}
