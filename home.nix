{ pkgs, ... }:

{
  home = {
    username = "rkarsnk";
    homeDirectory = "/Users/rkarsnk";
    stateVersion = "24.11";
  };

  imports = [
    ./modules
  ];

  programs.zsh = { 
    enable = true;
    initExtra = ''
      # 既存設定を読み込む
      if [ -f ~/.zshrc.local ]; then
        source ~/.zshrc.local
      fi
    '';
  };

  home.packages = with pkgs; [
    home-manager
  ];
}
