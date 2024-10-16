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
    (wechat-uos.override {
      uosLicense = pkgs.fetchurl {
        # https://github.com/NixOS/nixpkgs/pull/305929
        url = "https://aur.archlinux.org/cgit/aur.git/plain/license.tar.gz?h=wechat-uos-bwrap";
        hash = "sha256-U3YAecGltY8vo9Xv/h7TUjlZCyiIQdgSIp705VstvWk=";
      };
    })
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
    vagrant
    thunderbird
    config.nur.repos.xddxdd.netease-cloud-music
    #androidStudioPackages.beta
    jetbrains-with-plugins.idea-ultimate
    jetbrains-with-plugins.pycharm-professional
    jetbrains-with-plugins.rust-rover
    jetbrains-with-plugins.clion
  ];

  # config.nur.repos.xddxdd.netease-cloud-music
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
