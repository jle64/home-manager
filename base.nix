{
  config,
  pkgs,
  lib,
  ...
}: let
  profile.d = pkgs.symlinkJoin {
    name = "profile.d";
    paths = [
      config/sh/profile.d
      config/bash/profile.d
      config/zsh/profile.d
    ];
  };

  simpleFiles = {
    ".ansible.cfg" = "ansible/ansible.cfg";
    ".bash_logout" = "bash/bash_logout";
    ".bash_profile" = "bash/bash_profile";
    ".bashrc" = "bash/bashrc";
    ".dircolors" = "coreutils/dircolors";
    ".inputrc" = "readline/inputrc";
    ".profile" = "sh/profile";
    ".screenrc" = "screen/screenrc";
    ".shrc" = "sh/shrc";
    ".ssh/config" = "ssh/config";
  };

  fileAttrs =
    lib.mapAttrs (target: src: {source = ./config/${src};}) simpleFiles;

  configDirs = [
    "fish"
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
      source = ./config/${builtins.baseNameOf path};
      recursive = true;
    });

  profileDirAttr = {
    ".config/profile.d" = {
      source = profile.d;
      recursive = true;
    };
  };
in {
  home = {
    username = "jonathan";
    stateVersion = "25.11";
    homeDirectory = "/var/home/jonathan";

    packages = with pkgs; [
      age
      aria2
      bat
      borgbackup
      comma
      curl
      devbox
      difftastic
      direnv
      doggo
      dool
      duf
      eza
      fd
      fish
      fishPlugins.bass
      fishPlugins.fzf-fish
      fishPlugins.z
      fzf
      gron
      jj
      jq
      just
      lftp
      lnav
      ncdu
      nmap
      nushell
      pandoc
      progress
      pv
      pwgen
      rclone
      ripgrep
      rsync
      shellcheck
      skim
      starship
      testssl
      tig
      trash-cli
      ugrep
      vimPlugins.vim-plug
      xh
      yq
      yt-dlp
      zellij
      zoxide
    ];

    file = fileAttrs // dirAttrs // profileDirAttr;
    sessionVariables = {EDITOR = "nvim";};
  };

  programs = {
    home-manager.enable = true;
    zoxide.enable = true;
    fish.enable = true;
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    starship = import lib/starship.nix;
    git = import lib/git.nix;
  };
}
