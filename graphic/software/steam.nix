{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      steam-unwrapped = pkgs.steam-unwrapped.overrideAttrs (oldAttrs: {
        postInstall = oldAttrs.postInstall + ''
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

  nixpkgs.overlays = [
    (_: super: {
      gamescope = super.gamescope.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [
          (pkgs.fetchpatch {
            url = "https://github.com/ValveSoftware/gamescope/commit/e07c32c6684b56bf969e22a9f04e6a2c1dd95061.patch";
            hash = "sha256-ONjSInJ7M8niL5xWaNk5Z16ZMcM/A7M7bHTrgCFjrts=";
          })
        ];
      });
    })
  ];
}
