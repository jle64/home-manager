{
  description = "Home Manager configuration of jonathan";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    formatter.${system} = pkgs.alejandra;
    homeConfigurations."jonathan" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./base.nix ./cli.nix { home.homeDirectory = "/home/jonathan"; }];
    };
    homeConfigurations."jonathan@cloud" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./base.nix ./cli.nix ./desktop.nix { home.homeDirectory = "/var/home/jonathan"; }];
    };
    homeConfigurations."jonathan@sephiroth" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./base.nix ./cli.nix ./desktop.nix ./gaming.nix ./gnome.nix { home.homeDirectory = "/var/home/jonathan"; }];
    };
  };
}
