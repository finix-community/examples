{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  finit.runlevel = 3;

  finit.services.nix-daemon = {
    environment.CURL_CA_BUNDLE = config.security.pki.caBundle;
  };

  services.nix-daemon = {
    enable = true;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
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
      settings.editor_enabled = true; # Disable on systems that need security
    };

    sudo.enable = true;

    bash.enable = true;
  };

  services = {
    polkit.enable = true;

    sysklogd.enable = true;

    dbus.enable = true;

    mdevd.enable = true;

    dhcpcd.enable = true;

    iwd.enable = true;
 };

  networking.hostName = "finixos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vitrial = {
    isNormalUser = true;
    description = "test user";
    extraGroups = [ "wheel" ];
    password = "$6$1aOsu4xRRBDJWA3O$yUIEmHIzcJ2KczaW1RcVc6ji.vtCXND57iIqt8NfZHL7326zAViJrTGZriK.e1/5JovKqh/wElp7VmQB2TbLA.";
    packages = with pkgs; [];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    nixos-rebuild-ng
    iputils
    iproute2
  ];
}
