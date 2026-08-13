{ pkgs, lib, ... }:

{
  services.swayidle = {
    enable = true;
    systemdTargets = [ "niri.service" ];
    extraArgs = [
      "-w"
    ];
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemd-run -u hyprlock --service-type=exec --user ${lib.getExe pkgs.hyprlock} --grace 30 && sleep 30 && ${pkgs.systemd}/bin/loginctl lock-session";
      }
      {
        timeout = 900;
        command = "/usr/bin/env niri msg action power-off-monitors";
      }
    ];
  };
}
