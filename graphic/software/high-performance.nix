{ pkgs, config, ... }:

{
  imports =
    [
      ./waydroid.nix
      ./.
    ];

  environment.systemPackages = with pkgs; [
    firefox
    config.nur.repos.xddxdd.wechat-uos
    texlive.combined.scheme-full
    jetbrains.idea-ultimate
    android-tools
    jetbrains.pycharm-professional
    # nur-cryolitia.MaaX
    # config.nur.repos.Freed-Wu.netease-cloud-music
    wpsoffice
    config.nur.repos.linyinfeng.wemeet
    obs-studio
    androidStudioPackages.beta
    jetbrains.clion
    libsForQt5.kleopatra
    keepassxc
    #nur-cryolitia.MaaAssistantArknights-beta
    nodePackages.pnpm
    nodePackages.nodejs
    discord
    yesplaymusic
    jetbrains.rust-rover
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    "electron-19.0.7"
    "electron-19.1.9"
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
}
