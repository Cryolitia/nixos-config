{ lib, config, pkgs, ... }:

let
    mkTuple = lib.hm.gvariant.mkTuple;
    jsonFormat = pkgs.formats.json { };
    yamlFormat = pkgs.formats.yaml { };

in

{

    imports = [
        ../common/home.nix
    ];

    dconf.settings = {

        "org/gnome/desktop/background" = {
            picture-uri = "file:///home/cryolitia/nixos-config/graphic/background.jpg";
            picture-uri-dark = "file:///home/cryolitia/nixos-config/graphic/background.jpg";
            primary-color = "#000000000000";
            secondary-color = "#000000000000";
        };
        "org/gnome/desktop/screensaver" = {
            picture-uri = "file:///home/cryolitia/nixos-config/graphic/background.jpg";
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

    home.sessionVariables = {
        GTK_THEME = "Nordic";
        QT_STYLE_OVERRIDE="Nordic";
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
      name = "Nordic";
      package = pkgs.nordic;
    };
  };

}