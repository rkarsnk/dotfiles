{ inputs, ... }:
{
  _module.args.hostName = "MacBookNeo";

  imports = [ inputs.self.homeModules.home-shared ];
}
