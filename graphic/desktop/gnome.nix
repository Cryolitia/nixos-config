{ config, pkgs, ... }:

{

  system.nixos.tags = [ "Gnome" ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    layout = "cn";
    xkbVariant = "";
    excludePackages = [ pkgs.xterm ];
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    gnome-calculator
    gnome-contacts
    gnome-maps
    simple-scan
  ]);

  users.users.gdm.extraGroups = [
    "gdm"
    "video"
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.systemPackages = (with pkgs; [
    gnome.gnome-tweaks
    nordic
    arc-theme
    libnotify
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator
    pop-shell
    dash-to-dock
    gsconnect
    freon
    caffeine
    blur-my-shell
    night-theme-switcher
    (desktop-lyric.overrideAttrs (oldAttrs: rec {
      # https://github.com/tuberry/desktop-lyric/issues/16
      postPatch = ''
        sed -i "s/43/44/g" metadata.json 
      '';
    }
    ))
  ]);

  programs.gpaste.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      (rime.override {
        rimeDataPkgs = with config.nur.repos.linyinfeng.rimePackages;
          withRimeDeps [
            rime-ice
          ];
      })
    ];
  };

}
