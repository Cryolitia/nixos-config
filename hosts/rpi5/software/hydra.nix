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

  systemd.services.hydra-evaluator.environment.GC_DONT_GC = "true"; # REF: <https://github.com/NixOS/nix/issues/4178#issuecomment-738886808>

  nix.extraOptions = ''
    allowed-uris = https://github.com/ github: https://api.github.com/
  '';
}
