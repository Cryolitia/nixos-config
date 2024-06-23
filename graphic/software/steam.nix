{ ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    extest.enable = true;
  };

  programs.gamescope.enable = true;
  # programs.gamescope.capSysNice = true;

  programs.gamemode.enable = true;
}
