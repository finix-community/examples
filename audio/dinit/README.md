# A `turnstiled` and `dinit` based pipewire configuration

This example shows what is needed to get a user level service running pipewire
that launches at user log in and exits at user log out.

_**NOTE:**_ This guide assumes that the user already has `hjem` configured.
Initial `hjem` configuration is outside the scope of this example.

[`audio.nix`](./audio.nix) is a module that can be changed to use the correct
username dropped into your configuration and imported however you import
configuration modules, provided you've imported the correct modules however you
do so.

[`flake.nix`](./flake.nix) is an example flake (that can't be a drop in for your
system) which shows the repo's that need to be used as inputs as well as the
modules to import as well as how to import them if you use flakes. If you use
methods other than flakes, feel free to contribute a configuration for your
preferred method.
