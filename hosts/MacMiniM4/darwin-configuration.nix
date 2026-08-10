{ inputs, hostName, ... }:
{
  imports = [ inputs.self.darwinModules.system-shared ];

  networking.hostName = hostName;
}
