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

      modules = [./base.nix];
    };
    homeConfigurations."jonathan@sephiroth" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./base.nix ./gaming.nix ./gnome.nix];
    };
  };
}
