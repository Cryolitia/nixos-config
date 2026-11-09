{ pkgs, config, ... }:

{

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "Nordic-Polar";
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  home.file = {
    # # Building this configuration will create a copy of 'resources/profile-alpha/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = ../../../resources/profile-alpha/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".face".source = ../../../resources/profile-beta/face.jpg;

    ".config/MangoHud/MangoHud.conf".source = ../../../resources/profile-beta/MangoHud.conf;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    gtk4.theme = null;
    font.name = "更纱黑体 SC 11";
  };

  qt.style.name = "Nordic-Polar";

  home.file."Documents/template.typ".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/resources/profile-beta/template.typ";
}
