{
  description = "Akira's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    pkgs = import nixpkgs {
      system = "aarch64-darwin";
      config.allowUnfree = true;
    };

    username = "rkarsnk";

    commonConfig = import ./nix-darwin/default.nix { inherit self pkgs; };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#MacBookNeo
    darwinConfigurations."MacBookNeo" = nix-darwin.lib.darwinSystem {
      modules = [
        commonConfig
        #nix-homebrew.darwinModules.nix-homebrew
      ];
    };
    
    # $ darwin-rebuild build --flake .#MacMiniM4
    darwinConfigurations."MacMiniM4" = nix-darwin.lib.darwinSystem {
      modules = [
        commonConfig
        #nix-homebrew.darwinModules.nix-homebrew
      ];
    };

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      modules = [
        ./home-manager/home.nix
      ];
    };
  };
}
