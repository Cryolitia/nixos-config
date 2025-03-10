{ lib, pkgs, ... }:
let

  mkTuple = lib.hm.gvariant.mkTuple;
in
{

  "org/gnome/desktop/background" = {
    picture-uri = "${../../background}/5.jpg";
    picture-uri-dark = "${../../background}/4.jpeg";
    primary-color = "#000000000000";
    secondary-color = "#000000000000";
  };

  "org/gnome/desktop/input-sources" = {
    show-all-sources = true;
    sources = [
      (mkTuple [
        "ibus"
        "rime"
      ])
    ];
  };

  "org/gnome/desktop/interface" = {
    #gtk-theme = "Nordic";
    cursor-theme = "Adwaita";
    icon-theme = "Tela";
    clock-show-weekday = true;
    document-font-name = "Source Han Serif 11";
    monospace-font-name = "JetBrainsMono Nerd Font Mono 10";
    titlebar-font = "更纱黑体 SC Bold 11";
    show-battery-percentage = true;
  };

  "org/gnome/desktop/peripherals/touchpad" = {
    tap-to-click = true;
  };

  "org/gnome/desktop/screensaver" = {
    picture-uri = "${../../background}/1.jpg";
    primary-color = "#000000000000";
    secondary-color = "#000000000000";
    lock-enabled = true;
  };

  "org/gnome/desktop/session" = {
    idle-delay = 900;
  };

  "org/gnome/desktop/wm/keybindings" = {
    close = [ "<Super>q" ];
  };

  "org/gnome/desktop/wm/preferences" = {
    #theme = "Nordic";
    button-layout = "appmenu:minimize,maximize,close";
  };

  "org/gnome/mutter" = {
    dynamic-workspaces = true;
    workspaces-only-on-primary = true;
  };

  "org/gnome/settings-daemon/plugins/media-keys" = {
    custom-keybindings = [
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
    ];
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    binding = "<Super>t";
    command = "kitty";
    name = "Terminal";
  };

  "org/gnome/settings-daemon/plugins/power" = {
    sleep-inactive-ac-type = "nothing";
  };

  "org/gnome/shell" = {

    disable-user-extensions = false;

    enabled-extensions = [
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "dash-to-dock@micxgx.gmail.com"
      "pop-shell@system76.com"
      "appindicatorsupport@rgcjonas.gmail.com"
      "GPaste@gnome-shell-extensions.gnome.org"
      "caffeine@patapon.info"
      "freon@UshakovVasilii_Github.yahoo.com"
      "blur-my-shell@aunetx"
      "nightthemeswitcher@romainvigier.fr"
      #"executor@raujonas.github.io"
      "focused-window-dbus@flexagoon.com"
    ];

    favorite-apps = [
      "kitty.desktop"
      "dev.warp.Warp.desktop"
      "google-chrome.desktop"
      "code.desktop"
    ];
  };

  "org/gnome/shell/app-switcher" = {
    current-workspace-only = true;
  };

  "org/gnome/shell/extensions/blur-my-shell/applications" = {
    whitelist = [
      "kgx"
      "org.gnome.Console"
    ];
    sigma = 0;
    opacity = 176;
  };

  "org/gnome/shell/extensions/dash-to-dock" = {
    show-trash = false;
    show-mounts = true;
    show-mounts-only-mounted = false;
    show-mounts-network = true;
    apply-custom-theme = false;
    transparency-mode = "DYNAMIC";
    shortcut = [ ];
  };

  # "org/gnome/shell/extensions/executor" = {
  #   left-active = true;
  #   center-active = false;
  #   right-active = false;
  #   left-index = 2;
  #   left-commands-json = builtins.readFile (
  #     (pkgs.formats.json { }).generate "gnome-shell-extension-executor-commands" {
  #       commands = [
  #         {
  #           isActive = true;
  #           command = "get_lrc yesplay --prefix \"\"";
  #           interval = 1;
  #           uuid = "3bec9d24-ac2b-4c43-994a-3012028e78b5";
  #         }
  #       ];
  #     }
  #   );
  # };

  "org/gnome/shell/extensions/freon" = {
    hot-sensors = [
      "__max__"
      "in0"
      "Composite"
    ];
    use-drive-udisks2 = true;
  };

  "org/gnome/shell/extensions/nightthemeswitcher/commands" = {
    enabled = true;
    sunrise = "${pkgs.libnotify}/bin/notify-send -e \"漱正阳而含朝霞\"";
    sunset = "${pkgs.libnotify}/bin/notify-send -e \"有月影 在水面 漂流不定\"";
  };

  "org/gnome/shell/extensions/nightthemeswitcher/gtk-variants" = {
    enabled = true;
    day = "Nordic-Polar";
    night = "Nordic";
  };

  "org/gnome/shell/extensions/nightthemeswitcher/shell-varients" = {
    enabled = true;
    day = "Nordic-Polar";
    night = "Nordic";
  };

  "org/gnome/shell/extensions/user-theme" = {
    name = "Nordic";
  };

  "org/gnome/system/location" = {
    enabled = true;
  };

  "org/gtk/gtk4/settings/file-chooser" = {
    sort-directories-first = true;
  };
}
