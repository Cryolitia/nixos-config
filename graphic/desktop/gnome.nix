{ config, pkgs, ... }:

{
  system.nixos.tags = [ "Gnome" ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb.layout = "cn";
    xkb.variant = "";
    excludePackages = [ pkgs.xterm ];
  };

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
      gnome-text-editor
      gedit
      gnome-console
    ])
    ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
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

  environment.systemPackages =
    (with pkgs; [
      gnome.gnome-tweaks
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
      desktop-lyric
    ]);

  programs.gpaste.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # imports = [
  #   ../software/fcitx5.nix
  # ];

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      (rime.override {
        rimeDataPkgs = import ../software/rime-data.nix {
          inherit config;
          inherit pkgs;
        };
      })
    ];
  };

  nixpkgs.config.packageOverrides = p: {
    gnome = p.gnome // {
      mutter = pkgs.nur-cryolitia.mutter-text-input-v1;
      gnome-shell =
        (p.gnome.gnome-shell.override { mutter = pkgs.nur-cryolitia.mutter-text-input-v1; }).overrideAttrs
          (oldAttrs: {
            patches = oldAttrs.patches ++ [
              (p.fetchpatch {
                url = "https://gitlab.gnome.org/GNOME/gnome-shell/-/merge_requests/3318.patch";
                hash = "sha256-MWeEaTeL9wkFW/MolG/N8+vMkEi9KTKdwJqqSaNzxF8=";
              })
            ];
          });
      gnome-control-center = p.gnome.gnome-control-center.override {
        mutter = pkgs.nur-cryolitia.mutter-text-input-v1;
      };
    };
  };

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };
}
