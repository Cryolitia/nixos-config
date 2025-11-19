{ pkgs, ... }:

{
  system.nixos.tags = [ "Gnome" ];

  services = {
    xserver = {
      enable = true;
      xkb.layout = "cn";
      xkb.variant = "";
      excludePackages = [ pkgs.xterm ];
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-photos
      gnome-tour
      gnome-text-editor
      gedit
      gnome-console
      cheese # webcam tool
      epiphany # web browser
      geary # email reader
      evince # document viewer
      totem # video player
      gnome-calculator
      simple-scan
      gnome-music
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      gnome-contacts
      gnome-maps
      orca
    ]
  );

  users.users.gdm.extraGroups = [
    "gdm"
    "video"
  ];

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  environment.systemPackages =
    (with pkgs; [
      gnome-tweaks
      tela-icon-theme
      xdg-terminal-exec
      nautilus-open-any-terminal
    ])
    ++ (with pkgs.gnomeExtensions; [
      appindicator
      pop-shell
      dash-to-dock
      freon
      caffeine
      blur-my-shell
      night-theme-switcher
      executor
      focused-window-d-bus

      # fcitx5
      kimpanel
    ]);

  programs.gpaste.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  imports = [
    ../software/fcitx5.nix
  ];

  # i18n.inputMethod = {
  #   enable = true;
  #   type = "ibus";
  #   ibus.engines = with pkgs.ibus-engines; [
  #     (rime.override {
  #       rimeDataPkgs = import ../software/rime-data.nix {
  #         inherit config;
  #         inherit pkgs;
  #       };
  #     })
  #     libpinyin
  #   ];
  # };

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };

  # xdg.portal = {
  #   extraPortals = with pkgs; [
  #     #xdg-desktop-portal-gnome
  #   ];
  #   config = {
  #     common = {
  #       default = [
  #         "gtk"
  #       ];
  #       "org.freedesktop.impl.portal.Secret" = [
  #         "gnome-keyring"
  #       ];
  #     };
  #   };
  # };
}
