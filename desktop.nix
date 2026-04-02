{
  config,
  pkgs,
  lib,
  ...
}: let
  simpleFiles = {
    ".config/noctalia/colors.json" = "noctalia/colors.json";
    ".config/noctalia/plugins.json" = "noctalia/plugins.json";
    ".config/noctalia/settings.json" = "noctalia/settings.json";
    ".config/noctalia/user-templates.toml" = "noctalia/user-templates.toml";
  };

  fileAttrs =
    lib.mapAttrs (target: src: {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/config/${src}";
    }) simpleFiles;

  configDirs = [
    "kitty"
    "niri"
    "xkb"
  ];
in {
  home = {
    packages = with pkgs; [
      brightnessctl
      playerctl
    ];
    file = fileAttrs // dirAttrs;
  };
}