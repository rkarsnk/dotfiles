{ inputs, ... }:
{
  homebrew = {
    enable = true;
    user = inputs.self.lib.username;
    onActivation = {
      upgrade = true;
      autoUpdate = true;
    };
    global.autoUpdate = true;

    brews = [
      "lima"
      "cocot"
    ];

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
