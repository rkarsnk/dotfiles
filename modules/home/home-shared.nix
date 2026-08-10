{ pkgs, osConfig ? null, ... }:
let
  hasDarwinVim = osConfig != null && osConfig ? programs && osConfig.programs.vim.enable && pkgs.stdenv.isDarwin;
in
{
  # only available on linux, disabled on macos
  services.ssh-agent.enable = pkgs.stdenv.isLinux;

  home.packages =
    [
      pkgs.ripgrep
      pkgs.hello
    ]
    ++ (
      # you can access the host configuration using osConfig when available.
      pkgs.lib.optionals hasDarwinVim [ pkgs.skhd ]
    );

  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ../../home-manager/zsh/zshrc;
  };

  imports = [
    ./files
    ./programs/zsh.nix
    ./programs/ghostty.nix
    ./programs/karabiner.nix
    ./programs/opencode.nix
  ];

  home.stateVersion = "26.05";
}
