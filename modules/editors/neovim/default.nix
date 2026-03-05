{ pkgs, ...};

{
  programs.zsh.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    vimAlias = ture;
    extraConfig = builtins.readFile ./init.vim;

  };
}
