{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./profiles/base.nix
    ./profiles/gnome.nix
  ];
}
