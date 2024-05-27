{ pkgs, config, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    extest.enable = true;

    package = pkgs.steam.override {
      extraPkgs =
        # https://github.com/NixOS/nixpkgs/issues/178121
        pkgs: config.fonts.packages;
    };
  };

  programs.gamescope.enable = true;
  # programs.gamescope.capSysNice = true;

  programs.gamemode.enable = true;
}
