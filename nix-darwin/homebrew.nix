{
  ...
}:
{
  homebrew = {
    enable = true;
    user = "rkarsnk";
    onActivation = {
      upgrade = true;
      autoUpdate = true;
      cleanup = "uninstall";
    };
    global.autoUpdate = true;

    
    # List of Homebrew packages and casks to be installed
    brews = [
      "lima"
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
      "1password"
    ];
  };
}

