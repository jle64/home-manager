{
  config,
  pkgs,
  lib,
  ...
}: let

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
    "bash"
    "fish"
    "kitty"
    "nushell"
    "nvim"
    "sh"
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

    file = fileAttrs // dirAttrs;
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
      defaultEditor = true;
    };
    starship = import lib/starship.nix;
    git = import lib/git.nix;
  };
}
