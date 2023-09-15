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
        nur-cryolitia.MaaAssistantArknights-beta
        nur-cryolitia.MaaX
        # config.nur.repos.Freed-Wu.netease-cloud-music
  ];
}