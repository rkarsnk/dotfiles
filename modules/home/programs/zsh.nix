{ ... }:
{
  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ../../../home-manager/zsh/zshrc;
  };
}
