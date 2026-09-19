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

    taps = [
         {
	    name = "openai/tools"; 
   	    trusted = true;
	 }
    ];

    brews = [
      "colima"
      "docker"
      "docker-compose"
      "cocot"
      "openai/tools/softnet"
      "openai/tools/tart"
    ];

    casks = [
      "visual-studio-code"
      "ghostty"
      "macskk"
      "zed"
      "drawio"
      "karabiner-elements"
      "1password"
      "claude-code@latest"
    ];
  };
}
