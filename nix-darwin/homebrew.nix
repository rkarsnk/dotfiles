{
  nix-homebrew,
  ...
}:
{
  nix-homebrew = {
    enable = true;
    user = "rkarsnk";
    enableRosetta = false;
  };

  homebrew = {
    enable = true;
    user = "rkarsnk";
    onActivation = {
      upgrade = true;
      autoUpdate = false;
      cleanup = "uninstall";
    };
    global.autoUpdate = false;

    
    # List of Homebrew packages and casks to be installed
    brews = [
    ];

    # List of Homebrew casks to be installed
    casks = [
      "appcleaner"
      "visual-studio-code"
      "ghostty"
      "macskk"
      "zed"
      "drawio"
      "karabiner-elements"
    ];
  };
}

