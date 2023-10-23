{ inputs, lib, config, pkgs, osConfig, ... }:

lib.mkIf osConfig.programs.hyprland.enable {

  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        dictionary
        rink
        shell
        symbols
        translate
        stdin
      ];
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = null;
    };
    extraCss = ''
      #window {
        background-color: rgba(0, 0, 0, 0);
      }

      box#main {
        border-radius: 10px;
        background-color: alpha(@theme_bg_color,0.5);
      }

      list#main {
        background-color: rgba(0, 0, 0, 0);
        border-radius: 10px;
      }

      list#plugin {
        background-color: rgba(0, 0, 0, 0);
      }

      label#match-desc {
        font-size: 10px;
      }

      label#plugin {
        font-size: 14px;
      }
    '';
  };
}
