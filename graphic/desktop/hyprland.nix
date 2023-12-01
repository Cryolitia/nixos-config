{ inputs, lib, pkgs, config, ... }:

{
  imports = [
    ./sddm.nix
  ];

  system.nixos.tags = [ "hyprland" ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    enableNvidiaPatches = builtins.elem "nvidia" config.services.xserver.videoDrivers;
  };

  environment.systemPackages = (with pkgs; [
    inputs.anyrun.packages.${system}.anyrun-with-all-plugins
    waybar
    dunst
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    pipewire
    wireplumber
    libsForQt5.polkit-kde-agent
    wpaperd
    wl-clip-persist
    udisks
    udiskie
    playerctl
    pavucontrol
    swayosd
    libnotify
    networkmanagerapplet
    libsecret
    cliphist
    hyprshot
    satty
  ]);

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      libsForQt5.fcitx5-qt
      (fcitx5-rime.override {
        rimeDataPkgs = import ../software/rime-data.nix { inherit config; inherit pkgs; };
      })
      fcitx5-nord
      fcitx5-material-color
    ];
  };
}
