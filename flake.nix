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
    # blueprint
    blueprint = {
      url = "github:numtide/blueprint";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, blueprint }:
  let
    pkgs = import nixpkgs {
      system = "aarch64-darwin";
      config.allowUnfree = true;
    };

    username = "rkarsnk";

    commonConfig = import ./nix-darwin/default.nix { inherit self pkgs; };
  in
  {
    packages = {
      aarch64-darwin.default = pkgs.writeShellApplication {
        name = "dotfiles-info";
        runtimeInputs = [ pkgs.coreutils ];
        text = ''
          echo "dotfiles flake"
          echo "hosts: MacBookNeo"
        '';
      };
    };

    devShells = {
      aarch64-darwin.default = import ./devshell.nix { inherit pkgs; };
    };

    darwinModules.host-shared = commonConfig;
    homeModules.home-shared = import ./modules/home/home-shared.nix;

    darwinConfigurations."MacBookNeo" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [
        ./hosts/my-darwin/darwin-configuration.nix
        ./hosts/my-darwin/hosts/MacBookNeo.nix
        commonConfig
      ];
    };

    darwinConfigurations."MacMiniM4" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [
        ./hosts/my-darwin/darwin-configuration.nix
        ./hosts/my-darwin/hosts/MacMiniM4.nix
        commonConfig
      ];
    };

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      extraSpecialArgs = { inherit self; };
      modules = [
        ./home-manager/home.nix
      ];
    };
  };
}
