{
  lib,
  config,
  ...
}:
{
  services.turnstile = {
    enable = true;
    settings.manage_rundir = "yes";
  };

  programs = {
    pipewire = {
      enable = true;
      alsa.enable = true;
    };
    wireplumber.enable = true;
  };

  hjem.users.<user>.dinit.services = {
    pipewire = {
      type = "process";
      command = "${lib.getExe' config.programs.pipewire.package "pipewire"}";
      restart = true;
      depends-ms = [ "login.target" ];
    };
    pipewire-pulse = {
      type = "process";
      command = "${lib.getExe' config.programs.pipewire.package "pipewire-pulse"}";
      restart = true;
      prepared-by = [ "pipewire" ];
    };
    wireplumber = {
      type = "process";
      command = "${lib.getExe' config.programs.wireplumber.package "wireplumber"}";
      restart = true;
      prepared-by = [ "pipewire-pulse" ];
    };
  };
}
