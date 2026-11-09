{ config, lib, ... }:
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.gnome.gcr-ssh-agent.enable = lib.mkIf (
    config.programs.gnupg.agent.enable && config.programs.gnupg.agent.enableSSHSupport
  ) false;
  hjem.users.cryolitia.imports = [ ./hjem.nix ];
}
