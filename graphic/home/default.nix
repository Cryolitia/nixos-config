{
  inputs,
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:

let

  jsonFormat = pkgs.formats.json { };
  yamlFormat = pkgs.formats.yaml { };

  rimeConfig = ../../dotfiles/rime/default.custom.yaml;
  rimeDict = ../../dotfiles/rime/my.dict.yaml;
  rimeIce = ../../dotfiles/rime/rime_ice.custom.yaml;
in
{
  imports =
    [
      ../../common/home.nix
      ./fcitx5.nix
    ]
    ++ lib.optionals osConfig.services.xserver.desktopManager.gnome.enable [ ./gnome ]
    ++ lib.optionals osConfig.services.xserver.desktopManager.plasma6.enable [

    ]
    ++ lib.optionals osConfig.programs.hyprland.enable [
      ./hyprland
      inputs.anyrun.homeManagerModules.default
    ];

  home.sessionVariables = {
    GTK_THEME = "Arc-Dark";
    QT_STYLE_OVERRIDE = "Nordic-Polar";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    EDITOR = "code -n -w";
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

    ".config/Code/User/settings.json".source = jsonFormat.generate "vscode-user-settings" {
      "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "editor.unicodeHighlight.nonBasicASCII" = false;
      "editor.wordWrap" = "on";
      "files.autoSave" = "afterDelay";
      "git.enableSmartCommit" = true;
      "latex-workshop.latex.autoBuild.run" = "never";
      "latex-workshop.view.pdf.viewer" = "tab";
      "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "workbench.colorTheme" = "Material Theme Darker High Contrast";
      "workbench.editor.enablePreview" = false;
      "workbench.preferredDarkColorTheme" = "Material Theme High Contrast";
      "workbench.preferredLightColorTheme" = "Material Theme Lighter High Contrast";
      "glassit.alpha" = 220;
      "workbench.iconTheme" = "eq-material-theme-icons";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = "nixpkgs-fmt";
          };
        };
      };
      "debug.javascript.autoAttachFilter" = "onlyWithFlag";
      "git.autofetch" = false;
      "latex-workshop.latex.recipe.default" = "latexmk (xelatex)";
      "files.insertFinalNewline" = true;
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[markdown]" = {
        "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
      };
      "[html]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "editor.unicodeHighlight.allowedLocales" = {
        zh-hans = true;
      };
    };

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
      name = "Arc";
      package = pkgs.arc-theme;
    };
    font.name = "更纱黑体 SC 11";
  };

  qt.style.name = "Nordic-Polar";

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    shellIntegration.enableZshIntegration = true;
    theme = "Catppuccin-Frappe";
    extraConfig = ''
      background_opacity 0.8
      wayland_titlebar_color background
      map ctrl+c copy_or_interrupt
      map ctrl+v paste_from_clipboard
    '';
  };

  home.file.".config/maa".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/maa";

  home.file."Documents/template.tex".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/template.tex";
  home.file."Documents/template.typ".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/template.typ";
}
