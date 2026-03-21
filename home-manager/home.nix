{ config, pkgs, ... }:
{
  home.username = "rkarsnk";
  home.homeDirectory = "/Users/rkarsnk";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ./zsh/zshrc;
  };

  home.file = {
    ".config/ghostty/config".source = ./ghostty/config;
    ".config/karabiner/karabiner.json".source = ./karabiner/karabiner.json;
    ".config/karabiner/assets/complex_modifications".source = ./karabiner/assets/complex_modifications;

  }; 

  home.packages = [
     pkgs.hello
  ];
}
