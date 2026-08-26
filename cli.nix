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
    ".config/starship.toml" = "starship.toml";
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
      htop
      ipcalc
      jjui
      jq
      jujutsu
      just
      k9s
      krew
      kubectl
      kubectx
      kubernetes-helm
      lftp
      lnav
      mtr
      ncdu
      nmap
      notmuch
      nushell
      nushellPlugins.skim
      pandoc
      progress
      pv
      pwgen
      rclone
      ripgrep
      rsync
      sassc
      senpai
      sops
      shellcheck
      skim
      strace
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
    nix-index.enable = true;
    nix-index.enableFishIntegration = true;
    nix-index.enableBashIntegration = true;
    nix-index-database.comma.enable = true;

    zoxide.enable = true;
    fish.enable = true;
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;
      withRuby = false;
      withPython3 = false;
    };
    skim.enableFishIntegration = true;
    starship.enable = true;
    git = import lib/git.nix;
  };

  xdg.configFile."nvim/init.lua".source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/config/nvim/init.lua");
}
