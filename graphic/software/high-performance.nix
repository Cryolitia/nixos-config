{
  pkgs,
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
  ];

  environment.systemPackages = with pkgs; [
    firefox
    wechat-uos
    # texlive.combined.scheme-full
    android-tools
    wpsoffice
    obs-studio
    config.boot.kernelPackages.perf
    libsForQt5.kleopatra
    keepassxc
    nodePackages.pnpm
    nodePackages.nodejs
    discord
    #yesplaymusic
    # lutris
    scrcpy
    nixpkgs-review
    element-desktop
    distrobox
    #vagrant
    thunderbird
    #androidStudioPackages.beta
    jetbrains-with-plugins.idea-ultimate
    jetbrains-with-plugins.pycharm-professional
    jetbrains-with-plugins.rust-rover
    jetbrains-with-plugins.clion
  ];

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
  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
}
