# WARN: Only set the options defined here.
{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # WARN: If you dont set this you potentially won't be able to boot your machine.
  hardware.firmware = [ pkgs.linux-firmware ];

  # TODO: Replace this with your actual filesystem layout.
  fileSystems = {
    "/" = {
      device = "/dev/sda2";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/sda1";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  swapDevices = [ ];
}
