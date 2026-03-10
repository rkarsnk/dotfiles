{ pkgs, ... }:

{
  home = {
    username = "rkarsnk";
    homeDirectory = "/Users/rkarsnk";
    stateVersion = "24.11";
  };

  imports = [
    ./editors
#    ./shells
  ];

  programs.zsh = { 
    enable = true;
    initContent = ''
      # 既存設定を読み込む
      if [ -f ~/.zshrc.local ]; then
        source ~/.zshrc.local
      fi
    '';
  };

  home.packages = with pkgs; [
    home-manager
    tree
  ];
}
