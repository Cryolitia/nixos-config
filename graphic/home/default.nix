{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:

let
  rimeConfig = ../../dotfiles/rime/default.custom.yaml;
  rimeDict = ../../dotfiles/rime/my.dict.yaml;
  rimeIce = ../../dotfiles/rime/rime_ice.custom.yaml;

  vscodeConfig = import ./vscode.nix { inherit pkgs; };
in
{
  imports = [
    ../../common/home.nix
    ./fcitx5.nix
  ]
  ++ lib.optionals osConfig.services.desktopManager.gnome.enable [ ./gnome ]
  ++ lib.optionals osConfig.programs.niri.enable [ ./niri ];

  home.sessionVariables = {
    GTK_THEME = "Arc-Dark";
    QT_STYLE_OVERRIDE = "Nordic-Polar";
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/Code/User/settings.json".source = vscodeConfig;

    ".config/ibus/rime/default.custom.yaml".source = rimeConfig;
    ".local/share/fcitx5/rime/default.custom.yaml".source = rimeConfig;
    ".config/ibus/rime/my.dict.yaml".source = rimeDict;
    ".local/share/fcitx5/rime/my.dict.yaml".source = rimeDict;
    ".config/ibus/rime/rime_ice.custom.yaml".source = rimeIce;
    ".local/share/fcitx5/rime/rime_ice.custom.yaml".source = rimeIce;

    ".face".source = ../face.jpg;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    font.name = "更纱黑体 SC 11";
  };

  qt.style.name = "Nordic-Polar";

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    shellIntegration.enableZshIntegration = true;
    themeFile = "Catppuccin-Frappe";
    extraConfig = ''
      background_opacity 0.8
      wayland_titlebar_color background
      map ctrl+c copy_or_interrupt
      map ctrl+v paste_from_clipboard
    '';
  };

  home.file.".config/maa".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/maa";

  home.file."Documents/template.tex".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/template.tex";
  home.file."Documents/template.typ".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/template.typ";
}
