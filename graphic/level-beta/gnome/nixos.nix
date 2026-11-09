{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (lib.elem "gnome" config.features.desktop) {
    system.nixos.tags = [ "Gnome" ];

    services = {
      xserver = {
        enable = true;
        xkb.layout = "cn";
        xkb.variant = "";
        excludePackages = [ pkgs.xterm ];
      };
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
        papirus-icon-theme
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

    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };

    home-manager.users.cryolitia = import ./hm.nix;
  };
}
