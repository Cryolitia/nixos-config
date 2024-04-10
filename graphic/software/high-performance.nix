{ pkgs, config, inputs, ... }:
let 
  jetbrains-with-plugins = import ./jetbrains.nix { inherit pkgs; inherit inputs; };
in {
  imports =
    [
      ./waydroid.nix
      ./.
    ];

  environment.systemPackages = with pkgs; [
    firefox
    wechat-uos
    texlive.combined.scheme-full
    android-tools
    wpsoffice
    config.nur.repos.linyinfeng.wemeet
    obs-studio
    config.boot.kernelPackages.perf
    libsForQt5.kleopatra
    keepassxc
    nodePackages.pnpm
    nodePackages.nodejs
    discord
    yesplaymusic

    androidStudioPackages.beta
    jetbrains-with-plugins.idea-ultimate
    jetbrains-with-plugins.pycharm-professional
    jetbrains-with-plugins.rust-rover
    jetbrains-with-plugins.clion
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
