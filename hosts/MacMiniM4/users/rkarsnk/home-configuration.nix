{ inputs, ... }:
{
  _module.args.hostName = "MacMiniM4";

  imports = [ inputs.self.homeModules.home-shared ];
}
