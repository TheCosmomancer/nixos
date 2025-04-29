{ config, pkgs, ... }:
{

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "cosmomancer" ];
  virtualisation.virtualbox.host.enableKvm = true;
  virtualisation.virtualbox.host.addNetworkInterface = false;
}