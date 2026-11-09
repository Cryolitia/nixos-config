{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  home-manager.users.cryolitia.imports = [ ./hm.nix ];
}
