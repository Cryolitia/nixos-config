{ config, pkgs, ... }:

{
  imports =
    [
      ./syncthing.nix
      ../../../graphic/software/waydroid.nix
      ../../../graphic/software
      ./develop
      # ./hadoop.nix
    ];

  environment.systemPackages = with pkgs; [
    firefox
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
    libsForQt5.kleopatra
    keepassxc
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    "electron-19.0.7"
    "electron-19.1.9"
  ];

  systemd.services.HPLidKeyCode = {
    description = "Prevent HP laptop to toggle airplane mode when lip close.";
    serviceConfig = {
      Type = "oneshot";
      Restart = "no";
      ExecStart = "${pkgs.kbd}/bin/setkeycodes e057 240 e058 240";
    };
    wantedBy = [
      "rescue.target"
      "multi-user.target"
      "graphical.target"
    ];
  };
}
