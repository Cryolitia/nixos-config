{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server

    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          # https://github.com/NixOS/nixpkgs/issues/162562#issuecomment-1229444338
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils

          # https://github.com/NixOS/nixpkgs/issues/178121
          source-han-sans
        ];
    };

    # fontPackages = [ pkgs.source-han-sans ];
  };

  programs.gamescope.enable = true;
  # programs.gamescope.capSysNice = true;

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [ gamescope ];
}
