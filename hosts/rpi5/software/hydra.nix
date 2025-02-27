{ ... }:

{
  services.hydra = {
    enable = true;
    hydraURL = "http://localhost:3000";
    notificationSender = "hydra@localhost";
    buildMachinesFiles = [ ];
    useSubstitutes = true;
  };

  networking.firewall.allowedTCPPorts = [ 3000 ];

  # REF: https://github.com/NixOS/nix/issues/4178#issuecomment-738886808
  systemd.services.hydra-evaluator.environment.GC_DONT_GC = "true";

  nix.extraOptions = ''
    allowed-uris = https://github.com/ github: https://api.github.com/
  '';
}
