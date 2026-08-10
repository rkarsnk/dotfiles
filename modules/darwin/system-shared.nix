{ flake, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.vim
    pkgs.home-manager
    pkgs.fastfetch
    pkgs.yt-dlp
  ];

  environment.systemPath = [ "/opt/homebrew/bin" ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  nix.enable = false;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = flake.rev or flake.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  system = {
    primaryUser = "rkarsnk";

    defaults = {
      finder = {
        ShowHardDrivesOnDesktop = false;
        ShowExternalHardDrivesOnDesktop = false;
        ShowRemovableMediaOnDesktop = false;
        AppleShowAllFiles = false;
        CreateDesktop = true;
        FXPreferredViewStyle = "clmv";
        NewWindowTarget = "Home";
      };
      dock = {
        autohide = true;
        show-recents = false;
        orientation = "left";
      };
    };
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  imports = [
    ./homebrew.nix
    ./emacs.nix
  ];

  fonts = {
    packages = with pkgs; [
      plemoljp-nf
      udev-gothic-nf
    ];
  };
}
