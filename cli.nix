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
    ".inputrc" = "readline/inputrc";
    ".profile" = "bash/profile";
    ".ssh/config" = "ssh/config";
    ".config/fish/conf.d" = "fish/conf.d";
    ".config/fish/functions" = "fish/functions";
    ".config/fish/fish_plugins" = "fish/fish_plugins";
    ".config/nvim/init.lua" = "nvim/init.lua";
  };

  fileAttrs =
    lib.mapAttrs (target: src: {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/config/${src}";
    }) simpleFiles;

  configDirs = [
    "bash"
    "nushell"
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
      fishPlugins.fzf
      fishPlugins.git-abbr
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
      nushellPlugins.skim
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
    zoxide.enable = true;
    fish.enable = true;
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;
    };
    skim.enableFishIntegration = true;
    starship = import lib/starship.nix;
    git = import lib/git.nix;
  };
}
