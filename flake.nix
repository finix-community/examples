{
  description = "Finix Community Templates";

  outputs =
    { self }:
    let
      mkWelcomeText =
        {
          name,
          description,
          path,
          buildTools ? null,
          additionalSetupInfo ? null,
        }:
        {
          inherit path;

          description = name;

          welcomeText = ''
            # ${name}
            ${description}
          '';
        };
    in
    {
      templates = {
        installation-minimal = mkWelcomeText {
          name = "Minimal Installation Template";
          description = ''
            A sanely minimal config for finix
          '';
          path = ./installations/flakes/minimal;
        };
      };
      installation-graphical = mkWelcomeText {
        name = "Minimal Installation Template";
        description = ''
          A sanely minimal config for finix (with graphics)
        '';
        path = ./installations/flakes/graphical;
      };
      installation-channels = mkWelcomeText {
        name = "Minimal Installation Template";
        description = ''
          A sanely minimal config for finix using channels
        '';
        path = ./installations/channels;
      };
    };
}
