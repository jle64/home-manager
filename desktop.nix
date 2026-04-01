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
    "DankMaterialShell"
    "hypr"
    "kitty"
    "niri"
    "sway"
    "wezterm"
    "xkb"
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
      (writeShellScriptBin "shell-ipc" ''
        TARGET=$1
        ACTION=$2

        if pgrep -f "noctalia-shell" > /dev/null || pgrep -x "qs" > /dev/null; then
            case "$TARGET" in
                spotlight)   TARGET="launcher"; ACTION="toggle" ;;
                clipboard)   TARGET="launcher"; ACTION="clipboard" ;;
                processlist) TARGET="systemMonitor"; ACTION="toggle" ;;
                settings)    TARGET="settings"; ACTION="toggle" ;;
                notifications) TARGET="notifications"; ACTION="toggleHistory" ;;
                dankdash)    TARGET="wallpaper"; ACTION="toggle" ;;
                lock)        TARGET="lockScreen"; ACTION="lock" ;;
            esac
            exec qs -c noctalia-shell ipc call "$TARGET" "$ACTION"
        else
            exec dms ipc call "$TARGET" "$ACTION"
        fi
      '')
    ];
    file = fileAttrs // dirAttrs;
  };
}