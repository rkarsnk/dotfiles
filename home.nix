{ pkgs, ... }:

{
  home.username = "rkarsnk";
  home.homeDirectory = "/Users/rkarsnk";

  home.stateVersion = "24.11";

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
    hello
    home-manager
  ];
}
