{ config, pkgs, ... }:

{
  imports =
    [
        ./syncthing.nix
        ../../../graphic/software/waydroid.nix
        ../../../graphic/software
    ];

    environment.systemPackages = with pkgs; [
        firefox
        qq
        config.nur.repos.xddxdd.wechat-uos
        texlive.combined.scheme-full
        jetbrains.idea-ultimate
        android-tools
        jetbrains.pycharm-professional
        #nur-cryolitia.MaaX
        # config.nur.repos.Freed-Wu.netease-cloud-music
        wpsoffice
        config.nur.repos.linyinfeng.wemeet
        obs-studio
        androidStudioPackages.beta
        jetbrains.clion
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    "electron-19.0.7"
    "electron-19.1.9"
  ];
}