{ config, pkgs, ... }: {
  home = {
    username = "jonathan";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
