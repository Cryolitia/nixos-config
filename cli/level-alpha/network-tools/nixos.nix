{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    iperf
    doggo
    whois
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  # iperf3
  networking.firewall.allowedTCPPorts = [ 5201 ];
  networking.firewall.allowedUDPPorts = [ 5201 ];
  programs.nexttrace.enable = true;
}
