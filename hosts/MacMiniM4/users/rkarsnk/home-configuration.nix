{ inputs, ... }:
{
  imports = [ inputs.self.homeModules.home-shared ];

  home.username = "rkarsnk";
  home.homeDirectory = "/Users/rkarsnk";
}
