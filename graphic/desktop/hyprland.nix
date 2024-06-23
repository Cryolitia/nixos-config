{ inputs, pkgs, ... }:

{
  imports = [
    ./sddm.nix
    ../software/fcitx5.nix
  ];

  system.nixos.tags = [ "hyprland" ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = (
    with pkgs;
    [
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
      networkmanagerapplet
      libsecret
      cliphist
      hyprshot
      satty
    ]
  );
}
