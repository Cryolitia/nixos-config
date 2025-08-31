{ pkgs, lib, ... }:

{
  systemd.user.services.activate-linux = {
    description = "Activate NixOS";
    wantedBy = [ "graphical-session.target" ];
    path = [ pkgs.activate-linux ];
    serviceConfig = {
      ExecStartPre = ''
        ${pkgs.coreutils-full}/bin/sleep 30
      '';
      ExecStart = ''
        ${lib.getExe pkgs.activate-linux} -x 400 -y 80 -t "         NixOS Insider Preview" -m "Evaluation Copy. Build ${lib.version}" -f "Sarasa Mono SC"
      '';
      Restart = "on-failure";
      RestartSec = 30;
    };
  };
}
