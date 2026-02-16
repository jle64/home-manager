{
  config,
  pkgs,
  lib,
  ...
}: let
  profile.d = pkgs.symlinkJoin {
    name = "profile.d";
    paths = [
      ./sh/profile.d
      ./bash/profile.d
      ./zsh/profile.d
    ];
  };

  simpleFiles = {
    ".ansible.cfg" = "ansible/ansible.cfg";
    ".bash_logout" = "bash/bash_logout";
    ".bash_profile" = "bash/bash_profile";
    ".bashrc" = "bash/bashrc";
    ".config/starship.toml" = "starship/starship.toml";
    ".dircolors" = "coreutils/dircolors";
    ".inputrc" = "readline/inputrc";
    ".profile" = "sh/profile";
    ".screenrc" = "screen/screenrc";
    ".shrc" = "sh/shrc";
    ".ssh/config" = "ssh/config";
  };

  fileAttrs =
    lib.mapAttrs (target: src: {source = ./${src};}) simpleFiles;

  configDirs = [
    "fish"
    "git"
    "kitty"
    "nushell"
    "nvim"
    "sway"
    "wezterm"
    "xkb"
    "xonsh"
  ];

  dirAttrs =
    lib.genAttrs
    (map (n: ".config/${n}") configDirs)
    (path: {
      source = ./${builtins.baseNameOf path};
      recursive = true;
    });

  profileDirAttr = {
    ".config/profile.d" = {
      source = profile.d;
      recursive = true;
    };
  };

  customKeys = [
    {
      id = "custom0";
      binding = "<Super>n";
      command = "nautilus";
      name = "Nautilus";
    }
    {
      id = "custom1";
      binding = "<Super>t";
      command = "flatpak run org.mozilla.Thunderbird";
      name = "Thunderbird";
    }
    {
      id = "custom2";
      binding = "<Super>l";
      command = "flatpak run io.gitlab.librewolf-community";
      name = "LibreWolf";
    }
    {
      id = "custom3";
      binding = "<Super>c";
      command = "ptyxis --new-window";
      name = "Console";
    }
    {
      id = "custom5";
      binding = "<Primary>Escape";
      command = "gnome-system-monitor";
      name = "System monitor";
    }
    {
      id = "custom6";
      binding = "<Super>e";
      command = "flatpak run org.gnome.TextEditor";
      name = "Editor";
    }
    {
      id = "custom7";
      binding = "<Super>d";
      command = "bash -c 'gio open https://duckduckgo.com/\"$(wl-paste -p)\"''";
      name = "Duckduckgo";
    }
  ];

  keyPaths = map (k: "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/${k.id}/") customKeys;

  keyAttrs = lib.listToAttrs (
    map (k: {
      name = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/${k.id}";
      value = {
        binding = k.binding;
        command = k.command;
        name = k.name;
      };
    })
    customKeys
  );
in {
  home = {
    username = "jonathan";
    homeDirectory = "/var/home/jonathan";
    stateVersion = "25.11";

    packages = with pkgs; [
      age
      bat
      borgbackup
      direnv
      doggo
      eza
      fd
      fish
      fzf
      jq
      ncdu
      nushell
      pandoc
      pwgen
      ripgrep
      rclone
      rsync
      shellcheck
      skim
      starship
      testssl
      tig
      trash-cli
      ugrep
      xh
      yq
      zellij
      zoxide
    ];

    file = fileAttrs // dirAttrs // profileDirAttr;

    sessionVariables = {EDITOR = "neovim";};
  };

  dconf.settings =
    keyAttrs
    // {
      "org/gnome/settings-daemon/plugins/media-keys" = {custom-keybindings = keyPaths;};
    };

  programs = {
    home-manager.enable = true;
    zoxide.enable = true;
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
