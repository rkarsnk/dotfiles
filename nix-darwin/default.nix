{ self, pkgs }:
{ 
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
      pkgs.vim
      pkgs.home-manager
      pkgs.fastfetch
      pkgs.yt-dlp
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  nix.enable = false;

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  system = {
    primaryUser = "rkarsnk";

    defaults = {
      # ファイルの拡張子を表示する
      #NSGlobalDomain.AppleShowAllExtensions = true;
 
      finder = {
        # デスクトップにドライブのアイコンを表示しない
        ShowHardDrivesOnDesktop = false;
        ShowExternalHardDrivesOnDesktop = false;
        ShowRemovableMediaOnDesktop = false;
        # ファイルの拡張子を表示する
        #AppleShowAllExtensions= true;
        # 隠しファイルを表示する
        #AppleShowAllFiles = true;
        # デスクトップにアイコンを表示しない
        CreateDesktop = false;
        # カラム表示をデフォルトにする
        FXPreferredViewStyle= "clmv";
        # 新しいウィンドウのターゲットをHOMEにする
        NewWindowTarget = "Home";
      };
      dock = {
        autohide = true;
        show-recents = false;
        orientation = "left";
      };
    };
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  imports = [
    ./homebrew.nix
  ];

  fonts = {
    packages = with pkgs; [
      plemoljp-nf
      udev-gothic-nf
    ];
  };
}
