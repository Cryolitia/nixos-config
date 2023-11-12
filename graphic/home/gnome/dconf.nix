{ lib, config, ... }:
let

  mkTuple = lib.hm.gvariant.mkTuple;

in
{

  "org/gnome/desktop/background" = {
    picture-uri = toString ../../background/1.jpg;
    picture-uri-dark = toString ../../background/4.jpeg;
    primary-color = "#000000000000";
    secondary-color = "#000000000000";
  };

  "org/gnome/desktop/input-sources" = {
    show-all-sources = true;
    sources = [ (mkTuple [ "ibus" "rime" ]) ];
  };

  "org/gnome/desktop/interface" = {
    #gtk-theme = "Nordic";
    cursor-theme = "Adwaita";
    icon-theme = "Adwaita";
    clock-show-weekday = true;
    font-name = "更纱黑体 SC 11";
    document-font-name = "Source Han Serif 11";
    monospace-font-name = "JetBrainsMono Nerd Font Mono 10";
    titlebar-font = "更纱黑体 SC Bold 11";
    show-battery-percentage = true;
  };

  "org/gnome/desktop/screensaver" = {
    picture-uri = toString ../../background/1.jpg;
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
  };

  "org/gnome/settings-daemon/plugins/media-keys" = {
    custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    binding = "<Super>t";
    command = "kitty";
    name = "kitty";
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
      "gsconnect@andyholmes.github.io"
      "caffeine@patapon.info"
      "freon@UshakovVasilii_Github.yahoo.com"
      "blur-my-shell@aunetx"
      "nightthemeswitcher@romainvigier.fr"
    ];

    favorite-apps = [
      "kitty.desktop"
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
