{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      steam = pkgs.steamPackages.steam.overrideAttrs (oldAttrs: {
        postInstall =
          oldAttrs.postInstall
          + ''
            sed -i 's/Exec=steam/Exec=mangohud steam/g' $out/share/applications/steam.desktop
          '';
      });
    };
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    extest.enable = true;
  };

  programs.gamescope.enable = true;
  # programs.gamescope.capSysNice = true;

  programs.gamemode.enable = true;

  environment.systemPackages = [ pkgs.mangohud ];
}
