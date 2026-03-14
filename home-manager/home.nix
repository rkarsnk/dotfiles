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

  home.packages = [
     pkgs.hello
  ];
}
