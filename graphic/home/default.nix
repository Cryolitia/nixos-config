{ inputs, lib, config, pkgs, ... }:

let
  jsonFormat = pkgs.formats.json { };
  yamlFormat = pkgs.formats.yaml { };
in

{

  imports = [
    ../../common/home.nix
    ./gnome.nix
    inputs.anyrun.homeManagerModules.default
  ];

  home.sessionVariables = {
    GTK_THEME = "Arc-Dark";
    QT_STYLE_OVERRIDE = "Nordic";
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

    ".config/Code/User/settings.json".source =
      jsonFormat.generate "vscode-user-settings" {
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
      };

    ".config/ibus/rime/default.custom.yaml".source =
      yamlFormat.generate "rime-settings" {
        "patch" = {
          # 仅使用「雾凇拼音」的默认配置，配置此行即可
          "schema_list" = [
            {
              "schema" = "rime-ice";
            }
          ];
        };
      };
    #".config/ibus/rime/default.custom.yaml".text = ''
    #  patch:
    #    # 仅使用「雾凇拼音」的默认配置，配置此行即可
    #    schema_list:
    #    - schema: rime_ice
    #'';
  };

  gtk = {
    enable = true;
    theme = {
      name = "Arc";
      package = pkgs.arc-theme;
    };
  };

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    shellIntegration.enableZshIntegration = true;
    theme = "Catppuccin-Frappe";
    extraConfig = ''
      background_opacity 0.8
      wayland_titlebar_color background
      map ctrl+c copy_or_interrupt
    '';
  };

  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        #applications
        dictionary
        #kidex
        #randr
        rink
        #shell
        symbols
        translate
        websearch
      ];
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;
    };
  };
}
