{
  description = "A partial flake example for audio configuration. Do not use for system";

  inputs = {
    finix.url = "github:finix-community/finix";
    community.url = "github:xzecora/community-modules/dinit-turnstiled";
  };

  outputs =
    {
      self,
      finix,
      community,
      ...
    }:
    {
      nixosConfigurations.finix = finix.lib.finixSystem {
        modules = [
          finix.nixosModules.pipewire
          finix.nixosModules.wireplumber
          {
            hjem.extraModules = [
              community.hjemModules.dinit
            ];
          }
          community.nixosModules.turnstile
        ];
      };
    };
}
