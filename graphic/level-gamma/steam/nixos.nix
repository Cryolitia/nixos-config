{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      steam-unwrapped = pkgs.steam-unwrapped.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          substituteInPlace "$out/share/applications/steam.desktop" \
            --replace-fail 'Exec=steam' 'Exec=mangohud steam'
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
