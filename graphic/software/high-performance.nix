{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  jetbrains-with-plugins = import ./jetbrains.nix {
    inherit pkgs;
    inherit inputs;
  };
in
{
  imports = [
    ./waydroid.nix
    ./.
    ../../common/libvirt.nix
    ../../hardware/yubikey.nix
  ];

  environment.systemPackages = with pkgs; [
    firefox
    wechat-uos
    # texlive.combined.scheme-full
    android-tools
    wpsoffice
    obs-studio
    config.boot.kernelPackages.perf
    kdePackages.kleopatra
    keepassxc
    nodePackages.pnpm
    nodePackages.nodejs
    discord
    # yesplaymusic
    # lutris
    scrcpy
    nixpkgs-review
    element-desktop
    distrobox
    thunderbird
    #androidStudioPackages.beta
    #jetbrains-with-plugins.idea-ultimate
    #jetbrains-with-plugins.pycharm-professional
    #jetbrains-with-plugins.rust-rover
    #jetbrains-with-plugins.clion
    snipaste
    localsend
    telegram-desktop
    kdePackages.okular
    hugo
    qq
    mpv
    vlc
    typst
    tinymist
    nur-cryolitia.get-lrc
  ];

  programs.kdeconnect.enable = true;

  programs.clash-verge = {
    enable = true;
    package = pkgs.clash-verge-rev;
    serviceMode = true;
  };

  systemd.user.services.snipaste = {
    wantedBy = [ "graphical-session.target" ];
    path = [ pkgs.snipaste ];
    serviceConfig = {
      ExecStartPre = ''
        ${pkgs.coreutils-full}/bin/sleep 30
      '';
      ExecStart = ''
        ${lib.getExe pkgs.snipaste}
      '';
      Restart = "on-failure";
      RestartSec = 30;
    };
  };

  # pkgs.nur.repos.xddxdd.netease-cloud-music
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    # required by obs-studio
    v4l2loopback
  ];

  virtualisation.podman.enable = true;

  services.flatpak.enable = true;
}
