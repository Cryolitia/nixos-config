{ pkgs, lib, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = false;
      };

      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 3;
          brightness = 0.5;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$USER";
          font_size = 48;
          font_family = "Monospace";
          color = "rgb(236,239,244)";

          position = "0, 0%";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "$TIME";
          font_size = 90;
          font_family = "DINish";
          color = "rgb(236,239,244)";

          position = "0, -15%";
          halign = "center";
          valign = "top";
        }
        {
          monitor = "";
          text = "cmd[update:60000] date --rfc-3339=date";
          font_size = 25;
          font_family = "DINish";
          color = "rgb(236,239,244)";

          position = "0, -10%";
          halign = "center";
          valign = "top";
        }
        {
          monitor = "";
          text = "NixOS Insider Preview";
          font_size = 18;
          font_family = "Monospace";
          color = "rgba(216,222,233,0.5)";

          position = "-1%, 5%";
          halign = "right";
          valign = "bottom";
        }
        {
          monitor = "";
          text = "Evaluation Copy. Build ${lib.version}";
          font_size = 18;
          font_family = "Monospace";
          color = "rgba(216,222,233,0.5)";

          position = "-1%, 2%";
          halign = "right";
          valign = "bottom";
        }
      ];
      image = {
        monitor = "";
        path = "${./nix-snowflake-rainbow.png}";
        size = 150;
        rounding = 0;
        border_size = 0;
        border_color = "rgba(0, 0, 0, 0.0)";

        position = "2%, 2%";
        halign = "left";
        valign = "bottom";
      };

      input-field = {
        monitor = "";
        size = "20%, 5%";
        outline_thickness = 3;
        inner_color = "rgba(0, 0, 0, 0.0)"; # no fill

        outer_color = "rgba(91,206,250,0.5) rgba(245,169,184,0.5) 330deg";
        check_color = "rgba(254,244,51,0.5) rgba(154,89,207,0.5) 120deg";
        fail_color = "rgba(191,97,106,0.5)";

        font_color = "rgb(216,222,233)";
        fade_on_empty = false;
        rounding = 15;

        font_family = "Monospace";
        placeholder_text = "Input password...";
        fail_text = "$PAMFAIL";

        dots_spacing = 0.3;

        position = "0, -10%";
        halign = "center";
        valign = "center";
      };
    };
  };

  services.swayidle = {
    enable = true;
    systemdTarget = "niri.service";
    extraArgs = [
      "-w"
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.systemd}/bin/loginctl lock-session && sleep 5";
      }
      {
        event = "lock";
        command = "${pkgs.systemd}/bin/systemd-run -u hyprlock --service-type=exec --user ${lib.getExe pkgs.hyprlock} --grace 0";
      }
    ];
  };
}
