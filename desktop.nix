{
  config,
  pkgs,
  lib,
  ...
}: let
  simpleFiles = {
    ".local/state/noctalia/settings.toml" = "noctalia/settings.toml";
  };

  fileAttrs =
    lib.mapAttrs (target: src: {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/config/${src}";
    }) simpleFiles;

  configDirs = [
    "kitty"
    "mango"
    "niri"
  ];

  dirAttrs =
    lib.genAttrs
    (map (n: ".config/${n}") configDirs)
    (path: {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/config/${builtins.baseNameOf path}";
    });
in {
  home = {
    packages = with pkgs; [
      brightnessctl
      playerctl
    ];
    file = fileAttrs // dirAttrs;
  };
}
