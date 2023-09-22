{ lib, config, pkgs, osConfig, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = lib.mkIf osConfig.services.xserver.desktopManager.gnome.enable {

    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/cryolitia/nixos-config/graphic/background/1.jpg";
      picture-uri-dark = "file:///home/cryolitia/nixos-config/graphic/background/1.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///home/cryolitia/nixos-config/graphic/background/1.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "pop-shell@system76.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "GPaste@gnome-shell-extensions.gnome.org"
        "gsconnect@andyholmes.github.io"
        "caffeine@patapon.info"
        "freon@UshakovVasilii_Github.yahoo.com"
      ];
      favorite-apps = [
        "org.gnome.Console.desktop"
        "google-chrome.desktop"
        "code.desktop"
      ];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Nordic";
    };

    "org/gnome/desktop/interface" = {
      gtk-theme = "Nordic";
      cursor-theme = "Adwaita";
      icon-theme = "Adwaita";
    };

    "org/gnome/desktop/wm/preferences" = {
      theme = "Nordic";
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      show-trash = false;
      show-mounts = true;
      show-mounts-only-mounted = false;
      show-mounts-network = true;
      apply-custom-theme = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      font-name = "更纱黑体 SC 11";
      document-font-name = "Source Han Serif 11";
      monospace-font-name = "JetBrainsMono Nerd Font Mono 10";
      titlebar-font = "更纱黑体 SC Bold 11";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/input-sources" = {
      show-all-sources = true;
      sources = [ (mkTuple [ "ibus" "rime" ]) ];
    };

    "org/gnome/desktop/session" = {
      idle-delay = 900;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };
    "org/gnome/desktop/screensaver" = {
      lock-enabled = true;
    };

    "org/gnome/shell/extensions/freon" = {
      hot-sensors = [
        "__max__"
        "in0"
        "Composite"
      ];
      use-drive-udisks2 = true;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      sort-directories-first = true;
    };

  };

}
